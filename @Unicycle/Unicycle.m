classdef Unicycle < handle
    properties (SetAccess = private)
        % state
        q
        v
        w
        a
        % linearize
        ahead
        p
        p_dot
        p_ddot
        % max
        v_max
        w_max
        a_max
        % min
        v_min
        w_min
        a_min
    end

    properties
        % radius
        rad
        % order (1 or 2)
        order
        % color
        color
        % percept (struct) with function 'update' and 'show'
        percept
        % algorithm (string) choose which algo to use
        algorithm
        % save trajectory
        traj
        ntrj
        % appearance
        appear
    end

    methods
        function pt = Unicycle(varargin)
            % Unicycle  Create 2D simple unicyle

            % opt parse: only stated fields are chosen to opt, otherwise to arg
            opt.q = [0;0;0];
            opt.v = 0;
            opt.w = 0;
            opt.a = 0;
            opt.rad = 0.002;
            opt.v_min = 0.12;
            opt.w_min = -1;
            opt.a_min = -1*0.5;
            opt.v_max = 1;
            opt.w_max = 1;
            opt.a_max = 1*0.5;
            opt.order = 1;
            opt.algorithm = '';
            opt.color = 'b';
            opt.appear = 'o';
            opt.ntrj = 300;
            opt.percept = struct('update',[],'show',[]);
            [opt,arg] = tb_optparse(opt, varargin);
            % check arg validity
            
            % pt init
            pt.q = opt.q;
            pt.v = opt.v;
            pt.w = opt.w;
            pt.a = opt.a;
            pt.v_min = opt.v_min;
            pt.w_min = opt.w_min;
            pt.a_min = opt.a_min;
            pt.v_max = opt.v_max;
            pt.w_max = opt.w_max;
            pt.a_max = opt.a_max;
            pt.order = opt.order;
            pt.algorithm = opt.algorithm;
            pt.percept = opt.percept;
            pt.color = opt.color;
            pt.appear = opt.appear;
            pt.rad = opt.rad;
            % head init
            pt.ahead = pt.rad;
            pt.get_ahead_point();
            % traj init
            pt.traj = pt.q;
            pt.ntrj = opt.ntrj;
        end

        function show(pt,gcs)
            if ~isempty(pt.percept.show)
                pt.percept.show(pt.percept,gcs); hold(gcs.SimuAxes,'on');
            end
            if isempty(pt.rad)
                h1 = plot(gcs.SimuAxes,pt.q(1),pt.q(2),[pt.color pt.appear]);
            else
                h1 = plot(gcs.SimuAxes,pt.q(1)+pt.rad*cos(0:pi/20:2*pi),pt.q(2)+pt.rad*sin(0:pi/20:2*pi),pt.color);
            end
            h2 = plot(gcs.SimuAxes,[pt.p(1) pt.q(1)],[pt.p(2) pt.q(2)],[pt.color '-']);
            if size(pt.traj,2)<=pt.ntrj
                h3 = plot(gcs.SimuAxes,pt.traj(1,:),pt.traj(2,:),[pt.color ':']);
            else
                h3 = plot(gcs.SimuAxes,pt.traj(1,end-pt.ntrj:end),pt.traj(2,end-pt.ntrj:end),[pt.color ':']);
            end
            if pt.color=='y'
                set(h1,'Color',[1 0.5 0]);
                set(h2,'Color',[1 0.5 0]);
                set(h3,'Color',[1 0.5 0]);
            end
        end

        function step(pt,dt)
            % get ahead point
            pt.get_ahead_point();
            % run ctrl algo
            pt.control(dt);
            % set ctrl bound
            pt.set_ctrl_bound();
            if ~isempty(pt.percept.update)
                pt.percept = pt.percept.update(pt.percept,dt);
            end
            if pt.order==2
                pt.v = pt.v+pt.a*dt;
                pt.q = pt.q+[cos(pt.q(3)),0;sin(pt.q(3)),0;0,1]*[pt.v;pt.w]*dt;
            elseif pt.order==1
                pt.q = pt.q+[cos(pt.q(3)),0;sin(pt.q(3)),0;0,1]*[pt.v;pt.w]*dt;
            else
                error('Order should be 1 or 2!');
            end
            pt.traj = [pt.traj pt.q];
        end

        function control(pt,dt)
            if ~isempty(pt.algorithm)
                % old version code
                % eval(['pt.' pt.algorithm '(dt);']);
                pt.(pt.algorithm)(dt)
            end
        end
    end
end
