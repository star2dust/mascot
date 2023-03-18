function opt_affine_alloc(ma,dt)
% pr centroid
[pr_ave, pr_dot_ave] = ma.get_pr_centroid();
% formation switch
A = ma.check_f_switch(pr_ave);
% parameters
Kp = 2; Kc = 3; Kf = 5; Kb = 0.01; 
% calculate control input
q = [ma.p-ma.percept.pr;ma.percept.pc-pr_ave];
q_dot = [ma.p_dot-ma.percept.pr_dot;ma.percept.pc_dot-pr_dot_ave];
q_lb = [ma.percept.p_lb;ma.percept.pc_lb];
q_ub = [ma.percept.p_ub;ma.percept.pc_ub];
u2_p = zeros(size(ma.p));
u2_p(:) = A*kron(ma.Omega,eye(2))*ma.percept.lam_p(:)+ma.percept.eta(:);
u2 = [u2_p;(ma.L*ma.percept.lam_pc')'-ma.percept.eta];
for i=1:ma.n
    % get together and formation
    u1(:,i) = [Kp*q(1:2,i);
        Kc*q(3:4,i)]+[Kf*(q(1:2,i)-q(3:4,i));
        -Kf*(q(1:2,i)-q(3:4,i))];
    q_dot(:,i) = lsqlin(eye(size(q,1)),q(:,i)-u1(:,i)-u2(:,i),[],[],[],[],q_lb(:,i),q_ub(:,i))-q(:,i);
end
ma.p_dot = q_dot(1:2,:)+ma.percept.pr_dot;
ma.percept.pc_dot = q_dot(3:4,:)+pr_dot_ave;
ma.percept.lam_p_dot(:) = kron(ma.Omega,eye(2))*(A*vec(q(1:2,:))+A*vec(q_dot(1:2,:)));
ma.percept.lam_pc_dot = (ma.L*(q(3:4,:)'+q_dot(3:4,:)'))';
beta = max(max(q(1:2,:)-q(3:4,:)+q_dot(1:2,:)-q_dot(3:4,:)))+Kb;
ma.percept.eta_dot = q(1:2,:)-q(3:4,:)+q_dot(1:2,:)-q_dot(3:4,:)-beta*(ma.D*sign(ma.D'*ma.percept.eta'))';
end