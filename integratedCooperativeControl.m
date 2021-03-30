function varargout = integratedCooperativeControl(pos_traj_ref,pos_traj_hat,pos_end,opt_state,opt_scale,lambda,...
                    dot_pos_traj_ref,dot_pos_traj_hat,dot_pos_end,dot_opt_state,dot_opt_scale,dot_lambda,t,current_path)

% load settings
par_load = {'robot_desired','cone','joint_ref_func','envir'};
load([current_path '/data/settings'],par_load{:});
% load initials
var_load = {'robot_num','link_scale','graph_base','angle_inward','safe_con','disp_base_mat_func'};
load([current_path '/data/initials'],var_load{:});
D = graph_base.incidence;
L = graph_base.laplacian;
% control gains
gain_tracking = 0.5;
gain_estimation = 2;
% state split
[disp_end,coef_base,joint] = Mascot.hatSplit(opt_state,[size(pos_end,2),size(pos_end,2)+1,length(robot_desired.link)]);
[dot_disp_end,dot_coef_base,~] = Mascot.hatSplit(dot_opt_state,[size(pos_end,2),size(pos_end,2)+1,length(robot_desired.link)]);
% dot_disp_end = dot_opt_state(:,1:2,:);
% dot_coef_base = dot_opt_state(:,3:5,:);
% dot_joint = dot_opt_state(:,6:end,:);
if isempty(lambda)
    lambda = zeros(robot_num,5);
    dot_lambda = zeros(robot_num,5);
end
nu = lambda(:,1:3); eta = lambda(:,4:end);
% robot controller - estimation
dot_pos_traj_hat = kron(ones(robot_num,1),dot_pos_traj_ref(1:3))...
    -gain_estimation*(pos_traj_hat-kron(ones(robot_num,1),pos_traj_ref(1:3)));
% robot controller - tracking
sig_pos_cen = sig(D'*(pos_end-disp_end),gain_tracking); % sign(D'*q).*abs(D'*q).^alpha;
dot_pos_end = dot_disp_end + dot_pos_traj_hat(:,1:2)...
    -gain_estimation*((pos_end-disp_end)-pos_traj_hat(:,1:2))-D*sig_pos_cen;
% safety constraints
for i=1:robot_num
    disp_base_mat(:,:,i) = disp_base_mat_func(i,0,opt_scale(i));
    joint_ref(i,:) = joint_ref_func(angle_inward(i),opt_scale(i));
    safe_con_ref(i).A = safe_con.A_func(i,opt_scale(i),joint_ref(i,:));
    safe_con_ref(i).b = safe_con.b_func(i,joint_ref(i,:));
    safe_con_ref(i).lim = safe_con.lim_func(i);
    disp_end_lim(:,:,i) = safe_con_ref(i).lim(:,1:2);
end
% weights and gains
gain_formation = 1;
gain_centroid = 1;
gain_obstacle = 0.5;
gain_recover = 1;
weight_base = eye(2);
weight_joint = 2*eye(size(joint,2));
% collision avoidance
u_obs = zeros(robot_num,2);
u_coef_base = zeros(size(coef_base));
detect_radius = 2*robot_desired.radius;
for i=1:robot_num
    is_detected = false;
    u_log = zeros(length(envir.obstacle),2);
    for j=1:length(envir.obstacle)
        % unit vector at disp base
        disp_base = coef_base(i,:)*disp_base_mat(:,:,i)'; 
        disp_unit_vec = disp_base/norm(disp_base);
        % base: triangular region of cone working range
        % obst: translation with pos_traj_hat(i,:)
        base_vert = disp_base+[0,0;cone.vec_min_func(angle_inward(i))';cone.vec_max_func(angle_inward(i))'];
        obs_vert = envir.obstacle{j}-pos_traj_hat(i,1:2);
        % change to polytope constraints
        [A_base,b_base] = polycons(base_vert);
        [A_obs,b_obs] = polycons(obs_vert);
        % calculate nearest points 
        disp_near = lsqlin([eye(length(disp_base)),-eye(length(disp_base))],...
            zeros(2,1),blkdiag(A_base,A_obs),[b_base;b_obs])';
        disp_base_near = disp_near(1:2);
        disp_obs_near = disp_near(3:4);
        % distance between nearest points
        dis_base_obs = norm(disp_base_near-disp_obs_near);
        if dis_base_obs<=detect_radius
            is_detected = true;
            % logarithmic barrier function gradient increasing direction
            % w(dis_base_obs) = (max(-ln(dis_base_obs/detect_radius),0))*2
            u_log(j,:) = 2*log(dis_base_obs/detect_radius)*(disp_base_near-disp_obs_near)./(dis_base_obs.^2);
        end
    end
    % project to disp base vector
    dot_opt_scale(i,:) = -gain_recover*max(disp_unit_vec*sum(u_log)',0);
    u_obs(i,:) = disp_unit_vec*sum(u_log)'*disp_unit_vec;
    u_coef_base(i,:) = min(u_obs(i,:),[0,0])*pinv(disp_base_mat(:,:,i))';
    % recover orignal scale in collision-free space
    if ~is_detected
        dot_opt_scale(i,:) = -gain_recover*(opt_scale(i,:)-link_scale);
    end
end
% primal-dual algorithm - primal
for i=1:robot_num
    fkine_be = robot_desired.getFkine(robot_desired.link,joint(i,:));
    jacob_be = robot_desired.getJacob(robot_desired.link,joint(i,:));
    % written in column
    cone_affine_mat(:,:,i) = cone.affine_func(angle_inward(i));
    u_cost(i,:) = [cone_affine_mat(:,:,i)';
        -disp_base_mat(:,:,i)'*cone_affine_mat(:,:,i)';...
        -jacob_be'*cone_affine_mat(:,:,i)']*...
        weight_base*cone_affine_mat(:,:,i)*(disp_end(i,:)'-...
        disp_base_mat(:,:,i)*coef_base(i,:)'-fkine_be');
end
u_con = [gain_centroid*eta,...
    gain_formation*L*nu+gain_obstacle*u_coef_base,...
    (joint-joint_ref)*weight_joint];
u_input = u_cost+u_con;
% result => format: [{},{},...]
if norm(u_obs)>0
    result = {'Avoiding obstacles...'};
else
    result = {'Detecting obstacles...'};
end
% projection
for i=1:robot_num
    u_input_proj(i,:)= convproj(opt_state(i,:)-u_input(i,:),...
        safe_con_ref(i).A,...
        safe_con_ref(i).b,...
        safe_con_ref(i).lim);
    dot_opt_state(i,:) = u_input_proj(i,:)-opt_state(i,:);
end
% primal-dual algorithm - dual
gain_penalty = norm(disp_end+dot_disp_end); %norm(disp_end_lim(2,:))*sqrt(robot_num);
dot_nu = gain_formation*L*(dot_coef_base+coef_base);
dot_eta = gain_centroid*(disp_end+dot_disp_end)...
    -gain_centroid*(gain_penalty*D*sign(D'*eta));
% dot lambda
dot_lambda = [dot_nu,dot_eta];
% varargout
varargout = {dot_pos_traj_hat,dot_pos_end,dot_opt_state,dot_opt_scale,dot_lambda,lambda,result};
end