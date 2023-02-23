classdef Mascot < handle
    properties
        dt
        T
        xlim
        ylim
        zlim
        model
        data
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
            opt.model = [];
            opt.fig = [];
            opt.data = struct('update',[]);
            [opt,arg] = tb_optparse(opt, varargin);
            % check arg validity
            
            % mas init
            mas.dt = opt.dt;
            mas.T = opt.T;
            mas.xlim = opt.xlim;
            mas.ylim = opt.ylim;
            mas.zlim = opt.zlim;
            mas.model = opt.model;
            mas.fig = opt.fig;
            mas.data = opt.data;
        end

        function run(mas)
            if ~isempty(mas.model)
                mas.fig = mas.model.init();
                set(mas.fig,'Name','mascot');
                for t = 0:mas.dt:mas.T
                    % data update
                    mas.data.update();
                    % next step
                    mas.model.step(mas.data,mas.dt);
                    if ~isempty(mas.fig)
                        set(mas.fig.Children,'XLim',mas.xlim,'YLim',mas.ylim,'ZLim',mas.zlim);
                    end
                    % draw now
                    pause(mas.dt);
                end
            else
                error('Model is empty!')
            end
        end
    end
end
