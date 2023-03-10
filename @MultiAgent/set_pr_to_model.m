function set_pr_to_model(ma)
for i=1:ma.n
    ma.model(i).percept.pr_dot = ma.p_dot(:,i);
    ma.model(i).percept.pr = ma.p(:,i);
end
end