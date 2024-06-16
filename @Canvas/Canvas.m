classdef Canvas < handle
    properties
        % figure axes
        SimuFigure
        SimuAxes
        % figdata
        xtarget
        ytarget
        xlist
        ylist
        % navpt
        navid
        mode
        % line
        xybound
        hline
        hnavid
    end

    methods
        function cav = Canvas(figure,axes,xlim,ylim)
            if nargin<4
                xlim = [0,1];
                ylim = [0,1];
            end
            cav.SimuFigure = figure;
            cav.SimuAxes = axes;
            cav.set_lim(xlim,ylim);
            set(cav.SimuFigure,'UserData',cav);
            % figdata
            cav.clear();
            cav.mode = 0;
            cav.navid = 0;
        end

        function next(cav)
            if cav.mode<3&&cav.mode>=0
                cav.mode = cav.mode+1;
            else
                cav.mode = 0;
            end
        end

        function clear(cav)
            % figdata
            cav.xtarget = [];
            cav.ytarget = [];
            cav.xlist = [];
            cav.ylist = [];
        end

        function set_lim(cav,xlim,ylim)
            cav.xybound = cav.get_xy_from_xylim(xlim,ylim);
        end

        function set_navid(cav,id)
            if id<=length(cav.xlist)&&id>=0
                cav.navid = id;
            end
        end

        function set_mode(cav,mode)
            if id<=3&&id>=0
                cav.mode = mode;
            end
        end
    end

    methods (Static)
        %% CALLBACKS FOR MOUSE

        % When click-up occurs, disable the mouse motion detecting callback
        function ClickUp(varargin)
            cav = get(varargin{1},'UserData');
            % get figdata
            cav.get_figdata_point();
            % show figdata
            cav.show_figdata();
            set(varargin{1},'UserData',cav);
        end

        % When click-down occurs, enable the mouse motion detecting callback
        function ClickDown(varargin)
            cav = get(varargin{1},'UserData');
            set(varargin{1},'WindowButtonMotionFcn',@Canvas.MousePos);
            set(varargin{1},'UserData',cav);
        end

        % Checks mouse position and sends it back up.
        function MousePos(varargin)
            cav = get(varargin{1},'UserData');
            cav.get_mouse_point();
            set(varargin{1},'UserData',cav);
        end

        %% CALCULATIONS FOR NEAREST POINT
        function [dp2min,id] = nearest_point(xlist,ylist,xtarget,ytarget)
            x = abs(xlist - xtarget);
            y = abs(ylist - ytarget);
            distp2 = x.^2+y.^2;
            [dp2min,id] = min(distp2);
        end

        function [xlist,ylist,id2] = nearest_to_line_between_two_points(xlist,ylist,xtarget,ytarget)
            nlist = length(xlist);
            if nlist>1
                for i=2:nlist
                    a = 1/(xlist(i)-xlist(i-1));
                    b = -1/(ylist(i)-ylist(i-1));
                    c = ylist(i-1)/(ylist(i)-ylist(i-1))-...
                        xlist(i-1)/(xlist(i)-xlist(i-1));
                    dist2line(i-1) = abs(a*xtarget+b*ytarget+c)/norm([a,b]);
                    v1 = [xlist(i-1)-xtarget;ylist(i-1)-ytarget];
                    v2 = [xlist(i)-xtarget;ylist(i)-ytarget];
                    costh(i-1) = v1'*v2/(norm(v1)*norm(v2));
                end
                if sum(costh(costh<=0))
                    dist2line(costh>0) = inf;
                    [~,id2] = min(dist2line);
                    xlist = [xlist(1:id2) xtarget xlist(id2+1:nlist)];
                    ylist = [ylist(1:id2) ytarget ylist(id2+1:nlist)];
                end
            end
        end

        function [xlist,ylist,id2] = nearest_between_two_points(xlist,ylist,xtarget,ytarget)
            x1 = abs(xlist([1 1:nlist]) - xtarget);
            y1 = abs(ylist([1 1:nlist]) - ytarget);
            x2 = abs(xlist([1:nlist nlist]) - xtarget);
            y2 = abs(ylist([1:nlist nlist]) - ytarget);
            dist2p2 = x1.^2+y1.^2+x2.^2+y2.^2;
            [~,id2] = min(dist2p2);
            if id2==1
                xlist = [xtarget xlist];
                ylist = [ytarget ylist];
            else
                if id2==nlist+1
                    xlist = [xlist xtarget];
                    ylist = [ylist ytarget];
                else
                    xlist = [xlist(1:id2-1) xtarget xlist(id2:nlist)];
                    ylist = [ylist(1:id2-1) ytarget ylist(id2:nlist)];
                end
            end
        end

        function [xlist,ylist,id2] = nearest_to_line(xlist,ylist,xtarget,ytarget)
            nlist = length(xlist);
            dist2line = norm([xlist(1)-xtarget;ylist(1)-ytarget]);
            for i=2:nlist
                a = 1/(xlist(i)-xlist(i-1));
                b = -1/(ylist(i)-ylist(i-1));
                c = ylist(i-1)/(ylist(i)-ylist(i-1))-...
                    xlist(i-1)/(xlist(i)-xlist(i-1));
                dist2line(i) = abs(a*xtarget+b*ytarget+c)/norm([a,b]);
            end
            dist2line(nlist+1) = norm([xlist(nlist)-xtarget;ylist(nlist)-ytarget]);
            [~,id2] = min(dist2line);
            if id2==1
                xlist = [xtarget xlist];
                ylist = [ytarget ylist];
            else
                if id2==nlist+1
                    xlist = [xlist xtarget];
                    ylist = [ylist ytarget];
                else
                    xlist = [xlist(1:id2-1) xtarget xlist(id2:nlist)];
                    ylist = [ylist(1:id2-1) ytarget ylist(id2:nlist)];
                end
            end
        end

        function xybound = get_xy_from_xylim(xlim,ylim)
            xybound = [ylim(1),ylim(1),ylim(2),ylim(2),ylim(1);
                xlim(1),xlim(2),xlim(2),xlim(1),xlim(1)];
        end

        function h = simple_plot(varargin)
            % 参数分解
            opt.Marker = 'none';
            opt.MarkerSize = 6;
            opt.LineWidth = 0.5;
            opt.UserData = 255;
            [opt,arg] = tb_optparse(opt, varargin);
            % 若坐标未hold且有图像，则先hold再plot
            hold_flag = 1;
            if ~ishold(arg{1})&&~isempty(arg{1}.Children)
                hold_flag = 0;
                hold(arg{1},'on');
            end
            h = plot(arg{1},arg{2},arg{3},arg{4},'Marker',opt.Marker,'MarkerSize',opt.MarkerSize,'LineWidth',opt.LineWidth,'UserData',opt.UserData);
            if ~hold_flag
                hold(arg{1},'off');
            end
        end
    end
end