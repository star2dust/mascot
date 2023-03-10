function pd_stablize(uni,dt)
kp = 3; tau = dt;
L = [cos(uni.q(3)),sin(uni.q(3));
    -sin(uni.q(3))/uni.ahead,cos(uni.q(3))/uni.ahead];
p_dot = uni.percept.pr_dot-kp*(uni.p-uni.percept.pr);
if uni.order==1
    uni.v = L(1,:)*p_dot;
    uni.w = L(2,:)*p_dot;
else
    v = L(1,:)*p_dot;
    if v>uni.v_max
        v = uni.v_max;
    else
        if v<uni.v_min
            v = uni.v_min;
        end
    end
    uni.a = (v-uni.v)/tau;
    uni.w = L(2,:)*p_dot;
end
end