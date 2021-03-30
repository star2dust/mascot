function [trajectory,region] = polytopeSearch(envir,robotdes,robotnum,linkscale,dispbaseref,dispendref)
% polytopeSearch    Generate a collision-free polytope graph by sampling 
% and search a feasible path. References are listed as follows:
% [1] J. Alonso-Mora, S. Baker, and D. Rus, ¡°Multi-robot formation control 
%     and object transport in dynamic environments via constrained optimization,¡± 
%     Int. J. Rob. Res., vol. 36, no. 9, pp. 1000¨C1021, Aug. 2017.
% [2] R. Deits and R. Tedrake, ¡°Computing large convex regions of obstacle-free
%     space through semidefinite programming,¡± in Springer Tracts in Advanced 
%     Robotics, 2015, vol. 107, pp. 109¨C124.

%% initialize an empty polytope graph
% z nodes
nodez = []; % z vector in row
nodepoly = []; % polytope struct
nodezinpoly = {}; % z index
% z configs
ang = []; siz = 1;
config.vec = [ang,siz];
config.lb = [ang-pi,0.2/linkscale];
config.ub = [ang+pi,1/linkscale];
% z edges
edgez = []; % z index
%% dilate obstacles
for i=1:length(envir.obstacle)
    envir.obstacle{i} = dilate(envir.obstacle{i},robotdes.radius);
end
%% initialize nodez with start and goal
[nodez, nodepoly, nodezinpoly] = polyinit(nodez,nodepoly,nodezinpoly,config,envir,robotnum,dispbaseref,dispendref);
% add goal to graph
[nodez,nodezinpoly,nodegrid,edgez] = polyadd(nodez,nodepoly,nodezinpoly,edgez,1,config,envir,robotnum,dispbaseref,dispendref);
% check if there is a feasible path between start(1) and goal(2)
[noderoute,polyroute] = polyastar(nodez,nodezinpoly,nodegrid,1,2);
%% add random node to graph
ctr = 0;
while isempty(noderoute)
    % generate 5 node per loop
    randnum = 1;
    [nodez,nodepoly,nodezinpoly] = polyrand(nodez,nodepoly,nodezinpoly,randnum,config,envir,robotnum,dispbaseref,dispendref);
    % create undirected graph and its edges
    [nodez,nodezinpoly,nodegrid,edgez] = polyadd(nodez,nodepoly,nodezinpoly,edgez,randnum,config,envir,robotnum,dispbaseref,dispendref);
    [noderoute,polyroute] = polyastar(nodez,nodezinpoly,nodegrid,1,2);
    ctr = ctr + 1;
end
%% generate trajectory and region
region = nodepoly(polyroute);
[x,dx,ddx,t] = mstraj_(nodez(noderoute,:),ones(1,size(nodez,2))*2,0.1,2);
trajectory = struct('pos',x,'dot_pos',dx,...
    'ddot_pos',ddx,'time',t);
end