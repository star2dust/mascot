function A = check_f_switch(ma,pr_ave)
if ma.percept.f_curr~=ma.percept.f_prev
    ma.percept.pr = ma.get_pr_from_f()+pr_ave;
    ma.percept.f_prev = ma.percept.f_curr;
end
dim = size(ma.p,1);
A = eye(dim*ma.n);
if ma.percept.f_curr==5||ma.percept.f_curr==8
    A(end,end) = -1;
end
if ma.percept.f_curr==7
    A(dim,dim) = -1;
end
end