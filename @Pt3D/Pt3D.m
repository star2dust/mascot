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
        p_traj
        p_next
        v_traj
    end

    properties
        % 飞控参数
        wp_radius
        wp_loiter_rad
        airspd_max
        airspd_min
        % 航点提前距离
        heading_dist
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
            opt.wp_radius = 200;
            opt.wp_loiter_rad = 250;
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
            pt.airspd_min = opt.airspd_min;
            pt.airspd_max = opt.airspd_max;
            pt.wp_radius = opt.wp_radius;
            pt.wp_loiter_rad = opt.wp_loiter_rad;
            pt.heading_dist = opt.heading_dist;
            pt.algorithm = opt.algorithm;
            pt.color = opt.color;
            pt.appear = opt.appear;
            pt.traj = pt.p_vehicle;
            pt.ntrj = opt.ntrj;
            pt.mission_flag = 1;
            pt.guided_flag = 0;
            pt.tkoff_flag = 0;
        end

        function show(pt,axes)
            % plane traj (old->new) -> heading pt -> guided pt
            if size(pt.traj,2)<=pt.ntrj
                xtraj = [pt.traj(1,:),pt.p(1)];
                ytraj = [pt.traj(2,:),pt.p(1)];
            else
                xtraj = [pt.traj(1,end-pt.ntrj:end),pt.p(1)];
                ytraj = [pt.traj(2,end-pt.ntrj:end),pt.p(1)];
            end
            if ~pt.guided_flag
                xtraj(end) = [];
                ytraj(end) = [];
            end
            if isempty(pt.htraj)
                pt.htraj = Canvas.simple_plot(axes,ytraj,xtraj,[pt.color pt.appear],'LineWidth',2.5,'UserData',4);
            else
                set(pt.htraj,'XData',ytraj,'YData',xtraj);
            end
            if isempty(pt.hhead)
                pt.hhead = Canvas.simple_plot(axes,[pt.traj(2,end) pt.p_heading(2)],[pt.traj(1,end) pt.p_heading(1)],...
                    [pt.color '-'],'LineWidth',1.5,'UserData',3);
            else
                set(pt.hhead,'XData',[pt.traj(2,end) pt.p_heading(2)],'YData',[pt.traj(1,end) pt.p_heading(1)]);
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

        function t_ind = track(pt,tnow)
            x = interp1(pt.tlist(2:end-1),pt.xlist(2:end-1),tnow);
            y = interp1(pt.tlist(2:end-1),pt.ylist(2:end-1),tnow);
            z = interp1(pt.tlist(2:end-1),pt.zlist(2:end-1),tnow);
            v = interp1(pt.tlist(2:end-1),pt.vlist(2:end-1),tnow);
            pt.p_traj = [x;y;z];
            pt.v_traj = v;
            t_ind = find(1==(tnow-pt.tlist(2:end-1)<0),1)+1;
            pt.p_next = [pt.xlist(t_ind);pt.ylist(t_ind);pt.zlist(t_ind)];
        end

        function step(pt,dt,pr,pr_dot)
            % run ctrl algo
            pt.control(pr,pr_dot);
            % set ctrl bound
            pt.set_ctrl_bound();
            % update states
            pt.p = pt.p+pt.p_dot*dt;
            pt.p = pt.p_heading;
        end

        function update(pt,p_vehicle,p_heading)
            pt.p_vehicle = p_vehicle;
            pt.p_heading = p_heading;
            if pt.tkoff_flag
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
