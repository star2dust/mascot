function [ax,ay] = poly_curve(ma,p,p_dot,dT)
k = length(p(1,:));
t = linspace(0,dT,k);
A = [t'.^5,t'.^4,t'.^3,t'.^2,t',ones(size(t'));
    5*t'.^4,4*t'.^3,3*t'.^2,2*t',ones(size(t')),zeros(size(t'))];
ax = A\[p(1,:)';p_dot(1,:)'];
ay = A\[p(2,:)';p_dot(2,:)'];
end