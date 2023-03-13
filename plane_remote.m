close all
clear

% ��λ��km��km/s

% ����߽糤��lx=ly=Rb=8km
Rb = 2; 
% �ҷ��ɻ�λ��
p = [randlim([0,0,-2,-2;2,2,0,0]);
    randlim([-2,0,0,-2;0,2,2,0])]/2;
th = randlim([-pi;pi]*ones(1,4));
% �ҷ���������
formation = 9;
pr = get_pr_from_f(formation);

% ��������λ��
pc = [randlim([-1;1]*ones(1,size(p,2)));
    randlim([-1;1]*ones(1,size(p,2)))];
% λ��Լ��
p_lb = [-1;-1]*Rb*ones(1,size(p,2));
p_ub = [1;1]*Rb*ones(1,size(p,2));
pc_lb = p_lb;
pc_ub = p_ub;
% �������ճ���
lam_p = zeros(size(p));
lam_pc = lam_p;
eta = lam_p;
% ��������ͼ
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
joy = vrjoystick(1);

% ��ʼ���������
n = size(p,2);
cl = ['r','g','b','c'];
for i=1:n
    ref = struct('pr',p(:,i),'pr_dot',[0;0],'update',@ptr_update,'show',@ptr_show,'color',cl(i));
    pt(i) = Unicycle('q',[p(:,i);th(i)],'order',2,'algorithm','pd_stablize','percept',ref,'color',cl(i));
end
mref = struct('pr',pr,'pr_dot',zeros(size(pr)),'p_lb',p_lb,'p_ub',p_ub,...
    'pc',pc,'pc_dot',zeros(size(pr)),'pc_lb',pc_lb,'pc_ub',pc_ub,'color',cl,...
    'eta',eta,'eta_dot',zeros(size(pr)),'lam_p',lam_p,'lam_p_dot',zeros(size(pr)),...
    'lam_pc',lam_pc,'lam_pc_dot',zeros(size(pr)),'f_curr',formation,'f_prev',formation,...    
    'update',@mptr_update,'show',@mptr_show,'joy',joy,'stop',false,'pr_reset',@get_pr_from_f);
mpt = MultiAgent(pt,'order',1,'D',D,'Omega',Omega,'algorithm','opt_affine_alloc','percept',mref);
% ���÷�����
mas = Mascot('model',mpt,'dt',0.02,'T',200,'xlim',[-1,1]*Rb,'ylim',[-1,1]*Rb);
% ��ʼ����
mas.run();

function ref = ptr_update(ref,dt)
ref.pr = ref.pr+ref.pr_dot*dt;
end

function ptr_show(ref,gcs)
plot(gcs.SimuAxes,ref.pr(1),ref.pr(2),[ref.color '*']);
end

function ref = mptr_update(ref,dt)
ax = axis(ref.joy);
btn = button(ref.joy);
ref.pr_dot = kron(ones(1,size(ref.pr,2)),[ax(1);-ax(2)]);
ref.pr = ref.pr+ref.pr_dot*dt;
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
% ref.pr = get_pr_from_f(ref.formation);
ref.pc = ref.pc+ref.pc_dot*dt;
ref.lam_p = ref.lam_p+ref.lam_p_dot*dt;
ref.lam_pc = ref.lam_pc+ref.lam_pc_dot*dt;
ref.eta = ref.eta+ref.eta_dot*dt;
end

function mptr_show(ref,gcs)
for i=1:size(ref.pr,2)
    plot(gcs.SimuAxes,ref.pr(1,i),ref.pr(2,i),[ref.color(i) 's']);
    plot(gcs.SimuAxes,ref.pc(1,i),ref.pc(2,i),[ref.color(i) 'p']);
end
end

function pr = get_pr_from_f(f)
switch f
    case 1
        % �ҷ��������Σ��뾶2km���α�ӣ�
        pr = [2,0,-2,0;0,2,0,-2];
    case 2
        % �ҷ��������Σ����2km��һ���ͱ�ӣ�
        pr = [3,-1,-3,1;0,0,0,0];
    case 3
        % �ҷ��������Σ����2km��һ���ͱ�ӣ�
        pr = [0,0,0,0;1,3,-1,-3];
    case 4
        % �ҷ��������Σ����2kmƽ���ı���(��)��ӣ�
        pr = [2,-1,-2,1;0,2,0,-2];
    case 5
        % �ҷ��������Σ����2km���ͱ�ӣ�
        pr = [2,-1,-2,1;-1,1,-1,1];
    case 6
        % �ҷ��������Σ����2kmƽ���ı���(Ш)��ӣ�
        pr = [1.5,-0.5,-1.5,0.5;1,1,-1,-1];
    case 7
        % �ҷ��������Σ����2km��Ш�α�ӣ�
        pr = [1.5,-0.5,-1.5,0.5;-2,2,0,0];
    case 8
        % �ҷ��������Σ����2km��Ш�α�ӣ�
        pr = [1.5,-0.5,-1.5,0.5;0,0,-2,2];
    otherwise
        % �ҷ��������Σ��뾶2km�����α�ӣ�
        pr = [1,-1,-1,1;1,1,-1,-1]*2;
end
pr = pr/4;
end