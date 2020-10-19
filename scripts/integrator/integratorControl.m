function [dot_pos_end,dot_var_scale,dot_var_dir] = integratorControl(pos_traj_ref,...
    pos_end,var_scale,var_dir,dot_pos_traj_ref,settings)

% topology
graph = settings.graph;
disp_end_ref = settings.disp_end_ref;
% control gains
gain_tracking = 0.5;
gain_formation = 5;
% scale and dir
dot_var_scale = -gain_tracking*(var_scale-settings.scale);
dot_var_dir = -gain_tracking*(var_dir-settings.dir);
dot_disp_end = zeros(size(pos_end));
% disp_end
if settings.simu_gph==2
    disp_end = pos_end-pos_traj_ref;
    leader_num = 3;
    for i=1:leader_num
        disp_end_leader(i,:) = (SO2(var_dir(i))*disp_end_ref(i,:)')'*var_scale(i);
        dot_disp_end_leader(i,:) = (SO2(var_dir(i))*disp_end_ref(i,:)')'*dot_var_scale(i)...
            +(dot_var_dir(i)*[0,-1;1,0]*SO2(var_dir(i)).R*disp_end_ref(i,:)')'*var_scale(i);
    end
    % disp_end - leader
    dot_disp_end(1:leader_num,:) = dot_disp_end_leader(1:leader_num,:)...
        -gain_tracking*(disp_end(1:leader_num,:)-disp_end_leader(1:leader_num,:));
    % disp_end - follower
    stress_fl = graph.stress(leader_num+1:end,1:leader_num);
    stress_ff = graph.stress(leader_num+1:end,leader_num+1:end);
    dot_disp_end(leader_num+1:end,:) = -stress_ff^-1*(stress_fl*dot_disp_end(1:leader_num,:)...
        +gain_formation*[stress_fl, stress_ff]*disp_end);
    % pos_end
    dot_pos_end = dot_disp_end+dot_pos_traj_ref;
else
    % pos_end
    dot_pos_end = dot_pos_traj_ref-gain_tracking*(pos_end-disp_end_ref-pos_traj_ref);
end

end