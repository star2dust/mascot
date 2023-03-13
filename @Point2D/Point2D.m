classdef Point2D < handle
    properties (SetAccess = private)
        % state
        p
        p_dot
        p_ddot
        % max
        v_max
        a_max
        % min
        v_min
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
    end

    methods
        function pt = Point2D(varargin)
            % Point2D  Create 2D simple point

            % opt parse: only stated fields are chosen to opt, otherwise to arg
            opt.p = [0;0];
            opt.p_dot = [0;0];
            opt.p_ddot = [0;0];
            opt.v_min = 0;
            opt.a_min = 0;
            opt.v_max = 1;
            opt.a_max = 1;
            opt.order = 1;
            opt.rad = 0.02;
            opt.algorithm = '';
            opt.color = 'b';
            opt.percept = struct('update',[],'show',[]);
            [opt,arg] = tb_optparse(opt, varargin);
            % check arg validity
            
            % pt init
            pt.p = opt.p;
            pt.p_dot = opt.p_dot;
            pt.p_ddot = opt.p_ddot;
            pt.v_min = opt.v_min;
            pt.a_min = opt.a_min;
            pt.v_max = opt.v_max;
            pt.a_max = opt.a_max;
            pt.order = opt.order;
            pt.rad = opt.rad;
            pt.algorithm = opt.algorithm;
            pt.percept = opt.percept;
            pt.color = opt.color;
            pt.traj = pt.p;
        end

        function show(pt,gcs)
            if ~isempty(pt.percept.show)
                pt.percept.show(pt.percept,pt.color,gcs); hold(gcs.SimuAxes,'on');
            end
            plot(gcs.SimuAxes,pt.p(1),pt.p(2),[pt.color 'o']);
%             circle_(pt.p,pt.rad,[pt.color '-']);
            plot(gcs.SimuAxes,pt.traj(1,:),pt.traj(2,:),[pt.color '-']);
        end

        function step(pt,dt)
            % run ctrl algo
            pt.control(dt);
            % set ctrl bound
            pt.set_ctrl_bound();
            if ~isempty(pt.percept.update)
                pt.percept = pt.percept.update(pt.percept,dt);
            end
            if pt.order==2
                pt.p_dot = pt.p_dot+pt.p_ddot*dt;
                pt.p = pt.p+pt.p_dot*dt;
            elseif pt.order==1
                pt.p = pt.p+pt.p_dot*dt;
            else
                error('Order should be 1 or 2!');
            end
            pt.traj = [pt.traj pt.p];
        end

        function control(pt,dt)
            if ~isempty(pt.algorithm)
                eval(['pt.' pt.algorithm '(dt);']);
            end
        end
    end
end
