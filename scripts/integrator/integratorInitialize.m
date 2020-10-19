% initial data settings 
function scene = integratorInitialize(uiaxes,data_path,debug)

% test Initialize
if nargin<1
   close all
   clear
   data_path = './data/integrator';
   debug = 1;
end

% load settings
settings = load([data_path '/settings']);
% initial displacement
for i=1:settings.robot_num
    disp_end(i,:) = randlim(settings.disp_end_lim(:,:,i));
end
% initialize trajectory
pos_traj_ref = settings.exp.pos(1,:);
% initial position
pos_end = disp_end+pos_traj_ref;
% other options
pos_traj_hat = [];
var_state = [];
% initialize simulation
scene = integratorPlot(pos_end,settings);
% move figure to uiaxes
if ~debug
    cla(uiaxes)
    axis(uiaxes,settings.exp.lim)
    set(scene.trajectory,'parent',uiaxes)
    set(scene.reference,'parent',uiaxes)
    if settings.simu_exp == 2
        set(scene.obstacle,'parent',uiaxes)
    end
    for i=1:settings.robot_num
        set(scene.base(i),'parent',uiaxes)
        set(scene.label(i),'parent',uiaxes)
    end
    for i=1:size(settings.graph.incidence,2)
        set(scene.graph(i),'parent',uiaxes)
    end
    close(gcf)
    set(uiaxes,'Tag','RTB.plot','NextPlot','replace')
end
% save data
clearvars i
save([data_path '/initials']);
