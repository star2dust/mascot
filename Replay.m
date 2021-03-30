% MASCOT Replay
close all
clear
% load data
current_path = '.';
load([current_path '/data/paper_our_simu'],'data');
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
% plot
dim = 3;
[scene, uiaxis] = Mascot.scenePlot(pos_traj_ref,pos_traj_hat,pos_end,opt_state,opt_scale,current_path,dim,is_plotted);
set(gcf,'color',[1,1,1])
v0 = [0,90]; view(v0);
vd = [-30 40];
stage = length(data)/4;
dv = (vd-v0)/stage;
% replay
video_on = true;
playspeed = 5;
for loop=1:length(data)
    t = loop*0.02;
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
        if loop>stage*1.5&&loop<stage*2.5
            view(v0+dv*(loop-stage*1.5));
        end
        if loop>stage*2.5&&loop<stage*3.5
            view(vd-dv*(loop-stage*2.5));
        end
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