function get_ahead_point(uni)
uni.p = uni.q(1:2)+uni.ahead*[cos(uni.q(3));sin(uni.q(3))];
L = [cos(uni.q(3)),sin(uni.q(3));
    -sin(uni.q(3))/uni.ahead,cos(uni.q(3))/uni.ahead];
uni.p_dot = L*[uni.v;uni.w];
uni.p_ddot = zeros(2,1);
end