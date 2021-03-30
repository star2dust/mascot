% MASCOT Config
clear
% robot parameters
radius = 0.8;
altitude = 1;
height = 1.5;
link_list = [1 2 1]*0.8;
disp_end_siz = 2;
angle_safety = 0.9*pi;
[joint_ref_func,robot_desired] = Mascot.jointRef(radius,altitude,height,link_list,angle_safety);
cone = Mascot.coneRef(angle_safety);
% state name and limitation
state_name = 'disp_end,coef_base,joint';
state_lim = struct('vert_affine',diag([1,1]),...
    'disp_end',0.2,...
    'disp_base',1,...
    'siz_base',0.5,... % 1¡À0.5
    'pos_end',0.2);
% environment
envir.lb = [-20,-20];
envir.ub = [20,20];
envir.start = [-12,-12];
envir.goal = [-13,6];
% walls
wall_width = 0.5; 
envir.obstacle{1} = Mascot.wallVert(envir.lb,[envir.ub(1),envir.lb(2)],wall_width,[0,1]);
envir.obstacle{2} = Mascot.wallVert(envir.lb,[envir.lb(1),envir.ub(2)],wall_width,[1,0]);
envir.obstacle{3} = Mascot.wallVert([envir.lb(1),envir.ub(2)],envir.ub,wall_width,[0,1]);
envir.obstacle{4} = Mascot.wallVert(envir.ub,[envir.ub(1),envir.lb(2)],wall_width,[1,0]);
envir.obstacle{5} = Mascot.wallVert([envir.lb(1),-1],[-5,-1],wall_width,[0,1]);
envir.obstacle{6} = Mascot.wallVert([-5,9],[-5,-1],wall_width,[1,0]);
envir.obstacle{7} = Mascot.wallVert([2,-6],[envir.ub(1),-6],wall_width,[0,1]);
wall_num = length(envir.obstacle);
% furnitures
envir.obstacle{wall_num+1} = [-5,9]+Mascot.vertRef(5,eye(2))*3;
envir.obstacle{wall_num+2} = [16,-4]+Mascot.vertRef(3,rot2(-pi/6))*3;
envir.obstacle{wall_num+3} = [4,7]+Mascot.vertRef(4,diag([3,1])*rot2(pi/4))*2;
envir.obstacle{wall_num+4} = [1,-10]+Mascot.vertRef(6,eye(2))*3;
envir.obstacle{wall_num+5} = [16,16]+Mascot.vertRef(15,eye(2))*3;
% plot parameters
is_plotted = struct('robot',true,...
    'label',true,...
    'trajectory',true,...
    'reference',true,...
    'estimation',false,...
    'object',true,...
    'basehat',false,...
    'cone',false,...
    'workrange',false,...
    'obstacle',true,...
    'region',false,...
    'axis',false);
% default script
default.planner = 'polytopeSearch';
default.controller = 'integratedCooperativeControl';
% save config
save('../data/settings');