classdef MultiAgent < handle
    properties (SetAccess = private)
        % number and model
        n
        model
        % state
        p
        p_dot
        p_ddot
    end

    properties
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
        % closed loop
        closed_loop
        dist_in_loop
        % v keep space
        v_space
    end

    methods
        function ma = MultiAgent(varargin)
            % ma  Create multi-agent system

            % opt parse: only stated fields are chosen to opt, otherwise to arg
            opt.D = [];
            opt.Omega = [];
            opt.order = 1;
            opt.closed_loop = 1;
            opt.dist_in_loop = 0.5;
            opt.v_space = 0.2;
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
            ma.closed_loop = opt.closed_loop;
            ma.dist_in_loop = opt.dist_in_loop;
            ma.v_space = opt.v_space;
            ma.D = opt.D;
            ma.L = ma.D*ma.D';
            ma.Omega = opt.Omega;
            ma.algorithm = opt.algorithm;
            ma.percept = opt.percept;
            % pr init
            pr_ave = sum(ma.percept.pr,2)/size(ma.percept.pr,2);
            pr_ave = kron(ones(1,size(pr_ave,2)),pr_ave);
            ma.percept.pr = ma.get_pr_from_f()+pr_ave;
        end

        function show(ma,gcs)         
            if ~isempty(ma.percept.show)
                ma.percept.show(ma.percept,gcs); hold(gcs.SimuAxes,'on');
            end
            for i=1:ma.n
                ma.model(i).show(gcs);
            end
        end

        function step(ma,dt)
            % get model state
            if ma.closed_loop
                ma.get_model_state();
            end
            % run ctrl algo
            ma.control(dt);
            % set ctrl bound
            ma.set_ctrl_bound();
            % send pr to model
            ma.set_pr_to_model();
            % update
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

        function control(ma,dt)
            if ~isempty(ma.algorithm)
                % old version code
                % eval(['ma.' ma.algorithm '(dt);']);
                ma.(ma.algorithm)(dt);
            end
        end
    end
end
