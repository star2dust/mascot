function set_ctrl_bound(ma)
for i=1:ma.n
    if norm(ma.p_dot(:,i))>ma.model(i).v_max
        ma.p_dot(:,i) = unit(ma.p_dot(:,i))*ma.model(i).v_max;
    end
end
if ma.order==1
    if norm(ma.p_dot(:,i))>ma.model(i).v_max
        ma.p_dot(:,i) = unit(ma.p_dot(:,i))*ma.model(i).v_max;
    else 
        if norm(ma.p_dot(:,i))<ma.model(i).v_min
            ma.p_dot(:,i) = unit(ma.p_dot(:,i))*ma.model(i).v_min;
        end
    end
else
    if norm(ma.p_ddot(:,i))>ma.model(i).a_max
        ma.p_ddot(:,i) = unit(ma.p_ddot(:,i))*ma.model(i).a_max;
    else 
        if norm(ma.p_ddot(:,i))<ma.model(i).a_min
            ma.p_ddot(:,i) = unit(ma.p_ddot(:,i))*ma.model(i).a_min;
        end
    end
end
end