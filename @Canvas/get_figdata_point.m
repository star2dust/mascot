function get_figdata_point(cav)
if ~isempty(cav.xtarget)&&~isempty(cav.ytarget)
    set(cav.SimuFigure,'WindowButtonMotionFcn','');
    inside_flag = inhull([cav.xtarget,cav.ytarget],cav.xybound');
    if inside_flag
        if cav.mode==0
            % add point
            if isempty(cav.xlist)||isempty(cav.ylist)||...
                    (cav.xlist(end)~=cav.xtarget&&cav.ylist(end)~=cav.ytarget)
                cav.xlist = [cav.xlist cav.xtarget];
                cav.ylist = [cav.ylist cav.ytarget];
            end
        else
            if cav.mode==1||cav.mode==2
                [dp2min,id] = Canvas.nearest_point(cav.xlist,cav.ylist,cav.xtarget,cav.ytarget);
                if cav.mode==1
                    % delete point
                    if dp2min<50 % 5^2+5^2
                        cav.xlist(id) = [];
                        cav.ylist(id) = [];
                    end
                else
                    % modify point
                    cav.xlist(id) = cav.xtarget;
                    cav.ylist(id) = cav.ytarget;
                end
            else % if cav.mode==3
                % insert point
                [cav.xlist,cav.ylist] = Canvas.nearest_to_line_between_two_points( ...
                    cav.xlist,cav.ylist,cav.xtarget,cav.ytarget);
            end
        end
        cav.xtarget = [];
        cav.ytarget = [];
    end
end
end