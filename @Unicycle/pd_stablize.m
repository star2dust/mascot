function pd_stablize(pt,dt)
kp = 3; tau = dt;
L = [cos(pt.q(3)),sin(pt.q(3));
    -sin(pt.q(3))/pt.ahead,cos(pt.q(3))/pt.ahead];
p_dot = pt.percept.pr_dot-kp*(pt.p-pt.percept.pr);
if pt.order==1
    pt.v = L(1,:)*p_dot;
    pt.w = L(2,:)*p_dot;
else
    v = L(1,:)*p_dot;
    if v>pt.v_max
        v = pt.v_max;
    else
        if v<pt.v_min
            v = pt.v_min;
        end
    end
    pt.a = (v-pt.v)/tau;
    pt.w = L(2,:)*p_dot;
end
end