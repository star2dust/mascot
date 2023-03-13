function mas = gcs_simu()

% 单位：km，km/s

% 区域边界长度lx=ly=Rb=8km
Rb = 2;
% 我方飞机位置
p = [randlim([0,0,-2,-2;2,2,0,0]);
    randlim([-2,0,0,-2;0,2,2,0])]/2;
th = randlim([-pi;pi]*ones(1,4));
% 我方期望队形
formation = 9;
pr = get_pr_from_f(formation);

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
% 网络拓扑�?
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

% 初始化仿真对�?
n = size(p,2);
cl = ['r','g','b','c'];
for i=1:n
    ref = struct('pr',p(:,i),'pr_dot',[0;0],'update',@ptr_update,'show',@ptr_show);
    pt(i) = Unicycle('q',[p(:,i);th(i)],'order',2,'algorithm','pd_stablize','percept',ref,'color',cl(i));
end
mref = struct('pr',pr,'pr_dot',zeros(size(pr)),'p_lb',p_lb,'p_ub',p_ub,...
    'pc',pc,'pc_dot',zeros(size(pr)),'pc_lb',pc_lb,'pc_ub',pc_ub,...
    'eta',eta,'eta_dot',zeros(size(pr)),'lam_p',lam_p,'lam_p_dot',zeros(size(pr)),...
    'lam_pc',lam_pc,'lam_pc_dot',zeros(size(pr)),'formation',formation,...
    'update',@mptr_update,'show',@mptr_show);
mpt = MultiAgent(pt,'order',1,'D',D,'Omega',Omega,'algorithm','opt_affine_alloc','percept',mref,'formation',formation);
% 设置仿真�?
mas = Mascot('model',mpt,'dt',0.02,'T',200,'xlim',[-1,1]*Rb,'ylim',[-1,1]*Rb,'start',0);
end


function ref = ptr_update(ref,dt)
ref.pr = ref.pr+ref.pr_dot*dt;
end

function ptr_show(ref,cl,gcs)
plot(gcs.SimuAxes,ref.pr(1),ref.pr(2),[cl '*']);
end

function ref = mptr_update(ref,dt)
% ref.pr = ref.pr+ref.pr_dot*dt;
ref.pr = get_pr_from_f(ref.formation);
ref.pc = ref.pc+ref.pc_dot*dt;
ref.lam_p = ref.lam_p+ref.lam_p_dot*dt;
ref.lam_pc = ref.lam_pc+ref.lam_pc_dot*dt;
ref.eta = ref.eta+ref.eta_dot*dt;
end

function mptr_show(ref,cl,gcs)
for i=1:size(ref.pr,2)
    plot(gcs.SimuAxes,ref.pr(1,i),ref.pr(2,i),[cl(i) 's']);
    plot(gcs.SimuAxes,ref.pc(1,i),ref.pc(2,i),[cl(i) 'p']);
end
end

function pr = get_pr_from_f(f)
switch f
    case 1
        % 我方期望队形（半�?2km菱形编队�?
        pr = [2,0,-2,0;0,2,0,-2];
    case 2
        % 我方期望队形（间�?2km横一字型编队�?
        pr = [3,-1,-3,1;0,0,0,0];
    case 3
        % 我方期望队形（间�?2km竖一字型编队�?
        pr = [0,0,0,0;1,3,-1,-3];
    case 4
        % 我方期望队形（间�?2km平行四边�?(�?)编队�?
        pr = [2,-1,-2,1;0,2,0,-2];
    case 5
        % 我方期望队形（间�?2km梯型编队�?
        pr = [2,-1,-2,1;-1,1,-1,1];
    case 6
        % 我方期望队形（间�?2km平行四边�?(�?)编队�?
        pr = [1.5,-0.5,-1.5,0.5;1,1,-1,-1];
    case 7
        % 我方期望队形（间�?2km左楔形编队）
        pr = [1.5,-0.5,-1.5,0.5;-2,2,0,0];
    case 8
        % 我方期望队形（间�?2km右楔形编队）
        pr = [1.5,-0.5,-1.5,0.5;0,0,-2,2];
    otherwise
        % 我方期望队形（半�?2km正方形编队）
        pr = [1,-1,-1,1;1,1,-1,-1];
end
pr = pr/2;
end