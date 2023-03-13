function opt_affine_alloc_static(ma,dt)
% formation type
dim = size(ma.p,1);
A = eye(dim*ma.n);
if ma.percept.formation==5||ma.percept.formation==8
    A(end,end) = -1;
end
if ma.percept.formation==7
    A(dim,dim) = -1;
end
% parameters
Kp = 2; Kb = 0.01; 
% calculate control input
q = [ma.p;ma.percept.pc];
q_dot = [ma.p_dot;ma.percept.pc_dot];
q_lb = [ma.percept.p_lb;ma.percept.pc_lb];
q_ub = [ma.percept.p_ub;ma.percept.pc_ub];
u2_p = zeros(size(ma.p));
u2_p(:) = A*kron(ma.Omega,eye(dim))*ma.percept.lam_p(:)+ma.percept.eta(:);
u2 = [u2_p;(ma.L*ma.percept.lam_pc')'-ma.percept.eta];
for i=1:ma.n
    u1(:,i) = [Kp*(ma.p(:,i)-ma.percept.pc(:,i)-ma.percept.pr(:,i));
        -Kp*(ma.p(:,i)-ma.percept.pc(:,i)-ma.percept.pr(:,i))];
    q_dot(:,i) = lsqlin(eye(size(q,1)),q(:,i)-u1(:,i)-u2(:,i),[],[],[],[],q_lb(:,i),q_ub(:,i))-q(:,i);
end
ma.p_dot = q_dot(1:dim,:);
ma.percept.pc_dot = q_dot(dim+1:2*dim,:);
ma.percept.lam_p_dot(:) = kron(ma.Omega,eye(dim))*(A*ma.p(:)+A*ma.p_dot(:)-A*ma.percept.pr(:)-A*ma.percept.pr_dot(:));
ma.percept.lam_pc_dot = (ma.L*(ma.percept.pc'+ma.percept.pc_dot'))';
beta = max(max(ma.p-ma.percept.pc+ma.p_dot-ma.percept.pc_dot))+Kb;
ma.percept.eta_dot = ma.p-ma.percept.pc+ma.p_dot-ma.percept.pc_dot-beta*(ma.D*sign(ma.D'*ma.percept.eta'))';
end