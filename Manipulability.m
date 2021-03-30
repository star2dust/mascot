% MASCOT Manipulability
close all
clear
% load data
current_path = '.';
icc = load([current_path '/data/paper_our_simu'],'data');
nbc = load([current_path '/data/paper_comp_simu'],'data');
% manipulability
for i=1:length(icc.data)
    [~,~,joint(:,:,i)] = Mascot.hatSplit(icc.data(i).opt_state,[2,3,3]);
    for j=1:5
        our_mp(i,j) = PlanarRevolute.getMu([1 2 1],joint(j,:,i));
    end
end
figure
plot(ones(1,5).*(1:length(icc.data))',our_mp);
axis([0 2500 0 3.5])
for i=1:length(nbc.data)
    [~,~,joint(:,:,i)] = Mascot.hatSplit(nbc.data(i).opt_state,[2,3,3]);
    for j=1:5
        comp_mp(i,j) = PlanarRevolute.getMu([1 2 1],joint(j,:,i));
    end
end
figure
plot(ones(1,5).*(1:length(nbc.data))',comp_mp);
axis([0 2500 0 3.5])