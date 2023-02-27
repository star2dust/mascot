close all
clear

ref = struct('pr',[-0.5;-0.5],'pr_dot',[0.1;0.02],'update',@update,'show',@show);
pt = Point2D('order',2,'algorithm','pd_stablize','percept',ref);
mas = Mascot('model',pt,'dt',0.02,'T',200);
mas.run();

function ref = update(ref,dt)
ref.pr = ref.pr+ref.pr_dot*dt;
end

function show(ref,cl)
plot(ref.pr(1),ref.pr(2), [cl '*'])
end