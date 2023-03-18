function set_ctrl_bound(pt)
if pt.order==1
    if norm(pt.p_dot)>pt.v_max
        pt.p_dot = unit(pt.p_dot)*pt.v_max;
    else 
        if norm(pt.p_dot)<pt.v_min&&norm(pt.p_dot)~=0
            pt.p_dot = unit(pt.p_dot)*pt.v_min;
        end
    end
    if pt.w>pt.w_max
        pt.w = pt.w_max;
    else 
        if pt.w<pt.w_min
            pt.w = pt.w_min;
        end
    end
else
    if norm(pt.p_ddot)>pt.a_max
        pt.p_ddot = unit(pt.p_ddot)*pt.a_max;
    else 
        if norm(pt.p_ddot)<pt.a_min&&norm(pt.p_ddot)~=0
            pt.p_ddot = unit(pt.p_ddot)*pt.a_min;
        end
    end
    if pt.w>pt.w_max
        pt.w = pt.w_max;
    else 
        if pt.w<pt.w_min
            pt.w = pt.w_min;
        end
    end
end
end