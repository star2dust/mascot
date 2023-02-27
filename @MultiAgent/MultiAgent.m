classdef MultiAgent < handle
    properties %(Access = private)
        % number and model
        n
        model
        % state
        p
        p_dot
        p_ddot
        % order
        order
        % topology
        D
        L
        Omega
        % algorithm (string) chooses which algo to use
        algorithm
        % percept (struct) with function 'update' and 'show'
        percept
        % color
        color
    end

    methods
        function ma = MultiAgent(varargin)
            % ma  Create multi-agent system

            % opt parse: only stated fields are chosen to opt, otherwise to arg
            opt.D = [];
            opt.Omega = [];
            opt.order = 1;
            opt.algorithm = '';
            opt.percept = struct('update',[],'show',[]);
            [opt,arg] = tb_optparse(opt, varargin);
            % check arg validity
            ma.model = arg{1};
            % ma init
            ma.n = length(ma.model);
            for i=1:ma.n
                ma.p(:,i) = ma.model(i).p;
                ma.p_dot(:,i) = ma.model(i).p_dot;
                ma.p_ddot(:,i) = ma.model(i).p_ddot;
                ma.color(i) = ma.model(i).color;
            end
            ma.order = opt.order;
            ma.D = opt.D;
            ma.L = ma.D*ma.D';
            ma.Omega = opt.Omega;
            ma.algorithm = opt.algorithm;
            ma.percept = opt.percept;
        end

        function show(ma)         
            if ~isempty(ma.percept.show)
                ma.percept.show(ma.percept,ma.color); hold on;
            end
            for i=1:ma.n
                ma.model(i).show(); 
            end
        end

        function step(ma,dt)
            ma.control();
            if ~isempty(ma.percept.update)
                ma.percept = ma.percept.update(ma.percept,dt);
            end
            if ma.order==2
                ma.p_dot = ma.p_dot+ma.p_ddot*dt;
                ma.p = ma.p+ma.p_dot*dt;
            elseif ma.order==1
                ma.p = ma.p+ma.p_dot*dt;
            else
                error('Order should be 1 or 2!');
            end
            for i=1:ma.n
                ma.model(i).step(dt);
            end
        end

        function control(ma)
            if ~isempty(ma.algorithm)
                eval(['ma.' ma.algorithm '();']);
            end
        end
    end
end
