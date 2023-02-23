classdef Point2D < handle
    properties
        p
        p_dot
        p_ddot
        order
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
            [opt,arg] = tb_optparse(opt, varargin);
            % check arg validity
            
            % pt init
            pt.p = opt.p;
            pt.p_dot = opt.p_dot;
            pt.p_ddot = opt.p_ddot;
            pt.order = opt.order;
            pt.algorithm = opt.algorithm;
        end

        function fig = init(pt)
            plot(pt.p(1),pt.p(2),'bo'); 
            hold on
            
            hold off
            fig = gcf;
        end

        function step(pt,data,dt)
            if pt.order==2
                pt.p_ddot = pt.control(data);
                pt.p_dot = pt.p_dot+pt.p_ddot*dt;
                pt.p = pt.p+pt.p_dot*dt;
            elseif pt.order==1
                pt.p_dot = pt.control(data);
                pt.p = pt.p+pt.p_dot*dt;
            else
                error('Order should be 1 or 2!');
            end
            
            plot(pt.p(1),pt.p(2),'bo'); 
            hold on

            hold off
        end

        function u = control(pt,data)
            if isempty(pt.algorithm)
                u = [0;0];
            else
                eval(['u = pt.' pt.algorithm '(data);']);
            end
        end
    end

end
