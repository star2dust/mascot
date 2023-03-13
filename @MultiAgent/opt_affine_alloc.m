function opt_affine_alloc(ma,dt)
% formation type
dim = size(ma.p,1);
A = eye(dim*ma.n);
if ma.percept.f_curr==5||ma.percept.f_curr==8
    A(end,end) = -1;
end
if ma.percept.f_curr==7
    A(dim,dim) = -1;
end
if ma.percept.f_curr~=ma.percept.f_prev
    ma.percept.pr = ma.percept.pr_reset(ma.percept.f_curr);
    ma.percept.f_prev = ma.percept.f_curr;
end
% parameters
Kp = 2; Kc = 1; Kb = 0.01; 
% calculate control input
pr_ave = sum(ma.percept.pr,2)/size(ma.percept.pr,2);
pr_ave = kron(ones(1,size(pr_ave,2)),pr_ave);
pr_dot_ave = sum(ma.percept.pr_dot,2)/size(ma.percept.pr_dot,2);
pr_dot_ave = kron(ones(1,size(pr_dot_ave,2)),pr_dot_ave);
q = [ma.p-ma.percept.pr;ma.percept.pc-pr_ave];
q_dot = [ma.p_dot-ma.percept.pr_dot;ma.percept.pc_dot-pr_dot_ave];
q_lb = [ma.percept.p_lb;ma.percept.pc_lb];
q_ub = [ma.percept.p_ub;ma.percept.pc_ub];
u2_p = zeros(size(ma.p));
u2_p(:) = A*kron(ma.Omega,eye(dim))*ma.percept.lam_p(:)+ma.percept.eta(:);
u2 = [u2_p;(ma.L*ma.percept.lam_pc')'-ma.percept.eta];
for i=1:ma.n
    u1(:,i) = [Kp*(q(1:2,i)-q(3:4,i));
        -Kp*(q(1:2,i)-q(3:4,i))];
    u1(:,i) = [Kp*q(1:2,i);
        Kc*q(3:4,i)];
    q_dot(:,i) = lsqlin(eye(size(q,1)),q(:,i)-u1(:,i)-u2(:,i),[],[],[],[],q_lb(:,i),q_ub(:,i))-q(:,i);
end
ma.p_dot = q_dot(1:dim,:)+ma.percept.pr_dot;
ma.percept.pc_dot = q_dot(dim+1:2*dim,:)+pr_dot_ave;
ma.percept.lam_p_dot(:) = kron(ma.Omega,eye(dim))*(A*vec(q(1:2,:))+A*vec(q_dot(1:2,:)));
ma.percept.lam_pc_dot = (ma.L*(q(3:4,:)'+q_dot(3:4,:)'))';
beta = max(max(q(1:2,:)-q(3:4,:)+q_dot(1:2,:)-q_dot(3:4,:)))+Kb;
ma.percept.eta_dot = q(1:2,:)-q(3:4,:)+q_dot(1:2,:)-q_dot(3:4,:)-beta*(ma.D*sign(ma.D'*ma.percept.eta'))';
end