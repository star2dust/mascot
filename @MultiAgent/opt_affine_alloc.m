function opt_affine_alloc(ma)
Kp = 2; Kb = 0.01; kr = 0.5;
q = [ma.p;ma.percept.pc];
q_dot = [ma.p_dot;ma.percept.pc_dot];
q_lb = [ma.percept.p_lb;ma.percept.pc_lb];
q_ub = [ma.percept.p_ub;ma.percept.pc_ub];
u1 = zeros(size(q));
u2 = [(ma.Omega*ma.percept.lam_p')'+ma.percept.eta;
    (ma.L*ma.percept.lam_pc')'-ma.percept.eta];
for i=1:ma.n
    u1(:,i) = [Kp*(ma.p(:,i)-ma.percept.pc(:,i)-ma.percept.pr(:,i));
                -Kp*(ma.p(:,i)-ma.percept.pc(:,i)-ma.percept.pr(:,i))];
    q_dot(:,i) = lsqlin(eye(size(q,1)),q(:,i)-u1(:,i)-u2(:,i),[],[],[],[],q_lb(:,i),q_ub(:,i))-q(:,i);
end
ma.p_dot = q_dot(1:2,:);
ma.percept.pc_dot = q_dot(3:4,:);
ma.percept.lam_p_dot = (ma.Omega*(ma.p'+ma.p_dot'))';
ma.percept.lam_pc_dot = (ma.L*(ma.percept.pc'+ma.percept.pc_dot'))';
beta = max(max(ma.p-ma.percept.pc+ma.p_dot-ma.percept.pc_dot))+Kb;
ma.percept.eta_dot = ma.p-ma.percept.pc+ma.p_dot-ma.percept.pc_dot-beta*(ma.D*sign(ma.D'*ma.percept.eta'))';
for i=1:ma.n
    ma.model(i).percept.pr_dot = ma.p_dot(:,i)-kr*(ma.model(i).percept.pr-ma.p(:,i));
end
end