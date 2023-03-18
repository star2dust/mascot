function set_omni_bound(ma,i)
if ma.order==1
    if norm(ma.p_dot(:,i))>ma.model(i).v_max*(1-ma.v_space)
        ma.p_dot(:,i) = unit(ma.p_dot(:,i))*ma.model(i).v_max*(1-ma.v_space);
    else
        if norm(ma.p_dot(:,i))<ma.model(i).v_min*(1+ma.v_space)&&norm(ma.p_dot(:,i))~=0
            ma.p_dot(:,i) = unit(ma.p_dot(:,i))*ma.model(i).v_min*(1+ma.v_space);
        end
    end
else
    if norm(ma.p_ddot(:,i))>ma.model(i).a_max*(1-ma.v_space)
        ma.p_ddot(:,i) = unit(ma.p_ddot(:,i))*ma.model(i).a_max*(1-ma.v_space);
    else
        if norm(ma.p_ddot(:,i))<ma.model(i).a_min*(1+ma.v_space)&&norm(ma.p_ddot(:,i))~=0
            ma.p_ddot(:,i) = unit(ma.p_ddot(:,i))*ma.model(i).a_min*(1+ma.v_space);
        end
    end
end
end