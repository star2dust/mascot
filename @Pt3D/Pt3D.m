classdef Pt3D < handle
    properties (SetAccess = private)
        id
        % state p = [north, east, down]
        p
        p_dot
        % 飞机相关的存储
        % real plane state
        p_heading
        p_vehicle
        % 航线轨迹存储
        p_track
        v_track
    end

    properties
        % 空速范围
        airspd_max
        airspd_min
        % 航点前置距离
        heading_dist
        navpt_dist
        % color
        color
        % algorithm (string) choose which algo to use
        algorithm
        % save trajectory
        traj
        ntrj
        % appearance
        appear
        htraj
        htext
        hhead
        % 任务相关的存储
        % real mission
        cmd
        hold
        rad_accept
        rad_pass
        yaw
        lat
        lon
        alt
        % display
        mission_flag
        guided_flag
        tkoff_flag
        track_flag
        % airspd init
        airspd_flag
        % mission traj
        xlist
        ylist
        zlist
        vlist
        tlist
    end

    methods
        function pt = Pt3D(varargin)
            % Point2D  Create 2D simple point

            % opt parse: only stated fields are chosen to opt, otherwise to arg
            opt.id = 1;
            opt.p = [0;0;0];
            opt.airspd_min = 20;
            opt.airspd_max = 30;
            opt.heading_dist = 300;
            opt.algorithm = '';
            opt.color = 'b';
            opt.appear = '--';
            opt.ntrj = 300;
            [opt,arg] = tb_optparse(opt, varargin);
            % check arg validity
            
            % pt init
            pt.id = opt.id;
            pt.p = opt.p;
            pt.p_dot = [0;0;0];
            pt.p_heading = [0;0;0];
            pt.p_vehicle = [0;0;0];
            pt.p_track = [0;0;0];
            pt.airspd_min = opt.airspd_min;
            pt.airspd_max = opt.airspd_max;
            pt.heading_dist = opt.heading_dist;
            pt.navpt_dist = 100000;
            pt.algorithm = opt.algorithm;
            pt.color = opt.color;
            pt.appear = opt.appear;
            pt.traj = pt.p_vehicle;
            pt.ntrj = opt.ntrj;
            pt.mission_flag = 1;
            pt.guided_flag = 0;
            pt.tkoff_flag = 0;
            pt.track_flag = 0;
            pt.airspd_flag = 0;
        end

        function show(pt,axes)
            % plane traj: (old->new) -> heading pt -> guided pt
            if size(pt.traj,2)<=pt.ntrj
                xtraj = pt.traj(1,:);
                ytraj = pt.traj(2,:);
            else
                xtraj = pt.traj(1,end-pt.ntrj:end);
                ytraj = pt.traj(2,end-pt.ntrj:end);
            end
            if pt.guided_flag
                xtraj(end+1) = pt.p(1);
                ytraj(end+1) = pt.p(2);
            end
            if isempty(pt.htraj)
                % 注意xy倒置
                pt.htraj = Canvas.simple_plot(axes,ytraj,xtraj,[pt.color pt.appear],'LineWidth',2.5,'UserData',4);
            else
                set(pt.htraj,'XData',ytraj,'YData',xtraj);
            end
            % plane head: curr pt -> heading pt -> wp traj pt
            xhead = [pt.traj(1,end) pt.p_heading(1)];
            yhead = [pt.traj(2,end) pt.p_heading(2)];
            if pt.track_flag
                xhead(end+1) = pt.p_track(1);
                yhead(end+1) = pt.p_track(2);
            end
            if isempty(pt.hhead)
                % 注意xy倒置
                pt.hhead = Canvas.simple_plot(axes,yhead,xhead,[pt.color '-'],'LineWidth',1.5,'UserData',3);
            else
                set(pt.hhead,'XData',yhead,'YData',xhead);
            end
            if isempty(pt.htext)
                pt.htext = text(axes,pt.traj(2,end),pt.traj(1,end),num2str(pt.id),...
                    'FontSize',20,'Color','k','HorizontalAlignment','center','UserData',1);
            else
                set(pt.htext,'Position',[pt.traj(2,end),pt.traj(1,end),0]);
            end
            if pt.color=='y'
                set(pt.htraj,'Color',[1 0.5 0]);
            end
        end

        function track(pt,tnow)
            % 约束tnow范围，保证xyz不为NaN
            if tnow>pt.tlist(end-1)
                tnow = pt.tlist(end-1);
            else
                if tnow<pt.tlist(2)
                    tnow = pt.tlist(2);
                end
            end
            % 插值法取xyz
            x = interp1(pt.tlist(2:end-1),pt.xlist(2:end-1),tnow);
            y = interp1(pt.tlist(2:end-1),pt.ylist(2:end-1),tnow);
            z = interp1(pt.tlist(2:end-1),pt.zlist(2:end-1),tnow);
            v = interp1(pt.tlist(2:end-1),pt.vlist(2:end-1),tnow);
            pt.p_track = [x;y;z];
            pt.v_track = v;
        end

        function step(pt,dt,pr,pr_dot)
            % run ctrl algo
            pt.control(pr,pr_dot);
            % set ctrl bound
            pt.set_ctrl_bound();
            % update states
            pt.p = pt.p+pt.p_dot*dt;
        end

        function update(pt,p_vehicle,p_heading)
            pt.p_vehicle = p_vehicle;
            pt.p_heading = p_heading;
            if pt.tkoff_flag
                % pt.traj为3xN格式，如果第一个为0向量可删除
                pt.traj = [pt.traj pt.p_vehicle];
                if sum(pt.traj(:,1))==0
                    pt.traj(:,1) = [];
                end
            else
                pt.traj = pt.p_vehicle;
            end
        end

        function control(pt,pr,pr_dot)
            if ~isempty(pt.algorithm)
                pt.(pt.algorithm)(pr,pr_dot);
            end
        end
    end
end
