close all
clear

pt = Point2D('order',2,'algorithm','tracking');
data = struct('p',[0.5;0.5],'update',[]);
mas = Mascot('model',pt,'data',data,'dt',0.02,'T',200);
mas.run();
