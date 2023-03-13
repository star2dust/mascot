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
    end

    methods
        function uni = Unicycle(varargin)
            % Unicycle  Create 2D simple unicyle

            % opt parse: only stated fields are chosen to opt, otherwise to arg
            opt.q = [0;0;0];
            opt.v = 0;
            opt.w = 0;
            opt.a = 0;
            opt.rad = 0.02;
            opt.ahead = opt.rad;
            opt.v_min = 0.12;
            opt.w_min = -1;
            opt.a_min = -2;
            opt.v_max = 1;
            opt.w_max = 1;
            opt.a_max = 2;
            opt.order = 1;
            opt.algorithm = '';
            opt.color = 'b';
            opt.ntrj = 300;
            opt.percept = struct('update',[],'show',[]);
            [opt,arg] = tb_optparse(opt, varargin);
            % check arg validity
            
            % uni init
            uni.q = opt.q;
            uni.v = opt.v;
            uni.w = opt.w;
            uni.a = opt.a;
            uni.v_min = opt.v_min;
            uni.w_min = opt.w_min;
            uni.a_min = opt.a_min;
            uni.v_max = opt.v_max;
            uni.w_max = opt.w_max;
            uni.a_max = opt.a_max;
            uni.order = opt.order;
            uni.algorithm = opt.algorithm;
            uni.percept = opt.percept;
            uni.color = opt.color;
            uni.rad = opt.rad;
            % head init
            uni.ahead = opt.ahead;
            uni.get_ahead_point();
            % traj init
            uni.traj = uni.q;
            uni.ntrj = opt.ntrj;
        end

        function show(uni,gcs)
            if ~isempty(uni.percept.show)
                uni.percept.show(uni.percept,gcs); hold(gcs.SimuAxes,'on');
            end
            plot(gcs.SimuAxes,uni.q(1),uni.q(2),[uni.color 'o']);
%             circle(uni.q(1:2),uni.rad,[uni.color '-']);
            plot(gcs.SimuAxes,[uni.p(1) uni.q(1)],[uni.p(2) uni.q(2)],[uni.color '-']);
            if size(uni.traj,2)<=uni.ntrj
                plot(gcs.SimuAxes,uni.traj(1,:),uni.traj(2,:),[uni.color '-']);
            else
                plot(gcs.SimuAxes,uni.traj(1,end-uni.ntrj:end),uni.traj(2,end-uni.ntrj:end),[uni.color '-']);
            end
        end

        function step(uni,dt)
            % get ahead point
            uni.get_ahead_point();
            % run ctrl algo
            uni.control(dt);
            % set ctrl bound
            uni.set_ctrl_bound();
            if ~isempty(uni.percept.update)
                uni.percept = uni.percept.update(uni.percept,dt);
            end
            if uni.order==2
                uni.v = uni.v+uni.a*dt;
                uni.q = uni.q+[cos(uni.q(3)),0;sin(uni.q(3)),0;0,1]*[uni.v;uni.w]*dt;
            elseif uni.order==1
                uni.q = uni.q+[cos(uni.q(3)),0;sin(uni.q(3)),0;0,1]*[uni.v;uni.w]*dt;
            else
                error('Order should be 1 or 2!');
            end
            uni.traj = [uni.traj uni.q];
        end

        function control(uni,dt)
            if ~isempty(uni.algorithm)
                eval(['uni.' uni.algorithm '(dt);']);
            end
        end
    end
end
