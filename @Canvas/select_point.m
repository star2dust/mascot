function select_point(cav)
    set(cav.SimuFigure,'WindowButtonMotionFcn','',...
        'WindowButtonDownFcn',@Canvas.ClickDown,...
        'WindowButtonUpFcn',@Canvas.ClickUp);
end
