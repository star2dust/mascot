% release 1.4 2024.06.24
% 1、连接飞机时关闭控制计时器√
% 2、读写配置文件×
% 3、全起飞判定修改为存在起飞判定√
% 4、增加heading_dist输入配置√
% 5、调参移到控制界面√
% 6、切航点不需要下载，循环中读航点√
% 7、簇头选举为navid最靠前且航点距离最近的√

% release 1.3 2024.06.19
% 1、簇头为0时显示PlanUAVID指定的UAV航点
% 2、读写飞控参数支持Plane-4.3.7

% release 1.2 2024.06.17
% 1、APMParams判空，未读取处理
% 2、以后先设置默认参数，能读取APMParams再修改
% 3、MapGPSOrigin赋值挪到前面
% 4、在Pt3D加一个airspd_flag