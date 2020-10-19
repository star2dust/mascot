function scene = integratorAnimate(scene,pos_traj_ref,pos_end,settings)

robot_num = settings.robot_num;
graph = settings.graph;
% robots
for i=1:size(graph.incidence,2)
    set(scene.graph(i),'xdata',pos_end(graph.edge_set(:,i),1),...
        'ydata',pos_end(graph.edge_set(:,i),2)); 
end
for i=1:robot_num
    set(scene.base(i),'xdata',pos_end(i,1),'ydata',pos_end(i,2));
    set(scene.label(i),'position',pos_end(i,:));
end
% reference position
set(scene.reference,'xdata',pos_traj_ref(:,1),'ydata',pos_traj_ref(:,2));
end