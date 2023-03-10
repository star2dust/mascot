function pd_stablize(pt,dt)
kp = 3; kd = 5;
if pt.order==1
    pt.p_dot = pt.percept.pr_dot-kp*(pt.q(1:2)-pt.percept.pr);
else
    pt.p_ddot = -kd*(pt.p_dot-pt.percept.pr_dot)-kp*(pt.p-pt.percept.pr);
end
end