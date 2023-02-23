function u = tracking(pt,pr)
kp = 1; kd = 2;
if pt.order==1
    u = -kp*(pt.p-pr.p);
else
    u = -kd*pt.p_dot-kp*(pt.p-pr.p);
end
end
