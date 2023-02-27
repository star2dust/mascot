classdef Point2D < handle
    properties
        % state
        p
        p_dot
        p_ddot
        % order (1 or 2)
        order
        % color
        color
        % percept (struct) with function 'update' and 'show'
        percept
        % algorithm (string) choose which algo to use
        algorithm
    end

    methods
        function pt = Point2D(varargin)
            % Point2D  Create 2D simple point

            % opt parse: only stated fields are chosen to opt, otherwise to arg
            opt.p = [0;0];
            opt.p_dot = [0;0];
            opt.p_ddot = [0;0];
            opt.order = 1;
            opt.algorithm = '';
            opt.color = 'b';
            opt.percept = struct('update',[],'show',[]);
            [opt,arg] = tb_optparse(opt, varargin);
            % check arg validity
            
            % pt init
            pt.p = opt.p;
            pt.p_dot = opt.p_dot;
            pt.p_ddot = opt.p_ddot;
            pt.order = opt.order;
            pt.algorithm = opt.algorithm;
            pt.percept = opt.percept;
            pt.color = opt.color;
        end

        function show(pt)
            if ~isempty(pt.percept.show)
                pt.percept.show(pt.percept,pt.color); hold on;
            end
            plot(pt.p(1),pt.p(2),[pt.color 'o']);
        end

        function step(pt,dt)
            pt.control();
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
        end

        function control(pt)
            if ~isempty(pt.algorithm)
                eval(['pt.' pt.algorithm '();']);
            end
        end
    end
end
