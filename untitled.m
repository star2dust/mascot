close all
clear

% x = [0 1 2.5 3.6 5 7 8.1 10];
% y = sin(x);
% xx = 0:.25:10;
% yy = spline(x,y,xx);
% plot(x,y,'o',xx,yy)
% hold on
% plot(xx,sin(xx),'b-')

dt = 0.1;
p = [randlim([-1,1]'*ones(1,3));randlim([-1,1]'*ones(1,3))];
p_dot = diff(p')'/dt;

plot(p(1,:),p(2,:),'b'); hold on

x_seq = p(1,:);
y_seq = p(2,:);
k = length(x_seq);

t_seq = linspace(0,2*dt,k);
I_seq = linspace(0,2*dt,100);
X_seq = spline(t_seq,x_seq,I_seq);
Y_seq = spline(t_seq,y_seq,I_seq);
path = [X_seq', Y_seq'];

plot(path(:,1),path(:,2),'r')

ax = polyfit(t_seq,x_seq,k-1);
X_seq = polyval(ax,I_seq);
ay = polyfit(t_seq,y_seq,k-1);
Y_seq = polyval(ay,I_seq);
path = [X_seq', Y_seq'];

plot(path(:,1),path(:,2),'g')


dt = 0.1;
t = 0:dt:2*dt;
A = [t'.^5,t'.^4,t'.^3,t'.^2,t',ones(size(t'));
    5*t'.^4,4*t'.^3,3*t'.^2,2*t',ones(size(t')),zeros(size(t'))];
ax = A\[p(1,:)';p_dot(1,:)'];
ay = A\[p(2,:)';p_dot(2,:)'];

t = 0:0.001:2*dt;
x = [t'.^5,t'.^4,t'.^3,t'.^2,t',ones(size(t'))]*ax;
y = [t'.^5,t'.^4,t'.^3,t'.^2,t',ones(size(t'))]*ay;
plot(x,y,'m')



