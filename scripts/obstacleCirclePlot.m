function obstacle = obstacleCirclePlot(pos_obs,obs_siz,robot_radius,obs_safe)
ish = ishold();
if ~ishold
    hold on
end
obstacle = hggroup('Tag', 'obstacles');
for i=1:size(pos_obs,1)
    obs_vert_real = circle_(pos_obs(i,:),obs_siz(i),'n',20);
    real(i) = patch('Faces',1:size(obs_vert_real,1),'Vertices',obs_vert_real,...
        'LineStyle','none','FaceColor','k','FaceAlpha',0.8,'Parent',obstacle);
    obs_vert_dilated = circle_(pos_obs(i,:),obs_siz(i)+robot_radius,'n',20);
    dilated(i) = plot(obs_vert_dilated(:,1),obs_vert_dilated(:,2),'r','LineWidth',1,'Parent',obstacle);
    obs_vert_safe = circle_(pos_obs(i,:),obs_siz(i)+obs_safe+robot_radius,'n',20);
    safe(i) = plot(obs_vert_safe(:,1),obs_vert_safe(:,2),'g','LineWidth',1,'Parent',obstacle);
end
if ~ish
    hold off
end
end