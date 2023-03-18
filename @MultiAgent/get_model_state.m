function get_model_state(ma)
for i=1:ma.n
    if norm(ma.p(:,i)-ma.model(i).p)>ma.dist_in_loop
        ma.p(:,i) = ma.model(i).p;
        ma.p_dot(:,i) = ma.model(i).p_dot;
        ma.p_ddot(:,i) = ma.model(i).p_ddot;
    end
end
end