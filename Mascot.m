classdef Mascot < handle
    properties
        t0
        dt
        T
        xlim
        ylim
        zlim
        dim
        model
        start
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
            opt.start = 1;
            [opt,arg] = tb_optparse(opt, varargin);
            % check arg validity
            
            % mas init
            mas.t0 = 0;
            mas.dt = opt.dt;
            mas.T = opt.T;
            mas.xlim = opt.xlim;
            mas.ylim = opt.ylim;
            mas.zlim = opt.zlim;
            mas.dim = opt.dim;
            mas.model = opt.model;
            mas.start = opt.start;
        end

        function canvas(mas,gcs)
            if mas.dim==2
                plot(gcs.SimuAxes,[mas.xlim(1),mas.xlim(1),mas.xlim(2),mas.xlim(2),mas.xlim(1)],...
                    [mas.ylim(1),mas.ylim(2),mas.ylim(2),mas.ylim(1),mas.ylim(1)],'k-','LineWidth',2);
            elseif mas.dim==3
                plot3(gcs.SimuAxes,[mas.xlim(1),mas.xlim(1),mas.xlim(2),mas.xlim(2),mas.xlim(1)],...
                    [mas.ylim(1),mas.ylim(2),mas.ylim(2),mas.ylim(1),mas.ylim(1)],...
                    zeros(1,5),'k-','LineWidth',2);
            end
            hold(gcs.SimuAxes,'on');
        end

        function setparam(mas,gcs)
            set(gcs.SimuAxes,'XLim',mas.xlim,'YLim',mas.ylim,'ZLim',mas.zlim);
            set(gcs.SimuAxes,'XLimMode','manual','YLimMode','manual','ZLimMode','manual');
            set(gcs.SimuFigure,'Name','mascot');
            hold(gcs.SimuAxes,'off');
        end

        function run(mas,gcs)
            if nargin<2
                gcs = [];
            end
            if isempty(gcs)
                gcs.SimuFigure = figure;
                gcs.SimuAxes = axes;
                set(gcs.SimuFigure,'Children',gcs.SimuAxes)
            end
            if ~isempty(mas.model)
                % canvas init
                mas.canvas(gcs);
                % model init
                mas.model.show(gcs);
                % set parameters
                mas.setparam(gcs);
                % start loop
                if mas.start
                   mas.loop(gcs); 
                end
            else
                error('Model is empty!')
            end
        end
        
        function loop(mas,gcs)
            % simulation loop
            while mas.t0<=mas.T
                mas.show(gcs);
                mas.t0 = mas.t0+mas.dt;
            end
        end
        
        function data = show(mas,gcs)
            if nargin<2
                gcs = [];
            end
            if isempty(gcs)
                gcs.SimuFigure = gcf;
                gcs.SimuAxes = gca;
                set(gcs.SimuFigure,'Children',gcs.SimuAxes)
            end
            % canvas renew
            mas.canvas(gcs);
            % model next step
            mas.model.step(mas.dt);
            % model show
            mas.model.show(gcs);
            % param renew
            mas.setparam(gcs);
            % draw now
            pause(mas.dt);
            % data display
            data = [{['algo: ' mas.model.algorithm]},{['time: ' num2str(mas.t0) 's']}];
        end
    end
end
