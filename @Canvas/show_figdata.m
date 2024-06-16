function show_figdata(cav)
    if ~isempty(cav.xlist)
        xlim = get(cav.SimuAxes,'XLim');
        ylim = get(cav.SimuAxes,'YLim');
        % hline
        if ~isempty(cav.hline)&&isvalid(cav.hline)
            set(cav.hline,'XData',cav.xlist,'YData',cav.ylist);
        else  
            cav.hline = cav.simple_plot(cav.SimuAxes,cav.xlist,cav.ylist,'k-','Marker','.','MarkerSize',30,'UserData',5);
        end
        % hnavid
        if cav.navid>0
            if ~isempty(cav.hnavid)&&isvalid(cav.hnavid)
                set(cav.hnavid,'XData',cav.xlist(cav.navid),'YData',cav.ylist(cav.navid));
            else
                cav.hnavid = cav.simple_plot(cav.SimuAxes,cav.xlist(cav.navid),cav.ylist(cav.navid),'k','Marker','o','MarkerSize',30,'UserData',5);
            end
        end
        set(cav.SimuAxes,'XLim',xlim,'YLim',ylim);
    else
        if ~isempty(cav.hline)&&isvalid(cav.hline)
            delete(cav.hline);
        end
        if ~isempty(cav.hnavid)&&isvalid(cav.hnavid)
            delete(cav.hnavid);
        end
    end
end