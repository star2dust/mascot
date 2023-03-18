function get_ahead_point(pt)
pt.p = pt.q(1:2)+pt.ahead*[cos(pt.q(3));sin(pt.q(3))];
L = [cos(pt.q(3)),sin(pt.q(3));
    -sin(pt.q(3))/pt.ahead,cos(pt.q(3))/pt.ahead];
pt.p_dot = L*[pt.v;pt.w];
pt.p_ddot = zeros(2,1);
end