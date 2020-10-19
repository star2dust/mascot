function exp = selectExperiment(simu_exp)

if nargin<1
    debug = true;
    simu_exp = 1;
else
    debug = false;
end
switch simu_exp
    case 1
        % start point
        pos_init = [6,6];
        time_total = 30;
        % via points
        pos_via = pos_init+[0,0;time_total,0];
        axis_lim = [0 45 -5 15];
        % trajectory
        [time_ref,pos_ref,dot_pos_ref] = sinetraj(pos_via,time_total);
        % plot map data
        if debug
            showtraj(pos_ref,dot_pos_ref,time_ref,axis_lim);
        end
        % save traj data
        exp.time = time_ref;
        exp.pos = pos_ref;
        exp.dot_pos = dot_pos_ref;
        exp.lim = axis_lim;
    otherwise
        % start point
        pos_init = [19,19];
        pos_final = [6,6];
        time_total = 11;
        % via points
        pos_via = [pos_init;
            pos_final];
        axis_lim = [0 25 0 25];
        % vision
        [time_ref,pos_ref,dot_pos_ref] = linetraj(pos_via,time_total);
        % obstacle
        obs_siz = 3.2*[1,1]; rad = 0.8;
        po_dis = [4.5,4]'+rad+obs_siz;
        pos_obs = [11,11;12,12]+po_dis.*[-1,1;1,-1]/sqrt(2);
        % plot map data
        if debug
            showtraj(pos_ref,dot_pos_ref,time_ref,axis_lim);
        end
        % save traj data
        exp.time = time_ref;
        exp.pos = pos_ref;
        exp.dot_pos = dot_pos_ref;
        exp.lim = axis_lim;
        exp.obs = pos_obs;
        exp.siz = obs_siz;
end
end


function [t_ref,pos_ref,dot_pos_ref] = linetraj(pos_via,time_total)
% Generate line trajectory

vel = diff(pos_via)/time_total;
dt = 0.01;
t_ref = 0:dt:time_total;
% save data
pos_ref = t_ref'.*vel+pos_via(1,:);
dot_pos_ref = ones(size(t_ref')).*vel;
end

function [t_ref,pos_ref,dot_pos_ref,ddot_pos_ref] = sinetraj(pos_via,time_total)
% Generate sine trajectory
vel_y = 2*pi/time_total; height_y = 3; dt = 0.01; 
vel_x = norm(diff(pos_via))/time_total; 
t_ref = 0:dt:time_total; 
pos_ref = pos_via(1,:)+[vel_x*t_ref(:),height_y*sin(vel_y*t_ref(:))];
dot_pos_ref = [vel_x*ones(length(t_ref(:)),1),height_y*vel_y*cos(vel_y*t_ref(:))];
ddot_pos_ref = [0*ones(length(t_ref(:)),1),-height_y*vel_y^2*sin(vel_y*t_ref(:))];

end

function traj_handle = showtraj(pos_ref,dot_pos_ref,time_ref,axis_lim)
% Show 2D trajectory

figure
traj_handle.traj = plot(pos_ref(:,1),pos_ref(:,2)); hold on
if nargin<4
    axis equal
else
    axis(axis_lim)
end
xpr = pos_ref(1,:);
traj_handle.ref = plot(xpr(1),xpr(2),'o');
dtpr = diff(time_ref);
for i=1:size(pos_ref,1)-1
    xpr = xpr + dot_pos_ref(i,:)*dtpr(i);
    set(traj_handle.xpr,'xdata',xpr(1),'ydata',xpr(2));
    drawnow
end

end