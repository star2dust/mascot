function get_mouse_point(cav)
    mousePos = get(cav.SimuAxes,'CurrentPoint');
    cav.xtarget = mousePos(1,1);
    cav.ytarget = mousePos(1,2);
end