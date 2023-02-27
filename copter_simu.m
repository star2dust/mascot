close all
clear

% 单位：km，km/s

% 区域边界长度lx=ly=Rb=8km
Rb = 8; 
% 我方飞机位置
p = [randlim([0,0,-2,-2;2,2,0,0]);
    randlim([-2,0,0,-2;0,2,2,0])];
% 我方期望队形（半径2km菱形编队）
pr = [1,0,-1,0;0,1,0,-1]*2;

% 队形中心位置
pc = [randlim([-1;1]*ones(1,size(p,2)));
    randlim([-1;1]*ones(1,size(p,2)))];
% 位置约束
p_lb = [-1;-1]*Rb*ones(1,size(p,2));
p_ub = [1;1]*Rb*ones(1,size(p,2));
pc_lb = p_lb;
pc_ub = p_ub;
% 拉格朗日乘子
lam_p = zeros(size(p));
lam_pc = lam_p;
eta = lam_p;
% 网络拓扑图
Omega = [1,-1,1,-1;
    -1,1,-1,1;
    1,-1,1,-1;
    -1,1,-1,1];
D = [-1,0,0,1,-1,0;
    1,-1,0,0,0,1;
    0,1,-1,0,1,0;
    0,0,1,-1,0,-1];

% 初始化仿真对象
n = size(p,2);
cl = ['r','g','b','c'];
for i=1:n
    ref = struct('pr',p(:,i),'pr_dot',[0;0],'update',@ptr_update,'show',@ptr_show);
    pt(i) = Point2D('p',p(:,i),'order',2,'algorithm','pd_stablize','percept',ref,'color',cl(i));
end
mref = struct('pr',pr,'pr_dot',zeros(size(pr)),'p_lb',p_lb,'p_ub',p_ub,...
    'pc',pc,'pc_dot',zeros(size(pr)),'pc_lb',pc_lb,'pc_ub',pc_ub,...
    'eta',eta,'eta_dot',zeros(size(pr)),'lam_p',lam_p,'lam_p_dot',zeros(size(pr)),...
    'lam_pc',lam_pc,'lam_pc_dot',zeros(size(pr)),...    
    'update',@mptr_update,'show',@mptr_show);
mpt = MultiAgent(pt,'order',1,'D',D,'Omega',Omega,'algorithm','opt_affine_alloc','percept',mref);
% 设置仿真器
mas = Mascot('model',mpt,'dt',0.02,'T',200,'xlim',[-1,1]*Rb,'ylim',[-1,1]*Rb);
% 开始仿真
mas.run();

function ref = ptr_update(ref,dt)
ref.pr = ref.pr+ref.pr_dot*dt;
end

function ptr_show(ref,cl)
% plot(ref.pr(1),ref.pr(2),[cl '*']);
end

function ref = mptr_update(ref,dt)
ref.pr = ref.pr+ref.pr_dot*dt;
ref.pc = ref.pc+ref.pc_dot*dt;
ref.lam_p = ref.lam_p+ref.lam_p_dot*dt;
ref.lam_pc = ref.lam_pc+ref.lam_pc_dot*dt;
ref.eta = ref.eta+ref.eta_dot*dt;
end

function mptr_show(ref,cl)
for i=1:size(ref.pr,2)
%     plot(ref.pr(1,i),ref.pr(2,i),[cl(i) 's']);
    plot(ref.pc(1,i),ref.pc(2,i),[cl(i) 'p']);
end
end