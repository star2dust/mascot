function opt_affine_alloc_rhc(ma,dt)
ma.get_model_state();
% parameters
Kp = 2; Kb = 0.01; Nrhc = 10;
% save percept and p/p_dot
percept = ma.percept;
p = ma.p;
p_dot = ma.p_dot;
dt = dt*2;
ma.traj.dT = (Nrhc-1)*dt;
% calculate control input
for j=1:Nrhc
    q = [p;percept.pc];
    q_dot = [p_dot;percept.pc_dot];
    q_lb = [percept.p_lb;percept.pc_lb];
    q_ub = [percept.p_ub;percept.pc_ub];
    u1 = zeros(size(q));
    u2 = [(ma.Omega*percept.lam_p')'+percept.eta;
        (ma.L*percept.lam_pc')'-percept.eta];
    for i=1:ma.n
        u1(:,i) = [Kp*(p(:,i)-percept.pc(:,i)-percept.pr(:,i));
            -Kp*(p(:,i)-percept.pc(:,i)-percept.pr(:,i))];
        q_dot(:,i) = lsqlin(eye(size(q,1)),q(:,i)-u1(:,i)-u2(:,i),[],[],[],[],q_lb(:,i),q_ub(:,i))-q(:,i);
    end
    p_dot = q_dot(1:2,:);
    percept.pc_dot = q_dot(3:4,:);
    percept.lam_p_dot = (ma.Omega*(p'+p_dot'-percept.pr'-percept.pr_dot'))';
    percept.lam_pc_dot = (ma.L*(percept.pc'+percept.pc_dot'))';
    beta = max(max(p-percept.pc+p_dot-percept.pc_dot))+Kb;
    percept.eta_dot = p-percept.pc+p_dot-percept.pc_dot-beta*(ma.D*sign(ma.D'*percept.eta'))';
    % save percept_dot ad p_dot
    if j==1
        ma.percept.pc_dot = percept.pc_dot;
        ma.percept.lam_p_dot = percept.lam_p_dot;
        ma.percept.lam_pc_dot = percept.lam_pc_dot;
        ma.percept.eta_dot = percept.eta_dot;
        ma.p_dot = p_dot;
    end
    % pre-traj
    for i=1:ma.n
        ma.traj.p(:,j,i) = p(:,i);
        ma.traj.p_dot(:,j,i) = p_dot(:,i);
    end
    % pre-simulation
    p = p+p_dot*dt;
    percept.pc = percept.pc+percept.pc_dot*dt;
    percept.lam_p = percept.lam_p+percept.lam_p_dot*dt;
    percept.lam_pc = percept.lam_pc+percept.lam_pc_dot*dt;
    percept.eta = percept.eta+percept.eta_dot*dt;
end
% curve fitting
for i=1:ma.n
    [ax,ay] = ma.poly_curve(ma.traj.p(:,:,i),ma.traj.p_dot(:,:,i),ma.traj.dT);
    tt = linspace(0,(Nrhc-1)*dt,100);
    ma.traj.pp(:,:,i) = [[tt'.^5,tt'.^4,tt'.^3,tt'.^2,tt',ones(size(tt'))]*ax,...
                  [tt'.^5,tt'.^4,tt'.^3,tt'.^2,tt',ones(size(tt'))]*ay]';
end
% send pr to agent
for i=1:ma.n
    ma.model(i).percept.pr_dot = ma.traj.p_dot(:,1,i);
    ma.model(i).percept.pr = ma.traj.p(:,1,i);
end
end