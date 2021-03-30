function varargout = nullspaceBehavioralControl(pos_traj_ref,pos_traj_hat,pos_end,opt_state,opt_scale,lambda,...
                    dot_pos_traj_ref,dot_pos_traj_hat,dot_pos_end,dot_opt_state,dot_opt_scale,dot_lambda,t,current_path)

% load settings
par_load = {'robot_desired','cone','joint_ref_func','envir','disp_end_siz'};
load([current_path '/data/settings'],par_load{:});
% load initials
var_load = {'robot_num','link_scale','graph_base','angle_inward','safe_con','disp_base_mat_func','vert_ref'};
load([current_path '/data/initials'],var_load{:});
D = graph_base.incidence;
disp_end_ref = vert_ref*disp_end_siz;
% control gains
gain_tracking = 0.5;
gain_estimation = 2;
% state split
[disp_end,coef_base,joint] = Mascot.hatSplit(opt_state,[size(pos_end,2),size(pos_end,2)+1,length(robot_desired.link)]);
dot_disp_end = Mascot.hatSplit(dot_opt_state,[size(pos_end,2),size(pos_end,2)+1,length(robot_desired.link)]);
% robot controller - estimation
dot_pos_traj_hat = kron(ones(robot_num,1),dot_pos_traj_ref(1:3))...
    -gain_estimation*(pos_traj_hat-kron(ones(robot_num,1),pos_traj_ref(1:3)));
% robot controller - tracking
sig_pos_cen = sig(D'*(pos_end-disp_end),gain_tracking); % sign(D'*q).*abs(D'*q).^alpha;
dot_pos_end = dot_disp_end + dot_pos_traj_hat(:,1:2)...
    -gain_estimation*((pos_end-disp_end)-pos_traj_hat(:,1:2))-D*sig_pos_cen;
% disp and joint reference
for i=1:robot_num
    disp_base_mat(:,:,i) = disp_base_mat_func(i,0,opt_scale(i));
    joint_ref(i,:) = joint_ref_func(angle_inward(i),link_scale);
end
% weights and gains
gain_base = 1;
gain_end = 1;
gain_obstacle = 0.5;
gain_recover = 1;
% collision avoidance
detect_radius = 2*robot_desired.radius;
disp_base = zeros(robot_num,2);
for i=1:robot_num
    is_detected = false;
    u_log = zeros(length(envir.obstacle),2);
    for j=1:length(envir.obstacle)
        % unit vector at disp base
        disp_base(i,:) = coef_base(i,:)*disp_base_mat(:,:,i)'; 
        disp_unit_vec = disp_base(i,:)/norm(disp_base(i,:));
        % base: triangular region of cone working range
        % obst: translation with pos_traj_hat(i,:)
        base_vert = disp_base(i,:);
        obs_vert = envir.obstacle{j}-pos_traj_hat(i,1:2);
        % change to polytope constraints
        [A_obs,b_obs] = polycons(obs_vert);
        % calculate nearest points 
        disp_near = lsqlin(eye(length(disp_base(i,:))),...
            base_vert',blkdiag(A_obs),b_obs)';
        disp_base_near = base_vert;
        disp_obs_near = disp_near;
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
    u_obs(i,:) = sum(u_log);
    % recover orignal scale in collision-free space
    if ~is_detected
        dot_opt_scale(i,:) = -gain_recover*(opt_scale(i,:)-link_scale);
    end
end
% robot controller - disp end
dot_disp_end = -gain_end*(disp_end-disp_end_ref);
% robot controller - coef base
for i=1:robot_num
    disp_base_ref(i,:) = disp_base_mat(:,3,i)';
    dot_disp_base(i,:) = -gain_base*(disp_base(i,:)-disp_base_ref(i,:))+gain_obstacle*min(u_obs(i,:),[0,0]);
    dot_coef_base(i,:) = dot_disp_base(i,:)*pinv(disp_base_mat(:,:,i))';
end
% robot controller - joint
for i=1:robot_num
    fkine_be = robot_desired.getFkine(robot_desired.link,joint(i,:));
    jacob_be = robot_desired.getJacob(robot_desired.link,joint(i,:));
    dot_joint(i,:) = pinv(jacob_be)*(dot_disp_end(i,:)-dot_disp_base(i,:)-gain_base*(fkine_be-(disp_end(i,:)-disp_base(i,:))))'-...
        (eye(length(robot_desired.link))-pinv(jacob_be)*jacob_be)*(joint(i,:)-joint_ref(i,:))';
end
dot_opt_state = [dot_disp_end,dot_coef_base,dot_joint];
% result => format: [{},{},...]
if norm(u_obs)>0
    result = {'Avoiding obstacles...'};
else
    result = {'Detecting obstacles...'};
end
% varargout
varargout = {dot_pos_traj_hat,dot_pos_end,dot_opt_state,dot_opt_scale,dot_lambda,lambda,result};
end