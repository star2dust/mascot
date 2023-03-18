function [pr_ave,pr_dot_ave] = get_pr_centroid(ma)
pr_ave = sum(ma.percept.pr,2)/size(ma.percept.pr,2);
pr_ave = kron(ones(1,size(pr_ave,2)),pr_ave);
pr_dot_ave = sum(ma.percept.pr_dot,2)/size(ma.percept.pr_dot,2);
pr_dot_ave = kron(ones(1,size(pr_dot_ave,2)),pr_dot_ave);
end