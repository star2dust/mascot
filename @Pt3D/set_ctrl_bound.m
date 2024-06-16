function set_ctrl_bound(pt)
if norm(pt.p_dot)>pt.v_max
    pt.p_dot = unit(pt.p_dot)*pt.v_max;
else 
    if norm(pt.p_dot)<pt.v_min&&norm(pt.p_dot)~=0
        pt.p_dot = unit(pt.p_dot)*pt.v_min;
    end
end
end