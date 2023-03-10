function set_ctrl_bound(pt)
if pt.order==1
    if pt.v>pt.v_max
        pt.v = pt.v_max;
    else 
        if pt.v<pt.v_min
            pt.v = pt.v_min;
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
    if pt.a>pt.a_max
        pt.a = pt.a_max;
    else 
        if pt.a<pt.a_min
            pt.a = pt.a_min;
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