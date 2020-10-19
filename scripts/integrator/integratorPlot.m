function scene = integratorPlot(pos_end,settings)

close all
robot_num = settings.robot_num;
graph = settings.graph;
% robots
for i=1:size(graph.incidence,2)
    scene.graph(i) = plot(pos_end(settings.graph.edge_set(:,i),1),...
        pos_end(settings.graph.edge_set(:,i),2),'k','linewidth',2); hold on
end
axis(settings.exp.lim);
for i=1:robot_num
    scene.base(i) = plot(pos_end(i,1),pos_end(i,2),'.','markersize',40);
    scene.label(i) = text(pos_end(i,1),pos_end(i,2),num2str(i),'horizontalalignment','center','color','w');
end
% reference trajectory and obstacles
scene.trajectory = plot(settings.exp.pos(:,1),settings.exp.pos(:,2),'k','LineWidth',1);
if settings.simu_exp==2
    obs_safe = 1;
    scene.obstacle = obstacleCirclePlot(settings.exp.obs,settings.exp.siz,settings.radius,obs_safe);
end
% reference position
pos_traj_ref = settings.exp.pos(1,:);
scene.reference = plot(pos_traj_ref(:,1),pos_traj_ref(:,2),'rx','LineWidth',1);
hold off
end