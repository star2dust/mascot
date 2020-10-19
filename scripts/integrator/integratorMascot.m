function integratorMascot(robot_num,scale,dir,simu_exp,simu_gph,data_path,debug)

% test setMascot
if nargin<1
    close all
    clear
    robot_num = 5;
    scale = 0.8;
    dir = 1;
    simu_exp = 2;
    simu_gph = 2;
    data_path = './data/integrator';
    debug = 1;
end

% formation parameters
radius = 0.5;
angle_central = 2*pi/robot_num;
if ~mod(robot_num,2)
    disp_end_ref = [cos([0 kron(1:(robot_num-1)/2,[1,-1]) robot_num/2]*angle_central)',...
        sin([0 kron(1:(robot_num-1)/2,[1,-1]) robot_num/2]*angle_central)'];
else
    disp_end_ref = [cos([0 kron(1:(robot_num-1)/2,[1,-1])]*angle_central)',...
        sin([0 kron(1:(robot_num-1)/2,[1,-1])]*angle_central)'];
end
disp_end_siz = 5;
disp_end_ref = (SO2(dir)*disp_end_ref')'*disp_end_siz*scale;
% topology
if simu_gph==2
    graph = selectTopology(robot_num,disp_end_ref);
else
    graph = selectTopology(robot_num);
end
% reference trajectory and obstacles
exp = selectExperiment(simu_exp);
% limitations
disp_end_range = 3;
for i=1:robot_num
    disp_end_lim(:,:,i) = disp_end_ref(i,:)+[-1,-1;1,1]*disp_end_range;
end
% save data
clearvars i
save([data_path '/settings']);
% debug
if debug
    close all
    % plot robots
    for i=1:size(graph.incidence,2)
        plot(disp_end_ref(graph.edge_set(:,i),1),disp_end_ref(graph.edge_set(:,i),2),'k','linewidth',2); hold on
    end
    for i=1:robot_num
        plot(disp_end_ref(i,1),disp_end_ref(i,2),'.','markersize',50);
        text(disp_end_ref(i,1),disp_end_ref(i,2),num2str(i),'horizontalalignment','center','color','w');
    end
    axis([-5 5 -5 5]);
    hold off
end