function set_ctrl_bound(ma)
for i=1:ma.n
    if ma.model(i).percept.omni
        ma.set_omni_bound(i);
    else
        if ma.order==1
            vcosth = abs([cos(ma.model(i).q(3)),sin(ma.model(i).q(3))]*ma.p_dot(:,i)/norm(ma.p_dot(:,i)));
            if norm(ma.p_dot(:,i))>ma.model(i).v_max*(1-ma.v_space)*vcosth
                ma.p_dot(:,i) = unit(ma.p_dot(:,i))*ma.model(i).v_max*(1-ma.v_space)*vcosth;
            else
                if norm(ma.p_dot(:,i))<ma.model(i).v_min*(1+ma.v_space)*vcosth&&norm(ma.p_dot(:,i))~=0
                    ma.p_dot(:,i) = unit(ma.p_dot(:,i))*ma.model(i).v_min*(1+ma.v_space)*vcosth;
                end
            end
        else
            acosth = abs([cos(ma.q(3)),sin(ma.q(3))]*ma.p_ddot(:,i)/norm(ma.p_ddot(:,i)));
            if norm(ma.p_ddot(:,i))>ma.model(i).a_max*(1-ma.v_space)*acosth
                ma.p_ddot(:,i) = unit(ma.p_ddot(:,i))*ma.model(i).a_max*(1-ma.v_space)*acosth;
            else
                if norm(ma.p_ddot(:,i))<ma.model(i).a_min*(1+ma.v_space)*acosth&&norm(ma.p_ddot(:,i))~=0
                    ma.p_ddot(:,i) = unit(ma.p_ddot(:,i))*ma.model(i).a_min*(1+ma.v_space)*acosth;
                end
            end
        end
    end
end
end