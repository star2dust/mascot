function pd_stablize(pt,dt)
kp = 3; kd = 5;
if pt.order==1
    pt.p_dot = pt.percept.pr_dot-kp*(pt.q(1:2)-pt.percept.pr);
else
    pt.p_ddot = -kd*(pt.p_dot-pt.percept.pr_dot)-kp*(pt.p-pt.percept.pr);
    p_dot_des = pt.p_dot+pt.p_ddot*dt;
    if norm(p_dot_des)>pt.v_max
        p_dot_des = unit(p_dot_des)*pt.v_max;
    else 
        if norm(p_dot_des)<pt.v_min&&norm(p_dot_des)~=0
            p_dot_des = unit(p_dot_des)*pt.v_min;
        end
    end
    pt.p_ddot = (p_dot_des-pt.p_dot)/dt;
end
end