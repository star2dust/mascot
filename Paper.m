% MASCOT Paper Illustration
close all
clear
% load data
current_path = '.';
load([current_path '/data/paper_our_simu'],'data');
% choose figure
select = 2;
switch select
    case 1
        %% Figure 1
        % initials
        pos_traj_ref = data(end).pos_traj_ref;
        pos_traj_hat = data(end).pos_traj_hat;
        pos_end = data(end).pos_end;
        opt_state = data(end).opt_state;
        opt_scale = data(end).opt_scale;
        % plot parameters
        is_plotted = struct('robot',true,...
            'label',true,...
            'trajectory',true,...
            'reference',true,...
            'estimation',false,...
            'object',true,...
            'basehat',false,...
            'cone',false,...
            'workrange',true,...
            'obstacle',true,...
            'region',false,...
            'axis',false);
        % plot figure 1
        figure
        dim = 3;
        Mascot.scenePlot(pos_traj_ref,pos_traj_hat,pos_end,opt_state,opt_scale,current_path,dim,is_plotted);
    case 2
        %% Figure 2
        close all
        clear
        % load data
        current_path = '.';
        load([current_path '/data/paper_our_simu'],'data');
        load([current_path '/data/settings'],'robot_desired')
        load([current_path '/data/initials'],'disp_base_mat_func','robot_num')
        % initials
        pos_traj_ref = data(1).pos_traj_ref;
        pos_traj_hat = data(1).pos_traj_hat;
        pos_end = data(1).pos_end;
        opt_state = data(1).opt_state;
        opt_scale = data(1).opt_scale;
        % plot parameters
        is_plotted = struct('robot',true,...
            'label',true,...
            'trajectory',true,...
            'reference',true,...
            'estimation',false,...
            'object',true,...
            'basehat',false,...
            'cone',false,...
            'workrange',true,...
            'obstacle',true,...
            'region',false,...
            'axis',false);
        % plot figure 1
        figure
        dim = 2;
        [scene, uiaxis] = Mascot.scenePlot(pos_traj_ref,pos_traj_hat,pos_end,opt_state,opt_scale,current_path,dim,is_plotted);
        % replay
        video_on = false;
        traj_on = false;
        playspeed = 5;
        ctr = 0; pic = 4;
        loop_old = 1;
        for loop=1:length(data)
            t = loop*0.02;
            if mod(t,13)==0
                hold on
                ctr = ctr+1;
                if ctr==pic&&traj_on
                    for j=1:loop-loop_old+1
                        pos_traj_hat(:,:,j) = data(j+loop_old).pos_traj_hat;
                        pos_end(:,:,j) = data(j+loop_old).pos_end;
                        opt_state(:,:,j) = data(j+loop_old).opt_state;
                        opt_scale(:,j) = data(j+loop_old).opt_scale;
                        for i=1:size(pos_end,1)
                            [~,~,~,pos_base(i,:,j),~] = Mascot.optStateSplit(robot_desired,...
                                opt_state(i,:,j),pos_end(i,:,j),pos_traj_hat(i,1:2,j),disp_base_mat_func(i,0,opt_scale(i,j)));
                        end
                    end
                    pos_base_x = squeeze(pos_base(:,1,:));
                    pos_base_y = squeeze(pos_base(:,2,:));
                    plot(pos_base_x',pos_base_y',':','LineWidth',1.2)
                end
                hold off
                loop_old = loop;
            end
            % update figure
            if mod(loop,playspeed)==0
                % state load
                pos_traj_ref = data(loop).pos_traj_ref;
                pos_traj_hat = data(loop).pos_traj_hat;
                pos_end = data(loop).pos_end;
                opt_state = data(loop).opt_state;
                opt_scale = data(loop).opt_scale;
                % animate
                scene = Mascot.sceneAnimate(scene,pos_traj_ref,pos_traj_hat,pos_end,opt_state,opt_scale,current_path);
                % video
                if video_on
                    frame(loop/playspeed) = getframe(gcf);
                end
                drawnow
            end
        end
        if video_on
            savevideo([current_path '/data/video'],frame);
        end
end