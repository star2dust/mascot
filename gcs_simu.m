%% simulator settings
function mas = gcs_simu()
% unit£ºkm£¬0.1km/s for fixed-wing
% unit£º100m£¬10m/s for small copter

%% basic config settings
% start = 1 if not use gcs
start = 1;
% clear if not use gcs
if start
    close all
    clear
    start = 1;
end
% boundary length lx=ly=Rb
Rb = 1; 
% remote control
joy_enable = 0;
% omni
omni_enable = 1;
% plane radius
Rp = Rb/50;
% desire formation
fm = 9;
fs = Rb/5;
% multi-agent control in closed-loop or not
clp_enable = 1;
dist_in_loop = fs*(1-omni_enable);
% vel min
v_max = 0.5;
v_min = (1-omni_enable)*v_max/5;
% color: (uav1, 2, 3, 4, 5, remote)
cl = ['y','r','g','b','c','m'];
% track/goal/centroid visible
track_visible = 1;
goal_visible = 1;
cen_visible = 1;
% appearance: (plane, track, goal, centroid)
ap = ['o', '*', 's', 'p'];

%% generate necessary variables
% plane position
p = [randlim([0,0,-1,-1;1,1,0,0]);
    randlim([-1,0,0,-1;0,1,1,0])]*Rb;
th = randlim([-pi;pi]*ones(1,4));
% formation centroid
% pc = [randlim([-1;1]*Rb*ones(1,size(p,2)));
%     randlim([-1;1]*Rb*ones(1,size(p,2)))];
pc = p;
% position bound
p_lb = [-1;-1]*Rb*ones(1,size(p,2));
p_ub = [1;1]*Rb*ones(1,size(p,2));
pc_lb = p_lb;
pc_ub = p_ub;
% lagrangian
lam_p = zeros(size(p));
lam_pc = lam_p;
eta = lam_p;
% network topology
Omega = [1,-1,1,-1;
    -1,1,-1,1;
    1,-1,1,-1;
    -1,1,-1,1];
D = [-1,0,0,1,-1,0;
    1,-1,0,0,0,1;
    0,1,-1,0,1,0;
    0,0,1,-1,0,-1];
if size(p,2)<4
    Omega = D*D';
end
% remote control
if joy_enable
    joy = vrjoystick(1);
else
    joy = [];
end

%% init simulator
n = size(p,2);
for i=1:n
    ref = struct('pr',p(:,i),'pr_dot',[0;0],'update',@ptr_update,'show',@ptr_show,...
        'color',cl(i),'pr_visible',track_visible,'appear',ap(2),'omni',omni_enable);
    if omni_enable
        pt(i) = Point2D('q',[p(:,i);th(i)],'order',2,'algorithm','pd_stablize','percept',ref,...
            'v_min',v_min,'v_max',v_max,'color',cl(i),'appear',ap(1),'rad',Rp);
    else
        pt(i) = Unicycle('q',[p(:,i);th(i)],'order',2,'algorithm','pd_stablize','percept',ref,...
            'v_min',v_min,'v_max',v_max,'color',cl(i),'appear',ap(1),'rad',Rp);
    end
end
mref = struct('pr',p,'pr_dot',zeros(size(p)),'p_lb',p_lb,'p_ub',p_ub,...
    'pc',pc,'pc_dot',zeros(size(p)),'pc_lb',pc_lb,'pc_ub',pc_ub,...
    'eta',eta,'eta_dot',zeros(size(p)),'lam_p',lam_p,'lam_p_dot',zeros(size(p)),...
    'lam_pc',lam_pc,'lam_pc_dot',zeros(size(p)),'f_curr',fm,'f_prev',fm,'f_scale',fs,...    
    'update',@mptr_update,'show',@mptr_show,'joy',joy,'stop',false,'color',cl,...
    'pr_visible',goal_visible,'pc_visible',cen_visible,'appear',ap(3:4));
mpt = MultiAgent(pt,'order',1,'D',D,'Omega',Omega,'algorithm','opt_affine_alloc',...
    'percept',mref,'closed_loop',clp_enable,'dist_in_loop',dist_in_loop);
% set simulator
mas = Mascot('model',mpt,'dt',0.02,'T',200,'xlim',[-1,1]*Rb,'ylim',[-1,1]*Rb,'start',start,'speed',5);
% if not use gcs, then start now
if start
    mas.run();
end
end

%% percept settings
function ref = ptr_update(ref,dt)
ref.pr = ref.pr+ref.pr_dot*dt;
end

function ptr_show(ref,gcs)
if ref.pr_visible
    gcs_plot(gcs.SimuAxes,ref.pr(1),ref.pr(2),[ref.color ref.appear]);
end
end

function ref = mptr_update(ref,dt)
if ~isempty(ref.joy)
    ax = axis(ref.joy);
    btn = button(ref.joy);
    ref.pr_dot = kron(ones(1,size(ref.pr,2)),[ax(1);-ax(2)])*0.8;
    ref.stop = btn(9);
    if btn(1)
        ref.f_curr = 1;
    end
    if btn(2)
        ref.f_curr = 2;
    end
    if btn(3)
        ref.f_curr = 5;
    end
    if btn(4)
        ref.f_curr = 7;
    end
end
ref.pr = ref.pr+ref.pr_dot*dt;
ref.pc = ref.pc+ref.pc_dot*dt;
ref.lam_p = ref.lam_p+ref.lam_p_dot*dt;
ref.lam_pc = ref.lam_pc+ref.lam_pc_dot*dt;
ref.eta = ref.eta+ref.eta_dot*dt;
end

function mptr_show(ref,gcs)
for i=1:size(ref.pr,2)
    if ref.pr_visible
        gcs_plot(gcs.SimuAxes,ref.pr(1,i),ref.pr(2,i),[ref.color(i) ref.appear(1)]);
    end
    if ref.pc_visible
        gcs_plot(gcs.SimuAxes,ref.pc(1,i),ref.pc(2,i),[ref.color(i) ref.appear(2)]);
    end
end
if ~isempty(ref.joy)
    gcs_plot(gcs.SimuAxes,sum(ref.pr(1,:))/size(ref.pr,2),sum(ref.pr(2,:))/size(ref.pr,2),[ref.color(end) ref.appear(end)]);
end
end

function h = gcs_plot(ax,x,y,opt)
h = plot(ax,x,y,opt);
if opt(1)=='y'
    set(h,'Color',[1 0.5 0]);
end
end