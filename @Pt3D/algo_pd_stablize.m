function algo_pd_stablize(pt,pr,pr_dot)
kp = 3; kd = 2;
pt.p_dot = pr_dot-kp*(pt.p-pr)-kd*(pt.p_dot-pr_dot);
end