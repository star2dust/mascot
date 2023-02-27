classdef Mascot < handle
    properties
        dt
        T
        xlim
        ylim
        zlim
        dim
        model
        fig
    end

    methods
        function mas = Mascot(varargin)
            % Mascot  Create mas control and optimization tester

            % opt parse: only stated fields are chosen to opt, otherwise to arg
            opt.dt = 0.1;
            opt.T = 200;
            opt.xlim = [-1 1];
            opt.ylim = [-1 1];
            opt.zlim = [-1 1];
            opt.dim = 2;
            opt.model = [];
            opt.fig = [];
            [opt,arg] = tb_optparse(opt, varargin);
            % check arg validity
            
            % mas init
            mas.dt = opt.dt;
            mas.T = opt.T;
            mas.xlim = opt.xlim;
            mas.ylim = opt.ylim;
            mas.zlim = opt.zlim;
            mas.dim = opt.dim;
            mas.model = opt.model;
            mas.fig = opt.fig;
        end

        function canvas(mas)
            if mas.dim==2
                plot([mas.xlim(1),mas.xlim(1),mas.xlim(2),mas.xlim(2),mas.xlim(1)],...
                    [mas.ylim(1),mas.ylim(2),mas.ylim(2),mas.ylim(1),mas.ylim(1)],'k-','LineWidth',2);
            elseif mas.dim==3
                plot3([mas.xlim(1),mas.xlim(1),mas.xlim(2),mas.xlim(2),mas.xlim(1)],...
                    [mas.ylim(1),mas.ylim(2),mas.ylim(2),mas.ylim(1),mas.ylim(1)],...
                    zeros(1,5),'k-','LineWidth',2);
            end
            hold on
        end

        function setparam(mas)
            mas.fig = gcf;
            if ~isempty(mas.fig)
                set(mas.fig.Children,'XLim',mas.xlim,'YLim',mas.ylim,'ZLim',mas.zlim);
            end
            set(mas.fig,'Name','mascot');
            hold off
        end

        function run(mas)
            if ~isempty(mas.model)
                % canvas init
                mas.canvas();
                % model init
                mas.model.show();
                % set parameters
                mas.setparam();
                for t = 0:mas.dt:mas.T
                    % canvas renew
                    mas.canvas();
                    % model next step
                    mas.model.step(mas.dt);
                    % model show
                    mas.model.show();
                    % param renew
                    mas.setparam();
                    % draw now
                    pause(mas.dt); 
                end
            else
                error('Model is empty!')
            end
        end
    end
end
