classdef HGC_r1_0 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure              matlab.ui.Figure
        TabGroupMap           matlab.ui.container.TabGroup
        TabMap                matlab.ui.container.Tab
        MapGPSUnify           matlab.ui.control.Button
        MapGPSSet             matlab.ui.control.Button
        MapGPSLon             matlab.ui.control.NumericEditField
        MapGPSLonLabel        matlab.ui.control.Label
        MapGPSLat             matlab.ui.control.NumericEditField
        MapGPSLatLabel        matlab.ui.control.Label
        UAVIDList             matlab.ui.control.EditField
        UAVIDListLabel        matlab.ui.control.Label
        CtrlTimeLabel         matlab.ui.control.Label
        CopyrightLabel        matlab.ui.control.Label
        TabGroupFlight        matlab.ui.container.TabGroup
        TabFlight             matlab.ui.container.Tab
        CmdPanel              matlab.ui.container.Panel
        SwitchNavStart        matlab.ui.control.Button
        GuidedStart           matlab.ui.control.StateButton
        DisplayStart          matlab.ui.control.StateButton
        PageScroll            matlab.ui.control.Button
        UAVPanel_4            matlab.ui.container.Panel
        GridLayout_4          matlab.ui.container.GridLayout
        AirspdSelect_4        matlab.ui.control.NumericEditField
        AirspdSelectLabel_4   matlab.ui.control.Label
        Climbspd_4            matlab.ui.control.EditField
        ClimbspdLabel_4       matlab.ui.control.Label
        Alt_4                 matlab.ui.control.EditField
        AltLabel_4            matlab.ui.control.Label
        Airspd_4              matlab.ui.control.EditField
        AirspdLabel_4         matlab.ui.control.Label
        Groundspd_4           matlab.ui.control.EditField
        GroundspdLabel_4      matlab.ui.control.Label
        AirspdSet_4           matlab.ui.control.Button
        ModeList_4            matlab.ui.control.DropDown
        ModeSet_4             matlab.ui.control.Button
        HudDeg_4              Aero.ui.control.ArtificialHorizon
        AngleDeg_4            Aero.ui.control.HeadingIndicator
        UAVPanel_3            matlab.ui.container.Panel
        GridLayout_3          matlab.ui.container.GridLayout
        AirspdSet_3           matlab.ui.control.Button
        AirspdSelect_3        matlab.ui.control.NumericEditField
        AirspdSelectLabel_3   matlab.ui.control.Label
        Climbspd_3            matlab.ui.control.EditField
        ClimbspdLabel_3       matlab.ui.control.Label
        Alt_3                 matlab.ui.control.EditField
        AltLabel_3            matlab.ui.control.Label
        Airspd_3              matlab.ui.control.EditField
        AirspdLabel_3         matlab.ui.control.Label
        Groundspd_3           matlab.ui.control.EditField
        GroundspdLabel_3      matlab.ui.control.Label
        ModeList_3            matlab.ui.control.DropDown
        ModeSet_3             matlab.ui.control.Button
        HudDeg_3              Aero.ui.control.ArtificialHorizon
        AngleDeg_3            Aero.ui.control.HeadingIndicator
        UAVPanel_2            matlab.ui.container.Panel
        GridLayout_2          matlab.ui.container.GridLayout
        AirspdSelect_2        matlab.ui.control.NumericEditField
        AirspdSelectLabel_2   matlab.ui.control.Label
        Climbspd_2            matlab.ui.control.EditField
        ClimbspdLabel_2       matlab.ui.control.Label
        Alt_2                 matlab.ui.control.EditField
        AltLabel_2            matlab.ui.control.Label
        Airspd_2              matlab.ui.control.EditField
        AirspdLabel_2         matlab.ui.control.Label
        Groundspd_2           matlab.ui.control.EditField
        GroundspdLabel_2      matlab.ui.control.Label
        AirspdSet_2           matlab.ui.control.Button
        ModeList_2            matlab.ui.control.DropDown
        ModeSet_2             matlab.ui.control.Button
        HudDeg_2              Aero.ui.control.ArtificialHorizon
        AngleDeg_2            Aero.ui.control.HeadingIndicator
        UAVPanel_1            matlab.ui.container.Panel
        GridLayout_1          matlab.ui.container.GridLayout
        AirspdSelect_1        matlab.ui.control.NumericEditField
        AirspdSelectLabel_1   matlab.ui.control.Label
        Climbspd_1            matlab.ui.control.EditField
        ClimbspdLabel_1       matlab.ui.control.Label
        Alt_1                 matlab.ui.control.EditField
        AltLabel_1            matlab.ui.control.Label
        Airspd_1              matlab.ui.control.EditField
        AirspdLabel_1         matlab.ui.control.Label
        Groundspd_1           matlab.ui.control.EditField
        GroundspdLabel_1      matlab.ui.control.Label
        AirspdSet_1           matlab.ui.control.Button
        ModeList_1            matlab.ui.control.DropDown
        ModeSet_1             matlab.ui.control.Button
        HudDeg_1              Aero.ui.control.ArtificialHorizon
        AngleDeg_1            Aero.ui.control.HeadingIndicator
        TabPlanning           matlab.ui.container.Tab
        FormationPanel        matlab.ui.container.Panel
        FormationGrid         matlab.ui.container.GridLayout
        FormAltKeep           matlab.ui.control.DropDown
        FormAltKeepLabel      matlab.ui.control.Label
        FormDispZ             matlab.ui.control.NumericEditField
        FormDispZLabel        matlab.ui.control.Label
        FormDispY             matlab.ui.control.NumericEditField
        FormDispYLabel        matlab.ui.control.Label
        FormDispX             matlab.ui.control.NumericEditField
        FormDispXLabel        matlab.ui.control.Label
        FormCenTrack          matlab.ui.control.DropDown
        FormCenTrackLabel     matlab.ui.control.Label
        FormRadSlider         matlab.ui.control.Slider
        FormRadSliderLabel    matlab.ui.control.Label
        FormType              matlab.ui.control.DropDown
        FormTypeLabel         matlab.ui.control.Label
        FormAng               matlab.ui.control.DropDown
        FormAngLabel          matlab.ui.control.Label
        FormScale             matlab.ui.control.DropDown
        FormScaleLabel        matlab.ui.control.Label
        FormDispRead          matlab.ui.control.Button
        FormDispModify        matlab.ui.control.Button
        FormDispUpload        matlab.ui.control.Button
        FormDispDownload      matlab.ui.control.Button
        FormClear             matlab.ui.control.Button
        FormationStart        matlab.ui.control.StateButton
        FormationGroup        matlab.ui.container.ButtonGroup
        FormationMode_5       matlab.ui.control.RadioButton
        FormationMode_4       matlab.ui.control.RadioButton
        FormationMode_3       matlab.ui.control.RadioButton
        FormationMode_2       matlab.ui.control.RadioButton
        FormationMode_1       matlab.ui.control.RadioButton
        TaskPanel             matlab.ui.container.Panel
        TaskGrid              matlab.ui.container.GridLayout
        PlanUAVTeamLabel      matlab.ui.control.Label
        PlanUAVTeam           matlab.ui.control.DropDown
        TaskAltSet            matlab.ui.control.Button
        TaskAng               matlab.ui.control.NumericEditField
        TaskAngLabel          matlab.ui.control.Label
        TaskRad               matlab.ui.control.NumericEditField
        TaskRadLabel          matlab.ui.control.Label
        TaskAlt               matlab.ui.control.NumericEditField
        TaskAltLabel          matlab.ui.control.Label
        PlanTaskID            matlab.ui.control.DropDown
        PlanTaskIDLabel       matlab.ui.control.Label
        PlanUAVID             matlab.ui.control.DropDown
        PlanUAVIDLabel        matlab.ui.control.Label
        TaskModify            matlab.ui.control.Button
        TaskSwitch            matlab.ui.control.Button
        TaskUpload            matlab.ui.control.Button
        TaskDownload          matlab.ui.control.Button
        TaskClear             matlab.ui.control.Button
        CanvasPanel           matlab.ui.container.Panel
        CanvasGrid            matlab.ui.container.GridLayout
        NavModify             matlab.ui.control.StateButton
        NavSwitch             matlab.ui.control.Button
        NavTime               matlab.ui.control.NumericEditField
        NavTimeLabel          matlab.ui.control.Label
        NavSpd                matlab.ui.control.NumericEditField
        NavSpdLabel           matlab.ui.control.Label
        NavRad                matlab.ui.control.NumericEditField
        NavRadLabel           matlab.ui.control.Label
        NavAlt                matlab.ui.control.NumericEditField
        NavAltLabel           matlab.ui.control.Label
        NavCmd                matlab.ui.control.DropDown
        NavCmdLabel           matlab.ui.control.Label
        NavID                 matlab.ui.control.DropDown
        NavIDLabel            matlab.ui.control.Label
        NavUpload             matlab.ui.control.Button
        NavDownload           matlab.ui.control.Button
        CanvasClear           matlab.ui.control.Button
        CanvasStart           matlab.ui.control.StateButton
        TaskGroup             matlab.ui.container.ButtonGroup
        TaskMode_5            matlab.ui.control.RadioButton
        TaskMode_4            matlab.ui.control.RadioButton
        TaskMode_3            matlab.ui.control.RadioButton
        TaskMode_2            matlab.ui.control.RadioButton
        TaskMode_1            matlab.ui.control.RadioButton
        CanvasGroup           matlab.ui.container.ButtonGroup
        CanvasMode_4          matlab.ui.control.RadioButton
        CanvasMode_3          matlab.ui.control.RadioButton
        CanvasMode_2          matlab.ui.control.RadioButton
        CanvasMode_1          matlab.ui.control.RadioButton
        TabDecision           matlab.ui.container.Tab
        UIAxes                matlab.ui.control.UIAxes
        TabSetting            matlab.ui.container.Tab
        NetworkPanel          matlab.ui.container.Panel
        NetworkGrid           matlab.ui.container.GridLayout
        IP_3                  matlab.ui.control.EditField
        IPLabel_3             matlab.ui.control.Label
        IP_2                  matlab.ui.control.EditField
        IPLabel_2             matlab.ui.control.Label
        IP_1                  matlab.ui.control.EditField
        IPLabel_1             matlab.ui.control.Label
        PilotPanel            matlab.ui.container.Panel
        PilotGrid             matlab.ui.container.GridLayout
        PilotRTLAltLabel      matlab.ui.control.Label
        PilotRTLAlt           matlab.ui.control.NumericEditField
        PilotTkoffAltLabel    matlab.ui.control.Label
        PilotTkoffAlt         matlab.ui.control.NumericEditField
        PilotAirspdMaxLabel   matlab.ui.control.Label
        PilotAirspdMax        matlab.ui.control.NumericEditField
        PilotAirspdMinLabel   matlab.ui.control.Label
        PilotAirspdMin        matlab.ui.control.NumericEditField
        PilotAirspdWorkLabel  matlab.ui.control.Label
        PilotAirspdWork       matlab.ui.control.NumericEditField
        PilotRTLRadLabel      matlab.ui.control.Label
        PilotRTLRad           matlab.ui.control.NumericEditField
        PilotLoiterRadLabel   matlab.ui.control.Label
        PilotLoiterRad        matlab.ui.control.NumericEditField
        PilotWPRadLabel       matlab.ui.control.Label
        PilotWPRad            matlab.ui.control.NumericEditField
        PilotSysIDLabel       matlab.ui.control.Label
        PilotSysID            matlab.ui.control.NumericEditField
        PilotButtonRead       matlab.ui.control.Button
        PilotButtonWrite      matlab.ui.control.Button
        ConfigPanel           matlab.ui.container.Panel
        ConfigGrid            matlab.ui.container.GridLayout
        ConfigDebug           matlab.ui.control.StateButton
        ConfigEastRight       matlab.ui.control.NumericEditField
        ConfigEastLeft        matlab.ui.control.NumericEditField
        ConfigNorthRight      matlab.ui.control.NumericEditField
        ConfigNorthLeft       matlab.ui.control.NumericEditField
        ConfigButtonRead      matlab.ui.control.Button
        ConfigButtonWrite     matlab.ui.control.Button
        ConfigLabelEast       matlab.ui.control.Label
        ConfigLabelNorth      matlab.ui.control.Label
        LinkPanel             matlab.ui.container.Panel
        LinkGrid              matlab.ui.container.GridLayout
        IPAddr                matlab.ui.control.DropDown
        IPAddrLabel           matlab.ui.control.Label
        YawErr                matlab.ui.control.NumericEditField
        YawErrLabel           matlab.ui.control.Label
        GPSErr                matlab.ui.control.NumericEditField
        GPSErrLabel           matlab.ui.control.Label
        WorkAltLabel          matlab.ui.control.Label
        WorkAlt               matlab.ui.control.NumericEditField
        WorkAltDistLabel      matlab.ui.control.Label
        WorkAltDist           matlab.ui.control.NumericEditField
        WorkAltErrLabel       matlab.ui.control.Label
        WorkAltErr            matlab.ui.control.NumericEditField
        WorkAltMin            matlab.ui.control.NumericEditField
        WorkAltMinLabel       matlab.ui.control.Label
        LinkPort              matlab.ui.control.NumericEditField
        LinkPortLabel         matlab.ui.control.Label
        LinkID                matlab.ui.control.DropDown
        LinkIDLabel           matlab.ui.control.Label
        WorkButtonRead        matlab.ui.control.Button
        WorkButtonWrite       matlab.ui.control.Button
        LinkButtonOff         matlab.ui.control.Button
        LinkButtonOn          matlab.ui.control.Button
    end

    
    properties (Access = private)
        % py.apm_vehicle
        APMVehicle
        APMParams
        VehicleListID
        VehicleMode
        VehiclePosX
        VehiclePosY
        VehicleAirspd
        VehicleGroundspd
        VehicleYaw
        VehicleYawspd
        VehicleAlt
        VehicleAltWork
        VehicleNumMax
        % Pt3D
        VehicleGuidedPoint
        TkoffAll
        MasterID
        MasterNavID
        RealHomeGPS
        % Canvas
        PlanCanvas
        % Flight Display
        PageFlight
        PageListID
        % Map Display
        MapGPSOrigin
        NorthLimit
        EastLimit
        HandleVehicle
        % Timer
        TimerDisplay
        DisplayStep
        DisplayCount
        TimerGuided
        GuidedStep
        % Time Synchronize
        TimeSynch
        TimeNow
        TimeToc
        TimeNavpt
        TimeErr
        % Color
        ColorList
    end
    
    methods (Access = private)
        
        function LoadConfig(app)
            % ***matlab调用python方法***
            % 使用之前运行 pyenv('Version' ,'executable') 配置python环境
            % executable = '你的python完整路径，注意最后是python.exe'
            % 最后把个人库加入python路径↓
            pylib = './PyLib';
            try
                py.sys.path().index(pylib);
            catch
                py.sys.path().append(pylib);
            end
            app.NorthLimit = [app.ConfigNorthLeft.Value; app.ConfigNorthRight.Value];
            app.EastLimit = [app.ConfigEastLeft.Value; app.ConfigEastRight.Value];
            app.ColorList = 'bgmcry';
            % 飞机状态相关初始化
            app.APMVehicle = cell(1,length(app.LinkID.Items));
            app.TkoffAll = 0;
            % 显示/控制循环周期
            app.DisplayCount = 20;
            app.DisplayStep = 0.5;
            app.GuidedStep = 0.4;
            % 簇头航点初始化
            app.MasterID = 0;
            app.MasterNavID = 0;
            % 控制计时初始化
            app.CtrlTimeLabel.Text = '';
            app.TimeSynch = 0;
            app.TimeNavpt = 0;
            app.TimeNow = 0;
            app.TimeErr = 0;
            tic
            % 地图原点初始化
            app.MapGPSSet.Enable = "off";
            app.MapGPSUnify.Enable = "off";
            % 工作高度按ID顺序递增，最多VehicleNumMax架
            app.VehicleNumMax = length(app.LinkID.Items);
            app.VehicleAltWork = app.WorkAlt.Value:app.WorkAltDist.Value:app.WorkAlt.Value+app.WorkAltDist.Value*(app.VehicleNumMax-1);
        end

        function DisplayLoop(app,varargin)
            try
                app.MapDisplay();
                app.FlightDisplay();
                app.DisplayCount = 20;
            catch
                % timer has some unknown bugs
                % try to stop and start again
                if app.DisplayCount>=0
                    warning("Display loop has some bugs, to be restart...")
                    app.SetTimerDisplay(false);
                    pause(0.5)
                    app.SetTimerDisplay(true);
                    app.DisplayCount = app.DisplayCount-1;
                else
                    warning("Display loop restarts 20 times, try to stop...")
                    app.SetTimerDisplay(false);
                end
            end
        end
        
        function OpenAPMVehicle(app,id,port)
            if isempty(app.APMVehicle)||isempty(app.APMVehicle{id})
                try
                    app.LinkButtonOn.Text = '连接中';
                    pause(0.1)
                    ip_ind = app.ValueIndexInItems(app.IPAddr.Value,app.IPAddr.Items);
                    ip_str = app.(['IP_' num2str(ip_ind)]).Value;
                    % py.(py文件名).(类名/函数名)
                    app.APMVehicle{id} = py.apm_vehicle.Plane([ip_str ':' num2str(port)], ...
                        [num2str(id) 'plane'], app.WorkAlt.Value, app.WorkAltDist.Value, app.WorkAltErr.Value, app.WorkAltMin.Value,...
                        app.GPSErr.Value, app.YawErr.Value);
                    % 等待home点，解锁后读home有bug，仅在锁定时候读
                    if ~app.APMVehicle{id}.vehicle.armed
                        home_gps = double(app.APMVehicle{id}.wait_home_GPS());
                        if length(home_gps)==1&&home_gps==0
                            % 失败读取默认地图原点
                            home_gps = [app.APMVehicle{id}.map_origin.ref_lat;app.APMVehicle{id}.map_origin.ref_lon];
                            get_real_gps = 0;
                        else
                            get_real_gps = 1;
                        end
                    else
                        % 解锁后读取默认地图原点
                        home_gps = [app.APMVehicle{id}.map_origin.ref_lat;app.APMVehicle{id}.map_origin.ref_lon];
                        get_real_gps = 0;
                    end
                    % 等待GPS
                    app.APMVehicle{id}.wait_curr_GPS();
                    % 使能"断开"，禁用"连接"
                    app.LinkButtonOff.Enable = "on";
                    % 如果ListID为空，则直接赋值
                    if isempty(app.VehicleListID)||isempty(find(id==app.VehicleListID, 1))
                        % 如果ListID为空，则在id大于该id之前处添加
                        if ~isempty(app.VehicleListID)
                            find_bigger = 0;
                            for i=1:length(app.VehicleListID)
                                if app.VehicleListID(i)>id
                                    find_bigger = 1;
                                    break;
                                end
                            end
                            % 如果find_bigger=0则ListID全比该id小，i=length+1
                            % 如果find_bigger=1则ListID能找到比该id大的，i=i
                            i = i+1-find_bigger;
                        else
                            % 如果ListID为空，i=0
                            i = 0;
                        end
                        if i<=0
                            app.VehicleListID = id;
                            app.VehicleMode = "连接";
                            app.VehiclePosX = 0;
                            app.VehiclePosY = 0;
                            app.VehicleAirspd = 0;
                            app.VehicleGroundspd = 0;
                            app.VehicleYaw = 0;
                            app.VehicleYawspd = 0;
                            app.VehicleAlt = 0;
                            % 读取飞控参数，必须在VehicleListID赋值之后运行
                            app.PilotButtonReadPushed();
                            % 类数值初始化必须直接赋值一次，否则默认为double数组
                            app.VehicleGuidedPoint = Pt3D('id',id,'airspd_min',app.APMParams{id}.AIRSPEED_MIN,'airspd_max',app.APMParams{id}.AIRSPEED_MAX);
                            % ***canvas画布使用方法***
                            % select_point启动，cancel_point结束
                            % 设置mode选择模式：选点、删除、移动、插入
                            app.PlanCanvas = Canvas(app.UIFigure,app.UIAxes,app.EastLimit,app.NorthLimit);
                            % 地图原点仅在连接第一个飞机时更新
                            app.MapGPSOrigin = home_gps(:);
                            % 如果是真实GPS坐标，可设置为默认地图原点
                            if get_real_gps
                                app.RealHomeGPS = 1;
                                app.MapGPSUnify.Enable = "on";
                            else
                                app.RealHomeGPS = 0;
                                app.MapGPSUnify.Enable = "off";
                            end
                        else
                            app.VehicleListID = [app.VehicleListID(1:i-1) id app.VehicleListID(i:end)];
                            app.VehicleMode = [app.VehicleMode(1:i-1) "连接" app.VehicleMode(i:end)];
                            app.VehiclePosX = [app.VehiclePosX(1:i-1) 0 app.VehiclePosX(i:end)];
                            app.VehiclePosY = [app.VehiclePosY(1:i-1) 0 app.VehiclePosY(i:end)];
                            app.VehicleAirspd = [app.VehicleAirspd(1:i-1) 0 app.VehicleAirspd(i:end)];
                            app.VehicleGroundspd = [app.VehicleGroundspd(1:i-1) 0 app.VehicleGroundspd(i:end)];
                            app.VehicleYaw = [app.VehicleYaw(1:i-1) 0 app.VehicleYaw(i:end)];
                            app.VehicleYawspd = [app.VehicleYawspd(1:i-1) 0 app.VehicleYawspd(i:end)];
                            app.VehicleAlt = [app.VehicleAlt(1:i-1) 0 app.VehicleAlt(i:end)];
                            % 读取飞控参数，必须在VehicleListID赋值之后运行
                            app.PilotButtonReadPushed();
                            % 类数值初始化必须直接赋值一次，否则默认为double数组
                            app.VehicleGuidedPoint = [app.VehicleGuidedPoint(1:i-1) Pt3D('id',id,'airspd_min',app.APMParams{id}.AIRSPEED_MIN,'airspd_max',app.APMParams{id}.AIRSPEED_MAX) app.VehicleGuidedPoint(i:end)];
                            % ***canvas画布使用方法***
                            % select_point启动，cancel_point结束
                            % 设置mode选择模式：选点、删除、移动、插入
                            app.PlanCanvas = [app.PlanCanvas(1:i-1) Canvas(app.UIFigure,app.UIAxes,app.EastLimit,app.NorthLimit) app.PlanCanvas(i:end)];
                        end
                    end
                    % 使能"断开"，禁用"连接"
                    app.LinkButtonOn.Enable = "off";
                catch
                    if id<=length(app.APMVehicle)
                        try
                            app.APMVehicle{id}.close();
                        catch
                            warning(['[ ' num2str(id) 'plane ] Cannot close APM vehicle'])
                        end
                    end
                    warning(['[ ' num2str(id) 'plane ] Cannot connect to 192.168.80.1:' num2str(port)])
                end
            end
            app.LinkButtonOn.Text = '连接';
        end

        function CloseAPMVehicle(app,id)
            if ~isempty(app.APMVehicle)&&~isempty(app.APMVehicle{id})
                try
                    app.LinkButtonOff.Text = '断开中';
                    pause(0.1)
                    % 关闭py类
                    app.APMVehicle{id}.close();
                    delete(app.APMVehicle{id});
                    app.APMVehicle{id} = [];
                    % 删除飞控参数
                    app.APMParams{id} = [];
                    % 使能"连接"，禁用"断开"
                    app.LinkButtonOn.Enable = "on";
                    % 如果ListID非空，且存在该ID，则找到该ID所在索引并删除
                    ind = find(id==app.VehicleListID);
                    if ~isempty(app.VehicleListID)&&~isempty(ind)
                        app.VehicleListID(ind) = [];
                        app.VehicleMode(ind) = [];
                        app.VehiclePosX(ind) = [];
                        app.VehiclePosY(ind) = [];
                        app.VehicleAirspd(ind) = [];
                        app.VehicleGroundspd(ind) = [];
                        app.VehicleYaw(ind) = [];
                        app.VehicleYawspd(ind) = [];
                        app.VehicleAlt(ind) = [];
                        delete(app.VehicleGuidedPoint(ind).htraj);
                        delete(app.VehicleGuidedPoint(ind).htext);
                        delete(app.VehicleGuidedPoint(ind).hhead);
                        delete(app.VehicleGuidedPoint(ind));
                        app.VehicleGuidedPoint(ind) = [];
                        delete(app.PlanCanvas(ind).hline);
                        delete(app.PlanCanvas(ind).hnavid);
                        delete(app.PlanCanvas(ind));
                        app.PlanCanvas(ind) = [];
                    end
                    % 使能"连接"，禁用"断开"
                    app.LinkButtonOff.Enable = "off";
                catch
                    warning(['[ ' num2str(id) 'plane ] Cannot close vehicle object']);
                end
            end
            app.LinkButtonOff.Text = '断开';
        end
        
        function MapDisplay(app)
            if ~isempty(app.APMVehicle)&&~isempty(app.VehicleListID)
                app.PlanUAVID.Items = string(app.VehicleListID);
                for i=1:length(app.VehicleListID)
                    id = app.VehicleListID(i);
                    gps = double(app.APMVehicle{id}.wait_curr_GPS());
                    % 判断GPS是否成功定位，gps==0为失败，gps==[lat;lon]为成功
                    if length(gps)==2
                        % 如果GPS定位[0;0]，则说明飞控本身无法定位
                        % 取默认地图原点为GPS坐标
                        if sum(gps)==0
                            gps = [app.APMVehicle{id}.map_origin.ref_lat;app.APMVehicle{id}.map_origin.ref_lon];
                        end
                        xy = double(app.APMVehicle{id}.map_origin.GPStoXYwithRef(gps(1), gps(2), app.MapGPSOrigin(1), app.MapGPSOrigin(2)));
                        % 输出中文模式名（get_mode只能输出英文）
                        modeuint = double(app.APMVehicle{id}.mode_str2uint());
                        modestr = char(app.APMVehicle{id}.mode_uint2str(modeuint,true));
                        app.VehicleMode(i) = modestr;
                        % 飞机状态相关更新（所有飞机）
                        % apm: x-north,y-east, axes: x-east, y-north
                        app.VehiclePosX(i) = xy(1);
                        app.VehiclePosY(i) = xy(2);
                        app.VehicleAirspd(i) = double(app.APMVehicle{id}.vehicle.airspeed);
                        app.VehicleGroundspd(i) = double(app.APMVehicle{id}.vehicle.groundspeed);
                        app.VehicleYaw(i,:) = double(app.APMVehicle{id}.vehicle.attitude.yaw);
                        rpyspd = double(app.APMVehicle{id}.get_spd_RPY());
                        app.VehicleYawspd(i) = rpyspd(3);
                        app.VehicleAlt(i) = double(app.APMVehicle{id}.get_curr_alt());
                        % 航点轨迹相关更新（所有飞机）
                        p_vehicle = [xy(:);-app.VehicleAlt(i)];
                        heading = double(app.APMVehicle{id}.vehicle.heading);
                        if heading>180
                            heading = heading-360;
                        end
                        yawgps = heading/180*pi;
                        p_heading = p_vehicle+rotz(yawgps)*[app.VehicleGuidedPoint(i).heading_dist;0;0];
                        if app.VehicleAlt(i)<app.APMVehicle{id}.alt_min
                            if app.VehicleGuidedPoint(i).tkoff_flag
                                app.VehicleGuidedPoint(i).tkoff_flag = 0;
                            end
                        else
                            if ~app.VehicleGuidedPoint(i).tkoff_flag
                                app.VehicleGuidedPoint(i).tkoff_flag = 1;
                            end
                        end
                        app.VehicleGuidedPoint(i).update(p_vehicle,p_heading);
                        % 航点颜色相关更新（所有飞机）
                        color_select = i;
                        while color_select>length(app.ColorList)
                            color_select = color_select-length(app.ColorList);
                        end
                        app.VehicleGuidedPoint(i).color = app.ColorList(color_select);
                        % 任务规划相关更新（选中飞机）
                        ind = app.ValueIndexInItems(app.PlanUAVID.Value,app.PlanUAVID.Items);
                        if i==ind
                            countnext = double(app.APMVehicle{id}.get_waypoint(0));   
                            if app.VehicleAlt(i)<app.APMVehicle{id}.alt_min
                                app.TaskPanel.Title = '操作台|地面';
                                app.CanvasPanel.Title = '操作台|地面';
                            else
                                app.TaskPanel.Title = '操作台|飞行';
                                app.CanvasPanel.Title = '操作台|飞行';
                                app.PlanCanvas(i).navid = countnext(2);
                            end
                        end
                    end
                end
                app.UAVIDList.Value = num2str(app.VehicleListID);
                app.MapGPSLat.Value = app.MapGPSOrigin(1);
                app.MapGPSLon.Value = app.MapGPSOrigin(2);
                % 判断飞机是否均起飞，一旦全部起飞，不再判断
                if app.TkoffAll==0
                    all_tkoff = 1;
                    for i=1:length(app.VehicleListID)
                        if app.VehicleAlt(i)<app.APMVehicle{app.VehicleListID(i)}.alt_min
                            all_tkoff = 0;
                            break;
                        end
                    end
                    if all_tkoff
                        app.TkoffAll = 1;
                        % 一旦全部起飞，设置最小ID为簇头
                        app.MasterID = app.VehicleListID(1);
                    end
                end
                % 如果是真实GPS坐标，可设置为默认地图原点
                if app.RealHomeGPS
                    app.MapGPSUnify.Enable = "on";
                else
                    app.MapGPSUnify.Enable = "off";
                end
                app.MapGPSSet.Enable = "on";
            else
                app.UAVIDList.Value = '';
                app.MapGPSLat.Value = 0;
                app.MapGPSLon.Value = 0;
                app.TaskPanel.Title = '操作台|地面';
                app.CanvasPanel.Title = '操作台|地面';
                app.MapGPSSet.Enable = "off";
            end
            % 以下是画图部分，无论有没有飞机连接都运行
            % apm: x-north,y-east, axes: x-east, y-north
            if isempty(app.HandleVehicle)
                app.HandleVehicle = plot(app.UIAxes,app.VehiclePosY,app.VehiclePosX,'.','MarkerSize',50,'Color',[1,0.5,0.5],'UserData',2);
            else
                % 有HandleVehicle之后，才开始进行其他绘制
                set(app.HandleVehicle,'XData',app.VehiclePosY,'YData',app.VehiclePosX);
                % 航点轨迹绘制
                for ind = 1:length(app.VehicleGuidedPoint)
                    app.VehicleGuidedPoint(ind).show(app.UIAxes);
                end
                % 每一个无人机都有一个Canvas，注意索引ind并非id号
                ind = app.ValueIndexInItems(app.PlanUAVID.Value,app.PlanUAVID.Items);
                for i=1:length(app.PlanCanvas)
                    if i==ind&&ind<=length(app.VehicleGuidedPoint)&&app.VehicleGuidedPoint(ind).mission_flag
                        % 对于有效的ind，NED坐标转画图坐标
                        app.PlanCanvas(ind).xlist = app.VehicleGuidedPoint(ind).ylist;
                        app.PlanCanvas(ind).ylist = app.VehicleGuidedPoint(ind).xlist;
                    else
                        % 否则，清空画图
                        app.PlanCanvas(i).xlist = [];
                        app.PlanCanvas(i).ylist = [];
                    end
                    app.PlanCanvas(i).show_figdata();
                end
                % 图层冒泡排序，按照UserData从小到大
                graph = app.UIAxes.Children;
                for i=length(graph):-1:1
                    for j=1:i-1
                        if graph(j).UserData>graph(j+1).UserData
                             temp = graph(j);
                             graph(j) = graph(j+1);
                             graph(j+1) = temp;
                        end
                    end
                end
                app.UIAxes.Children = graph;
            end 
        end
        
        function FlightDisplay(app)
            if ~isempty(app.VehicleListID)
                % 确定本页4个面板无人机ID
                app.PageListID = [];
                uav_num = length(app.VehicleListID);
                page_num = ceil(uav_num/4);
                % page scroll loop
                if isempty(app.PageFlight)||app.PageFlight>page_num
                    app.PageFlight = 1;
                end
                % page 1~n-1
                if app.PageFlight<page_num||uav_num<=4
                    for i=1:4
                        panel_in_page = (app.PageFlight-1)*4+i;
                        if (panel_in_page<=uav_num)
                            app.PageListID(i) = app.VehicleListID(panel_in_page);
                        else
                            break;
                        end
                    end
                % page n
                else
                    for i=uav_num-3:uav_num
                        app.PageListID(i-uav_num+4) = app.VehicleListID(i);
                    end
                end
                % 更新1页中的4个面板
                for panel_count=1:4
                    if panel_count<=length(app.PageListID)
                        id = app.PageListID(panel_count);
                        ind = find(id==app.VehicleListID);
                        % 模式名str转char便于后续构建char数组
                        modestr = char(app.VehicleMode(ind));
                        armed = app.APMVehicle{id}.vehicle.armed;
                        roll = double(app.APMVehicle{id}.vehicle.attitude.roll/pi*180);
                        pitch = double(app.APMVehicle{id}.vehicle.attitude.pitch/pi*180);
                        heading = double(app.APMVehicle{id}.vehicle.heading);
                        % 电池读不到为none，无法转换double
                        try
                            battery = double(app.APMVehicle{id}.vehicle.battery.level);
                        catch
                            battery = 0;
                        end
                        alt = app.VehicleAlt(ind);
                        airspd = app.VehicleAirspd(ind);
                        xyzspd = double(app.APMVehicle{id}.get_spd_XYZ());
                        climbspd = -ceil(xyzspd(3)*10)/10;
                        groundspd = app.VehicleGroundspd(ind);
                        app.(['HudDeg_' num2str(panel_count)]).Value = [roll,pitch];
                        app.(['AngleDeg_' num2str(panel_count)]).Value = heading;
                        app.(['Climbspd_' num2str(panel_count)]).Value = [num2str(climbspd) 'm/s'];
                        app.(['Alt_' num2str(panel_count)]).Value = [num2str(ceil(alt*10)/10) 'm'];
                        app.(['Airspd_' num2str(panel_count)]).Value = [num2str(ceil(airspd*10)/10) 'm/s'];
                        app.(['Groundspd_' num2str(panel_count)]).Value = [num2str(ceil(groundspd*10)/10) 'm/s'];
                        if ~isempty(app.APMParams)&&~app.APMParams{id}.GCS_AIRSPD_INIT
                            app.(['AirspdSelect_' num2str(panel_count)]).Value = ceil((app.VehicleGuidedPoint(ind).airspd_max+app.VehicleGuidedPoint(ind).airspd_min)*10)/20;
                            app.APMParams{id}.GCS_AIRSPD_INIT = 1;
                        end
                        color = app.VehicleGuidedPoint(ind).color;
                        if armed
                            % char inside [], not string 
                            app.(['UAVPanel_' num2str(panel_count)]).Title = ['[' num2str(id) color ']' modestr '|解锁|' num2str(battery) '%'];
                            if app.VehicleAlt(ind)>=app.APMVehicle{id}.alt_min
                                % 判断飞控是否连接
                                if ind<=length(app.PlanCanvas)&&ind<=length(app.VehicleGuidedPoint)
                                    navid = app.PlanCanvas(ind).navid;
                                    % 判断航点是否下载
                                    if navid&&navid<=length(app.VehicleGuidedPoint(ind).xlist)
                                        dist_to_navpt = norm(app.VehicleGuidedPoint(ind).p_vehicle(1:2)...
                                            -[app.VehicleGuidedPoint(ind).xlist(navid);app.VehicleGuidedPoint(ind).ylist(navid)]);
                                        app.(['UAVPanel_' num2str(panel_count)]).Title = ['[' num2str(id) color ']' modestr '|解锁|' num2str(battery) '%|' num2str(navid) ':' num2str(ceil(dist_to_navpt)) 'm'];
                                    else
                                        app.(['UAVPanel_' num2str(panel_count)]).Title = ['[' num2str(id) color ']' modestr '|解锁|' num2str(battery) '%|未下载'];
                                    end
                                end
                            end
                        else
                            app.(['UAVPanel_' num2str(panel_count)]).Title = ['[' num2str(id) color ']' modestr '|锁定|' num2str(battery) '%'];
                        end
                    else
                        app.(['HudDeg_' num2str(panel_count)]).Value = [0,0];
                        app.(['AngleDeg_' num2str(panel_count)]).Value = 0;
                        app.(['Climbspd_' num2str(panel_count)]).Value = '';
                        app.(['Alt_' num2str(panel_count)]).Value = '';
                        app.(['Airspd_' num2str(panel_count)]).Value = '';
                        app.(['Groundspd_' num2str(panel_count)]).Value = '';
                        app.(['AirspdSelect_' num2str(panel_count)]).Value = 0;
                        app.(['UAVPanel_' num2str(panel_count)]).Title = '[0]离线|锁定';
                    end
                end
                % 按下之后显示控制时间
                if app.GuidedStart.Value
                    if app.TkoffAll
                        if app.TimeSynch==0
                            app.GuidedStart.Text = '准备';
                            app.CtrlTimeLabel.Text = '控制时间：0s，时间余量：0s';
                        else
                            if app.TimeSynch>=2
                                app.GuidedStart.Text = '对时';
                                app.CtrlTimeLabel.Text = ['控制时间：' num2str(ceil(app.TimeToc*100)/100) 's，时间余量：' num2str(ceil(app.TimeErr*100)/100) 's'];
                            else
                                app.GuidedStart.Text = '控制';
                                app.CtrlTimeLabel.Text = ['控制时间：' num2str(ceil(app.TimeToc*100)/100) 's，时间余量：' num2str(ceil(app.TimeErr*100)/100) 's'];
                            end
                        end
                    else
                        app.GuidedStart.Text = '未起飞';
                        app.CtrlTimeLabel.Text = '';
                    end
                else
                    app.GuidedStart.Text = '控制';
                    app.CtrlTimeLabel.Text = '';
                end
            else
                for panel_count=1:4
                    app.(['HudDeg_' num2str(panel_count)]).Value = [0,0];
                    app.(['AngleDeg_' num2str(panel_count)]).Value = 0;
                    app.(['Climbspd_' num2str(panel_count)]).Value = '';
                    app.(['Alt_' num2str(panel_count)]).Value = '';
                    app.(['Airspd_' num2str(panel_count)]).Value = '';
                    app.(['Groundspd_' num2str(panel_count)]).Value = '';
                    app.(['AirspdSelect_' num2str(panel_count)]).Value = 0;
                    app.(['UAVPanel_' num2str(panel_count)]).Title = '[0]离线|锁定';
                end
                % 按下之后显示未起飞，并弹起
                if app.GuidedStart.Value
                    app.GuidedStart.Text = '未连接';
                    app.SetTimerGuided(false);
                    app.GuidedStart.Text = '控制';
                    app.CtrlTimeLabel.Text = '';
                end
            end
        end
        
        function SetMode(app,panel_id)
            if panel_id<=length(app.PageListID)&&app.PageListID(panel_id)<=length(app.APMVehicle)
                stop(app.TimerDisplay)
                modeuint = uint8(app.ValueIndexInItems(app.(['ModeList_' num2str(panel_id)]).Value,app.(['ModeList_' num2str(panel_id)]).Items));
                % mode 11: arm or disarm
                if modeuint~=11
                    app.APMVehicle{app.PageListID(panel_id)}.set_mode(modeuint);
                else
                    app.APMVehicle{app.PageListID(panel_id)}.vehicle.armed = ~app.APMVehicle{app.PageListID(panel_id)}.vehicle.armed;
                end
                start(app.TimerDisplay)
            end
        end

        function SetAirspd(app,panel_id)
            if panel_id<=length(app.PageListID)&&app.PageListID(panel_id)<=length(app.APMVehicle)
                stop(app.TimerDisplay)
                airspd = app.(['AirspdSelect_' num2str(panel_id)]).Value;
                % set airspd
                app.APMVehicle{app.PageListID(panel_id)}.set_speed(airspd);
                start(app.TimerDisplay)
            end
        end
        
        function SetTimerDisplay(app,start)
            % 启动/停止计时器加一个指示用的状态按钮
            if app.DisplayStart.Value ~= start
                app.DisplayStart.Value = start;
                app.DisplayStartValueChanged();
            end
        end

        function SetTimerGuided(app,start)
            % 启动/停止计时器加一个指示用的状态按钮
            if app.GuidedStart.Value ~= start
                app.GuidedStart.Value = start;
                app.GuidedStartValueChanged();
            end
        end
        
        function GuidedLoop(app,varargin)
            % 判断飞机是否连接
            if ~isempty(app.VehicleListID)
                if app.TkoffAll
                    if app.MasterID~=0
                        % 读取簇头的navid
                        master_id = app.MasterID;
                        master_ind = find(master_id==app.VehicleListID,1);
                        % 判断航点格式是否正确
                        if sum(app.VehicleGuidedPoint(master_ind).tlist)~=0
                            % 判断簇头navid是否变化
                            master_navid_changed = 0;
                            master_navid = app.PlanCanvas(master_ind).navid;
                            if master_navid~=0&&app.MasterNavID~=master_navid
                                master_navid_prev = app.MasterNavID;
                                app.MasterNavID = app.PlanCanvas(master_ind).navid;
                                master_navid_changed = 1;
                            end
                            % 更改所有簇成员navid
                            if master_navid_changed
                                for id = app.VehicleListID
                                    if id~=master_id
                                        % 在APMVehicle里设置navid，MapDisplay()定期修改app.PlanCanvas(ind).navid
                                        app.APMVehicle{id}.set_waypoint(int32(app.MasterNavID));
                                    end
                                end
                            end
                            % 航点必须navid>2且<count才进入控制流程
                            if app.MasterNavID>2&&app.MasterNavID<length(app.VehicleGuidedPoint(master_ind).xlist)
                                % 判断是否对时：当簇头navid变化且TimeSynch<2时开始对时，navid_prev=0为无效航点
                                if app.TimeSynch<2&&master_navid_changed&&master_navid_prev~=0
                                    % 如果navid_prev>navid，或者navid_prev<2，或者navt<toc，则重置计时器
                                    if master_navid_prev>app.MasterNavID||master_navid_prev<2||app.VehicleGuidedPoint(master_ind).tlist(app.MasterNavID)<app.TimeToc
                                        app.TimeSynch = 0;
                                    else
                                        % 有效自动航点切换：切换时飞机在navid_prev附近，且navid-navid_prev==1
                                        dist_to_navpt_prev = norm(app.VehicleGuidedPoint(master_ind).p_vehicle(1:2)...
                                                -[app.VehicleGuidedPoint(master_ind).xlist(master_navid_prev);app.VehicleGuidedPoint(master_ind).ylist(master_navid_prev)]);
                                        % 如果navid-navid_prev~=1，则航点切换为手动切
                                        % 如果navid-navid_prev==1，但飞机明显没在navid_prev附近，则也为手动切
                                        % 以上两种情况无需对时，保留上次对时
                                        if app.MasterNavID-master_navid_prev>1||dist_to_navpt_prev>app.VehicleGuidedPoint(master_ind).heading_dist
                                            app.TimeSynch = 1;
                                        else
                                            % 开始对时，准备下一次控制
                                            app.TimeSynch = 2;
                                            app.TimeNavpt = app.VehicleGuidedPoint(master_id).tlist(master_navid_prev);
                                            app.TimeNow = app.VehicleGuidedPoint(master_id).tlist(master_navid_prev);
                                            tic
                                        end
                                    end
                                end
                                % 如果对时无误，可以开始控制，有误则不进入控制流程
                                if app.TimeSynch>0
                                    app.TimeSynch = 1;
                                    app.TimeToc = app.TimeNavpt+toc;
                                    % 开始控制各个飞机航点、速度，先toc再控制，这样toc才有意义
                                    for ind = 1:length(app.VehicleGuidedPoint)
                                        % 读取参考轨迹点
                                        navid = app.VehicleGuidedPoint(ind).track(app.TimeToc);
                                        if app.VehicleMode(ind)~="自动"
                                            app.PlanCanvas(master_id).navid = navid;
                                        end
                                        % 计算空速、航点
                                        % app.VehicleGuidedPoint(ind).step(app.GuidedStep,0,0);
                                    end
                                    % 控制完再toc一下，进行时间对比
                                    app.TimeToc = app.TimeNavpt+toc;
                                    app.TimeNow = app.TimeNow+app.GuidedStep;
                                else
                                    app.TimeNow = 0;
                                    app.TimeToc = 0;
                                end
                            else
                                % 未进入控制流程
                                app.TimeSynch = 0;
                                app.TimeNow = 0;
                                app.TimeToc = 0;
                            end
                            % 计算时间余量，如果太大需要调慢控制频率
                            app.TimeErr = app.TimeNow-app.TimeToc;
                        else
                            % 航点格式不正确退出控制
                            app.SetTimerGuided(false);
                            app.GuidedStart.Text = '控制';
                            app.CtrlTimeLabel.Text = '';
                        end
                    end
                end
            end
        end
    end

    methods (Static)
        function boo = BoolInItems(value,items)
            % find [1,0] or [0,1] = 1 or 2
            ind = find(strcmp(items,value));
            % 1,0 => 1,2
            % 1,2 => 1,0
            boo = 2-ind;
        end

        function ind = ValueIndexInItems(value,items)
            % ***查找字符串元组中某字符串方法***
            % strcmp(s1,s2)对比两个字符串，相同为1不同为0
            % 得到只有0,1的数组，再用find找1所在的索引
            % [~,ind] = find(cellfun(@(x) strcmp(x,value),items));
            ind = find(strcmp(items,value));
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.LoadConfig();
            app.LinkIDValueChanged();
            set(app.UIAxes,'XLim',app.EastLimit,'YLim',app.NorthLimit,'XGrid','on','YGrid','on');
            axis(app.UIAxes,'equal');
            % ***matlab计时器使用方法***
            % 回调函数TimerFcn：@(x) fun(x) 形式传递参数, fun(hObject,eventdata,x)
            % 对于类内方法采用 @(varargin) class.fun 形式传递参数, fun(class,varargin)
            % 周期Period以秒为单位，启动延时StartDelay以秒为单位
            app.TimerDisplay = timer('TimerFcn',@(varargin)app.DisplayLoop,'ExecutionMode','fixedRate','Period',app.DisplayStep,'StartDelay',0);
            app.TimerGuided = timer('TimerFcn',@(varargin)app.GuidedLoop,'ExecutionMode','fixedRate','Period',app.GuidedStep,'StartDelay',0);
        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            if ~isempty(app.TimerDisplay)
                stop(app.TimerDisplay)
                delete(app.TimerDisplay);
            end
            if ~isempty(app.APMVehicle)
                for id = 1:length(app.APMVehicle)
                    app.CloseAPMVehicle(id);
                end
            end
            if ~isempty(app.PlanCanvas)
                for ind = 1:length(app.PlanCanvas)
                    delete(app.PlanCanvas(ind));
                end
            end
            if ~isempty(app.VehicleGuidedPoint)
                for ind = 1:length(app.VehicleGuidedPoint)
                    delete(app.VehicleGuidedPoint(ind));
                end
            end
            delete(app)
        end

        % Button pushed function: LinkButtonOn
        function LinkButtonOnPushed(app, event)
            id = str2double(app.LinkID.Value);
            port = app.LinkPort.Value+id;
            % 中断保护：连接MAVLINK之前停止计时器
            app.SetTimerDisplay(false);
            % 连接飞控端口，建立VehicleList
            app.OpenAPMVehicle(id,port);
            app.SetTimerDisplay(true);
        end

        % Button pushed function: LinkButtonOff
        function LinkButtonOffPushed(app, event)
            id = str2double(app.LinkID.Value);
            % 中断保护：断开MAVLINK之前停止计时器
            app.SetTimerDisplay(false);
            % 关闭飞控端口，删除VehicleList
            app.CloseAPMVehicle(id);
            app.SetTimerDisplay(true);
        end

        % Value changed function: LinkID
        function LinkIDValueChanged(app, event)
            id = str2double(app.LinkID.Value);
            if ~ismember(id,app.VehicleListID)
                app.LinkButtonOn.Enable = "on";
                app.LinkButtonOff.Enable = "off";
            else
                app.LinkButtonOn.Enable = "off";
                app.LinkButtonOff.Enable = "on";
            end
        end

        % Button pushed function: ModeSet_1
        function ModeSet_1ButtonPushed(app, event)
            app.SetMode(1);
        end

        % Button pushed function: ModeSet_2
        function ModeSet_2ButtonPushed(app, event)
            app.SetMode(2);
        end

        % Button pushed function: ModeSet_3
        function ModeSet_3ButtonPushed(app, event)
            app.SetMode(3);
        end

        % Button pushed function: ModeSet_4
        function ModeSet_4ButtonPushed(app, event)
            app.SetMode(4);
        end

        % Value changed function: DisplayStart
        function DisplayStartValueChanged(app, event)
            value = app.DisplayStart.Value;
            % 手动启动/停止计时器
            if value
                start(app.TimerDisplay);
            else
                stop(app.TimerDisplay);
            end
        end

        % Button pushed function: PageScroll
        function PageScrollButtonPushed(app, event)
            app.PageFlight = app.PageFlight+1;
        end

        % Value changed function: CanvasStart
        function CanvasStartValueChanged(app, event)
            value = app.CanvasStart.Value;
            ind = app.ValueIndexInItems(app.PlanUAVID.Value,app.PlanUAVID.Items);
            id = app.VehicleListID(ind);
            if ~isempty(app.VehicleListID)&&~isempty(ind)
                % 手动启动/停止选点
                if app.VehicleAlt(ind)<app.APMVehicle{id}.alt_min
                    if value
                        % app.PlanCanvas(ind).select_point();
                        app.VehicleGuidedPoint(ind).mission_flag = 1;
                    else
                        app.PlanCanvas(ind).cancel_point();
                        app.VehicleGuidedPoint(ind).mission_flag = 0;
                    end
                else
                    if value
                        app.VehicleGuidedPoint(ind).mission_flag = 1;
                    else
                        app.VehicleGuidedPoint(ind).mission_flag = 0;
                    end
                end
            end
        end

        % Button pushed function: NavDownload
        function NavDownloadButtonPushed(app, event)
            % ind表示飞机id在VehicleListID中的索引，id表示飞机id
            ind = app.ValueIndexInItems(app.PlanUAVID.Value,app.PlanUAVID.Items);
            % 如果任务模式为1（航点），显示参考工作高度
            app.PlanUAVIDValueChanged();
            % 显示更新航点或者显示上次保存航点
            plan_updated = 0;
            if ind<=length(app.VehicleListID)&&~isempty(ind)
                id = app.VehicleListID(ind);
                countnext = double(app.APMVehicle{id}.get_waypoint(0));
                app.PlanCanvas(ind).navid = countnext(2);
                use_time = 1;
                if countnext(1)==0
                    app.CanvasPanel.Title = '该机飞控无航点';
                else
                    app.CanvasPanel.Title = '航点下载成功';
                end
                for i=1:countnext(1)
                    % 如果i超出count则返回一个0，未超出返回8个参数
                    navpt = double(app.APMVehicle{id}.get_waypoint(int32(i)));
                    % 航线格式不满足要求（首尾不能是航点）
                    if i==1||i==countnext(1)
                        if navpt(1)==16
                            use_time = 0;
                        end
                    end
                    % 判断navpt长度是1还是8
                    if length(navpt)>1
                        % 16:waypoint, 17:loiter_unlim, 18:loiter_turn, 19:loiter_time, 20:rtl
                        % waypoint仅rad_accept、rad_pass能上传，若rad_pass>0不管rad_accept多少飞机都会越过航点再转
                        % loiter_unlim仅rad_pass能上传
                        % loiter_turn、loiter_time都能上传，hold>0为次数/时间
                        % rad_accept=1代表以下一个路点方向离开盘旋圆，=0代表以当前方向离开盘旋圆
                        % yaw=1代表从切线离开盘旋圆，=0代表从中心离开盘旋圆
                        % 航路可以不设置rtl，和手动切是一样的
                        app.VehicleGuidedPoint(ind).cmd(i) = navpt(1);
                        app.VehicleGuidedPoint(ind).hold(i) = navpt(2);
                        app.VehicleGuidedPoint(ind).rad_accept(i) = navpt(3);
                        app.VehicleGuidedPoint(ind).rad_pass(i) = navpt(4);
                        app.VehicleGuidedPoint(ind).yaw(i) = navpt(5);
                        app.VehicleGuidedPoint(ind).lat(i) = navpt(6);
                        app.VehicleGuidedPoint(ind).lon(i) = navpt(7);
                        app.VehicleGuidedPoint(ind).alt(i) = navpt(8);
                        % NED axis
                        xy = double(app.APMVehicle{id}.map_origin.GPStoXYwithRef(app.VehicleGuidedPoint(ind).lat(i), ...
                            app.VehicleGuidedPoint(ind).lon(i), app.MapGPSOrigin(1), app.MapGPSOrigin(2)));
                        app.VehicleGuidedPoint(ind).xlist(i) = xy(1);
                        app.VehicleGuidedPoint(ind).ylist(i) = xy(2);
                        app.VehicleGuidedPoint(ind).zlist(i) = -app.VehicleGuidedPoint(ind).alt(i);
                        app.VehicleGuidedPoint(ind).vlist(i) = (app.VehicleGuidedPoint(ind).airspd_max+app.VehicleGuidedPoint(ind).airspd_min)/2;
                        plan_updated = 1;
                    else
                        break;
                    end
                end
                % 如果有航点在VehicleGuidedPoint中
                if ~isempty(app.VehicleGuidedPoint(ind).cmd)
                    if plan_updated
                        app.CanvasPanel.Title = [app.CanvasPanel.Title '，显示更新航点'];
                    else
                        app.CanvasPanel.Title = [app.CanvasPanel.Title '，显示上次保存航点'];
                    end
                    count = length(app.VehicleGuidedPoint(ind).cmd);
                    app.NavID.Items = string(1:count);
                    % 航线满足要求
                    if use_time
                        xyz_diff = [diff(app.VehicleGuidedPoint(ind).xlist);diff(app.VehicleGuidedPoint(ind).ylist);diff(app.VehicleGuidedPoint(ind).zlist)];
                        xyz_dist = normby(xyz_diff,2);
                        % 航线格式：第一个点是集结点（<0），中间是路点（>=0），最后一个点是应急点（<0）
                        for i=[1 count]
                            if app.VehicleGuidedPoint(ind).cmd(i)==17
                                % loiter_unlim：无限次，-255表示
                                app.VehicleGuidedPoint(ind).tlist(i) = -255;
                            else
                                % loiter_turns/times：hold次数/时间，-hold表示
                                app.VehicleGuidedPoint(ind).tlist(i) = -app.VehicleGuidedPoint(ind).hold(i);
                            end  
                        end
                        app.VehicleGuidedPoint(ind).tlist(2) = 0;
                        for i=3:count-1
                            app.VehicleGuidedPoint(ind).tlist(i) = app.VehicleGuidedPoint(ind).tlist(i-1)+xyz_dist(i-1)/app.VehicleGuidedPoint(ind).vlist(i);
                        end
                    else
                        app.VehicleGuidedPoint(ind).tlist = zeros(size(app.VehicleGuidedPoint(ind).xlist));
                    end
                    % NED坐标转画图坐标
                    app.PlanCanvas(ind).xlist = app.VehicleGuidedPoint(ind).ylist;
                    app.PlanCanvas(ind).ylist = app.VehicleGuidedPoint(ind).xlist;
                end
            else
                app.CanvasPanel.Title = '该机飞控未连接';
            end
        end

        % Button pushed function: NavSwitch
        function NavSwitchButtonPushed(app, event)
            if ~isempty(app.NavID.Items)
                ind = app.ValueIndexInItems(app.PlanUAVID.Value,app.PlanUAVID.Items);
                inav = app.ValueIndexInItems(app.NavID.Value,app.NavID.Items);
                % 避免飞控未连接，加个判定
                if ind<=length(app.VehicleListID)
                    id = app.VehicleListID(ind);
                    if app.VehicleAlt(ind)<app.APMVehicle{id}.alt_min
                        % 避免未download就读取，加个判定
                        if ind<=length(app.VehicleGuidedPoint)&&inav<=length(app.VehicleGuidedPoint(ind).cmd)
                            % 地面时，查看路点信息地图上自动切换对应路点
                            app.PlanCanvas(ind).navid = inav;
                        end
                    else
                        % 飞行时，切换路点控制飞机飞行
                        app.APMVehicle{id}.set_waypoint(int32(inav));
                    end
                    % 如果任务模式为1（航点），显示参考工作高度
                    app.PlanUAVIDValueChanged();
                    % 避免未download就读取，加个判定
                    if ind<=length(app.VehicleGuidedPoint)&&inav<=length(app.VehicleGuidedPoint(ind).cmd)
                        % 显示当前路点详细信息
                        app.NavCmd.Value = app.NavCmd.Items{app.VehicleGuidedPoint(ind).cmd(inav)-15};
                        app.NavAlt.Value = ceil(app.VehicleGuidedPoint(ind).alt(inav)*10)/10;
                        app.NavSpd.Value = ceil(app.VehicleGuidedPoint(ind).vlist(inav)*10)/10;
                        if app.VehicleGuidedPoint(ind).tlist(inav)<0
                            % loiter_unlim直接设置时间为-255
                            if app.VehicleGuidedPoint(ind).cmd(inav)==17
                                app.NavTime.Value = app.VehicleGuidedPoint(ind).tlist(inav);
                            else
                                % loiter_turns设置次数
                                if app.VehicleGuidedPoint(ind).cmd(inav)==18
                                    app.NavTime.Value = ceil(-app.VehicleGuidedPoint(ind).tlist(inav));
                                    % loiter_times设置时间
                                else
                                    app.NavTime.Value = ceil(-app.VehicleGuidedPoint(ind).tlist(inav)*10)/10;
                                end
                            end
                        else
                            % waypoint设置时间
                            app.NavTime.Value = ceil(app.VehicleGuidedPoint(ind).tlist(inav)*10)/10;
                        end
                        % waypoint设置rad_accept
                        if app.VehicleGuidedPoint(ind).cmd(inav)==16
                            app.NavRad.Value = ceil(app.VehicleGuidedPoint(ind).rad_accept(inav));
                            % loiter设置rad_pass
                        else
                            app.NavRad.Value = ceil(app.VehicleGuidedPoint(ind).rad_pass(inav));
                        end
                    end
                else
                    app.CanvasPanel.Title = '该机飞控未连接';
                end
            else
                app.CanvasPanel.Title = '点击航点下载';
            end
        end

        % Value changed function: GuidedStart
        function GuidedStartValueChanged(app, event)
            value = app.GuidedStart.Value;
            % 手动启动/停止计时器
            if value
                start(app.TimerGuided);
            else
                stop(app.TimerGuided);
            end
        end

        % Button pushed function: TaskAltSet
        function TaskAltSetButtonPushed(app, event)
            ind = app.ValueIndexInItems(app.PlanUAVID.Value,app.PlanUAVID.Items);
            alt_work = app.TaskAlt.Value;
            % 避免未download就读取，加个判定
            if ind<=length(app.VehicleGuidedPoint)&&~isempty(app.VehicleGuidedPoint(ind).cmd)
                app.VehicleGuidedPoint(ind).alt = ones(size(app.VehicleGuidedPoint(ind).alt))*alt_work;
                app.VehicleGuidedPoint(ind).zlist = -app.VehicleGuidedPoint(ind).alt;
            end
        end

        % Button pushed function: NavUpload
        function NavUploadButtonPushed(app, event)
            ind = app.ValueIndexInItems(app.PlanUAVID.Value,app.PlanUAVID.Items);
            % 至少有起始盘旋点、应急盘旋点2个航点，且设置好时间序列
            if ~isempty(ind)&&length(app.VehicleGuidedPoint)>=ind&&length(app.VehicleGuidedPoint(ind).cmd)>=2&&length(app.VehicleGuidedPoint(ind).tlist)>=2
                app.NavUpload.Text = "正在上传";
                % 其他飞机以PlanUAVID的航点为基准，高度做变化
                for i=1:length(app.VehicleListID)
                    id = app.VehicleListID(i);
                    if i~=ind
                        % 生成其他飞机航点
                        for j=1:length(app.VehicleGuidedPoint(ind).cmd)
                            app.VehicleGuidedPoint(i).cmd(j) = app.VehicleGuidedPoint(ind).cmd(j);
                            app.VehicleGuidedPoint(i).hold(j) = app.VehicleGuidedPoint(ind).hold(j);
                            app.VehicleGuidedPoint(i).rad_accept(j) = app.VehicleGuidedPoint(ind).rad_accept(j);
                            app.VehicleGuidedPoint(i).rad_pass(j) = app.VehicleGuidedPoint(ind).rad_pass(j);
                            app.VehicleGuidedPoint(i).yaw(j) = app.VehicleGuidedPoint(ind).yaw(j);
                            app.VehicleGuidedPoint(i).lat(j) = app.VehicleGuidedPoint(ind).lat(j);
                            app.VehicleGuidedPoint(i).lon(j) = app.VehicleGuidedPoint(ind).lon(j);
                            % 高度加减alt_dist的倍数
                            app.VehicleGuidedPoint(i).alt(j) = app.VehicleGuidedPoint(ind).alt(j)+(i-ind)*app.APMVehicle{id}.alt_dist;
                            % NED axis
                            xy = double(app.APMVehicle{id}.map_origin.GPStoXYwithRef(app.VehicleGuidedPoint(i).lat(j), ...
                                app.VehicleGuidedPoint(i).lon(j), app.MapGPSOrigin(1), app.MapGPSOrigin(2)));
                            app.VehicleGuidedPoint(i).xlist(j) = xy(1);
                            app.VehicleGuidedPoint(i).ylist(j) = xy(2);
                            app.VehicleGuidedPoint(i).zlist(j) = -app.VehicleGuidedPoint(i).alt(j);
                            app.VehicleGuidedPoint(i).vlist(j) = (app.VehicleGuidedPoint(i).airspd_max+app.VehicleGuidedPoint(i).airspd_min)/2;
                            app.VehicleGuidedPoint(i).tlist(j) = app.VehicleGuidedPoint(ind).tlist(j);
                        end
                    end
                    % 上传航点流程
                    app.CanvasPanel.Title = ['上传航点到飞机' num2str(id)];
                    for j=1:length(app.VehicleGuidedPoint(i).cmd)
                        cmd = app.VehicleGuidedPoint(i).cmd(j);
                        hold = app.VehicleGuidedPoint(i).hold(j);
                        if cmd==16
                            rad = app.VehicleGuidedPoint(i).rad_accept(j);
                        else
                            rad = app.VehicleGuidedPoint(i).rad_pass(j);
                        end
                        x = app.VehicleGuidedPoint(i).lat(j);
                        y = app.VehicleGuidedPoint(i).lon(j);
                        z = app.VehicleGuidedPoint(i).alt(j);
                        % python输入之前，参数类型都定好，不要用bool型
                        % 注意wp_list索引从0开始，i=j-1，use_gps=1
                        wp_num = double(app.APMVehicle{id}.set_waypoint_cmds(int32(j-1),double(x),double(y),double(z),int32(1),int32(cmd),double(rad),double(hold)));
                        if j>wp_num
                            app.CanvasPanel.Title = ['飞机' num2str(id) '航点' num2str(j) '设置失败'];
                            break;
                        else
                            app.CanvasPanel.Title = ['飞机' num2str(id) '航点' num2str(j) '设置成功'];
                            pause(0.01);
                        end
                    end
                    if j==length(app.VehicleGuidedPoint(i).cmd)
                        app.APMVehicle{id}.clear_waypoint();
                        app.APMVehicle{id}.upload_waypoint();
                        app.CanvasPanel.Title = ['飞机' num2str(id) '航路上传成功'];
                    end
                end
                app.NavUpload.Text = "上传完毕";
                pause(0.01);
                app.NavUpload.Text = "航点上传";
            else
                if ind<=length(app.VehicleListID)&&~isempty(ind)
                    id = app.VehicleListID(ind);
                    app.CanvasPanel.Title = ['飞机' num2str(id) '参考航路格式错误'];
                else
                    app.CanvasPanel.Title = '该机飞控未连接';
                end
            end
        end

        % Value changed function: PlanUAVID
        function PlanUAVIDValueChanged(app, event)
            ind = app.ValueIndexInItems(app.PlanUAVID.Value,app.PlanUAVID.Items);
            % 如果任务模式为1（航点），显示参考工作高度
            if app.TaskMode_1.Value
                app.TaskAlt.Value = app.VehicleAltWork(ind);
            end
        end

        % Button pushed function: PilotButtonRead
        function PilotButtonReadPushed(app, event)
            try
                % ind表示飞机id在VehicleListID中的索引，linkid表示可连接飞机ID
                linkid = app.ValueIndexInItems(app.LinkID.Value,app.LinkID.Items);
                ind = find(linkid == app.VehicleListID);
                if ind<=length(app.VehicleListID)&&~isempty(ind)
                    id = app.VehicleListID(ind);
                    app.APMParams{id} = struct(app.APMVehicle{id}.vehicle.parameters);
                    app.PilotAirspdMax.Value = app.APMParams{id}.(app.PilotAirspdMaxLabel.Text);
                    app.PilotAirspdMin.Value = app.APMParams{id}.(app.PilotAirspdMinLabel.Text);
                    app.PilotAirspdWork.Value = app.APMParams{id}.(app.PilotAirspdWorkLabel.Text);
                    app.PilotRTLRad.Value = app.APMParams{id}.(app.PilotRTLRadLabel.Text);
                    app.PilotLoiterRad.Value = app.APMParams{id}.(app.PilotLoiterRadLabel.Text);
                    app.PilotWPRad.Value = app.APMParams{id}.(app.PilotWPRadLabel.Text);
                    app.PilotSysID.Value = app.APMParams{id}.(app.PilotSysIDLabel.Text);
                    app.PilotTkoffAlt.Value = app.APMParams{id}.(app.PilotTkoffAltLabel.Text);
                    app.PilotRTLAlt.Value = app.APMParams{id}.(app.PilotRTLAltLabel.Text);
                    app.APMParams{id}.GCS_AIRSPD_INIT = 0;
                end
            catch
                warning(['[ ' num2str(id) 'plane ] Cannot read Parameters'])
            end
        end

        % Button pushed function: AirspdSet_1
        function AirspdSet_1ButtonPushed(app, event)
            app.SetAirspd(1);
        end

        % Button pushed function: AirspdSet_2
        function AirspdSet_2ButtonPushed(app, event)
            app.SetAirspd(2);
        end

        % Button pushed function: AirspdSet_3
        function AirspdSet_3ButtonPushed(app, event)
            app.SetAirspd(3);
        end

        % Button pushed function: AirspdSet_4
        function AirspdSet_4ButtonPushed(app, event)
            app.SetAirspd(4);
        end

        % Button pushed function: MapGPSUnify
        function MapGPSUnifyButtonPushed(app, event)
            for id=app.VehicleListID
                app.MapGPSUnify.Text = ['设置飞机' num2str(id)];
                app.APMVehicle{id}.set_map_origin_GPS(app.MapGPSOrigin(1),app.MapGPSOrigin(2));
                pause(0.1)
            end
            app.MapGPSUnify.Text = '统一完毕';
            pause(0.1)
            app.MapGPSUnify.Text = '统一原点';
        end

        % Button pushed function: SwitchNavStart
        function SwitchNavStartButtonPushed(app, event)
            if app.MasterID
                ind = find(app.MasterID==app.VehicleListID);
                if ind==0
                    app.SwitchNavStart.Text = '无簇头';
                    pause(0.1)
                    app.SwitchNavStart.Text = '切换起点';
                else
                    if isempty(app.VehicleGuidedPoint(ind).tlist)
                        app.SwitchNavStart.Text = '未下载';
                        pause(0.1)
                        app.SwitchNavStart.Text = '切换起点';
                    else
                        if sum(app.VehicleGuidedPoint(ind).tlist)==0
                            app.APMVehicle{app.MasterID}.set_waypoint(int32(1));
                        else
                            app.APMVehicle{app.MasterID}.set_waypoint(int32(2));
                        end
                    end
                end
            else
                app.SwitchNavStart.Text = '未起飞';
                pause(0.1)
                app.SwitchNavStart.Text = '切换起点';
            end
        end

        % Button pushed function: MapGPSSet
        function MapGPSSetButtonPushed(app, event)
            if ~isempty(app.VehicleListID)
                % 可以通过PlanUAVID选择某个飞机homeGPS作为原点
                ind = app.ValueIndexInItems(app.PlanUAVID.Value,app.PlanUAVID.Items);
                id = app.VehicleListID(ind);
                % 等待home点，解锁后读home有bug，仅在锁定时候能读
                if ~app.APMVehicle{id}.vehicle.armed
                    home_gps = double(app.APMVehicle{id}.wait_home_GPS());
                    if sum(home_gps)==0
                        % 如果原本RealHomeGPS==1则保留有效的GPS点位
                        app.MapGPSSet.Text = '未读取';
                    else
                        % 如果原本RealHomeGPS==0则重新设置GPS
                        app.RealHomeGPS = 1;
                        app.MapGPSOrigin = home_gps(:);
                        app.MapGPSSet.Text = '设置成功';
                    end
                else
                    % 如果原本RealHomeGPS==1则保留有效的GPS点位
                    app.MapGPSSet.Text = '未锁定';
                end
                pause(0.1)
                app.MapGPSSet.Text = '设置原点';
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1388 807];
            app.UIFigure.Name = '地面站';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create TabGroupMap
            app.TabGroupMap = uitabgroup(app.UIFigure);
            app.TabGroupMap.Position = [1 1 1388 807];

            % Create TabMap
            app.TabMap = uitab(app.TabGroupMap);
            app.TabMap.Title = '显示';

            % Create UIAxes
            app.UIAxes = uiaxes(app.TabMap);
            title(app.UIAxes, '地图')
            xlabel(app.UIAxes, '东→')
            ylabel(app.UIAxes, '北→')
            zlabel(app.UIAxes, '高')
            app.UIAxes.Position = [12 32 990 744];

            % Create TabGroupFlight
            app.TabGroupFlight = uitabgroup(app.TabMap);
            app.TabGroupFlight.Position = [1013 23 373 760];

            % Create TabFlight
            app.TabFlight = uitab(app.TabGroupFlight);
            app.TabFlight.Title = '飞行控制';

            % Create UAVPanel_1
            app.UAVPanel_1 = uipanel(app.TabFlight);
            app.UAVPanel_1.Title = '[0]离线|锁定';
            app.UAVPanel_1.Position = [1 495 186 238];

            % Create GridLayout_1
            app.GridLayout_1 = uigridlayout(app.UAVPanel_1);
            app.GridLayout_1.ColumnWidth = {29, '1x', 29, '1x'};
            app.GridLayout_1.RowHeight = {'1x', 23, 22, 22, 22};
            app.GridLayout_1.ColumnSpacing = 4.4;
            app.GridLayout_1.RowSpacing = 8.83333333333333;
            app.GridLayout_1.Padding = [4.4 8.83333333333333 4.4 8.83333333333333];

            % Create AngleDeg_1
            app.AngleDeg_1 = uiaeroheading(app.GridLayout_1);
            app.AngleDeg_1.Layout.Row = 1;
            app.AngleDeg_1.Layout.Column = [3 4];

            % Create HudDeg_1
            app.HudDeg_1 = uiaerohorizon(app.GridLayout_1);
            app.HudDeg_1.Layout.Row = 1;
            app.HudDeg_1.Layout.Column = [1 2];

            % Create ModeSet_1
            app.ModeSet_1 = uibutton(app.GridLayout_1, 'push');
            app.ModeSet_1.ButtonPushedFcn = createCallbackFcn(app, @ModeSet_1ButtonPushed, true);
            app.ModeSet_1.Layout.Row = 2;
            app.ModeSet_1.Layout.Column = [3 4];
            app.ModeSet_1.Text = '设置模式';

            % Create ModeList_1
            app.ModeList_1 = uidropdown(app.GridLayout_1);
            app.ModeList_1.Items = {'自稳', '定点', '引导', '降落', '返航', '自动', '刹车', '盘旋', '手动', '起飞', '解锁'};
            app.ModeList_1.Layout.Row = 2;
            app.ModeList_1.Layout.Column = [1 2];
            app.ModeList_1.Value = '自稳';

            % Create AirspdSet_1
            app.AirspdSet_1 = uibutton(app.GridLayout_1, 'push');
            app.AirspdSet_1.ButtonPushedFcn = createCallbackFcn(app, @AirspdSet_1ButtonPushed, true);
            app.AirspdSet_1.Layout.Row = 3;
            app.AirspdSet_1.Layout.Column = [3 4];
            app.AirspdSet_1.Text = '设置空速';

            % Create GroundspdLabel_1
            app.GroundspdLabel_1 = uilabel(app.GridLayout_1);
            app.GroundspdLabel_1.Layout.Row = 4;
            app.GroundspdLabel_1.Layout.Column = 1;
            app.GroundspdLabel_1.Text = '地速';

            % Create Groundspd_1
            app.Groundspd_1 = uieditfield(app.GridLayout_1, 'text');
            app.Groundspd_1.Layout.Row = 4;
            app.Groundspd_1.Layout.Column = 2;

            % Create AirspdLabel_1
            app.AirspdLabel_1 = uilabel(app.GridLayout_1);
            app.AirspdLabel_1.Layout.Row = 4;
            app.AirspdLabel_1.Layout.Column = 3;
            app.AirspdLabel_1.Text = '空速';

            % Create Airspd_1
            app.Airspd_1 = uieditfield(app.GridLayout_1, 'text');
            app.Airspd_1.Layout.Row = 4;
            app.Airspd_1.Layout.Column = 4;

            % Create AltLabel_1
            app.AltLabel_1 = uilabel(app.GridLayout_1);
            app.AltLabel_1.Layout.Row = 5;
            app.AltLabel_1.Layout.Column = 1;
            app.AltLabel_1.Text = '高度';

            % Create Alt_1
            app.Alt_1 = uieditfield(app.GridLayout_1, 'text');
            app.Alt_1.Layout.Row = 5;
            app.Alt_1.Layout.Column = 2;

            % Create ClimbspdLabel_1
            app.ClimbspdLabel_1 = uilabel(app.GridLayout_1);
            app.ClimbspdLabel_1.Layout.Row = 5;
            app.ClimbspdLabel_1.Layout.Column = 3;
            app.ClimbspdLabel_1.Text = '升速';

            % Create Climbspd_1
            app.Climbspd_1 = uieditfield(app.GridLayout_1, 'text');
            app.Climbspd_1.Layout.Row = 5;
            app.Climbspd_1.Layout.Column = 4;

            % Create AirspdSelectLabel_1
            app.AirspdSelectLabel_1 = uilabel(app.GridLayout_1);
            app.AirspdSelectLabel_1.Layout.Row = 3;
            app.AirspdSelectLabel_1.Layout.Column = 1;
            app.AirspdSelectLabel_1.Text = '空速';

            % Create AirspdSelect_1
            app.AirspdSelect_1 = uieditfield(app.GridLayout_1, 'numeric');
            app.AirspdSelect_1.Limits = [0 100];
            app.AirspdSelect_1.Layout.Row = 3;
            app.AirspdSelect_1.Layout.Column = 2;

            % Create UAVPanel_2
            app.UAVPanel_2 = uipanel(app.TabFlight);
            app.UAVPanel_2.Title = '[0]离线|锁定';
            app.UAVPanel_2.Position = [186 495 186 238];

            % Create GridLayout_2
            app.GridLayout_2 = uigridlayout(app.UAVPanel_2);
            app.GridLayout_2.ColumnWidth = {29, '1x', 29, '1x'};
            app.GridLayout_2.RowHeight = {'1x', 23, 22, 22, 22};
            app.GridLayout_2.ColumnSpacing = 4;
            app.GridLayout_2.RowSpacing = 8.8888905843099;
            app.GridLayout_2.Padding = [4 8.8888905843099 4 8.8888905843099];

            % Create AngleDeg_2
            app.AngleDeg_2 = uiaeroheading(app.GridLayout_2);
            app.AngleDeg_2.Layout.Row = 1;
            app.AngleDeg_2.Layout.Column = [3 4];

            % Create HudDeg_2
            app.HudDeg_2 = uiaerohorizon(app.GridLayout_2);
            app.HudDeg_2.Layout.Row = 1;
            app.HudDeg_2.Layout.Column = [1 2];

            % Create ModeSet_2
            app.ModeSet_2 = uibutton(app.GridLayout_2, 'push');
            app.ModeSet_2.ButtonPushedFcn = createCallbackFcn(app, @ModeSet_2ButtonPushed, true);
            app.ModeSet_2.Layout.Row = 2;
            app.ModeSet_2.Layout.Column = [3 4];
            app.ModeSet_2.Text = '设置模式';

            % Create ModeList_2
            app.ModeList_2 = uidropdown(app.GridLayout_2);
            app.ModeList_2.Items = {'自稳', '定点', '引导', '降落', '返航', '自动', '刹车', '盘旋', '手动', '起飞', '解锁'};
            app.ModeList_2.Layout.Row = 2;
            app.ModeList_2.Layout.Column = [1 2];
            app.ModeList_2.Value = '自稳';

            % Create AirspdSet_2
            app.AirspdSet_2 = uibutton(app.GridLayout_2, 'push');
            app.AirspdSet_2.ButtonPushedFcn = createCallbackFcn(app, @AirspdSet_2ButtonPushed, true);
            app.AirspdSet_2.Layout.Row = 3;
            app.AirspdSet_2.Layout.Column = [3 4];
            app.AirspdSet_2.Text = '设置空速';

            % Create GroundspdLabel_2
            app.GroundspdLabel_2 = uilabel(app.GridLayout_2);
            app.GroundspdLabel_2.Layout.Row = 4;
            app.GroundspdLabel_2.Layout.Column = 1;
            app.GroundspdLabel_2.Text = '地速';

            % Create Groundspd_2
            app.Groundspd_2 = uieditfield(app.GridLayout_2, 'text');
            app.Groundspd_2.Layout.Row = 4;
            app.Groundspd_2.Layout.Column = 2;

            % Create AirspdLabel_2
            app.AirspdLabel_2 = uilabel(app.GridLayout_2);
            app.AirspdLabel_2.Layout.Row = 4;
            app.AirspdLabel_2.Layout.Column = 3;
            app.AirspdLabel_2.Text = '空速';

            % Create Airspd_2
            app.Airspd_2 = uieditfield(app.GridLayout_2, 'text');
            app.Airspd_2.Layout.Row = 4;
            app.Airspd_2.Layout.Column = 4;

            % Create AltLabel_2
            app.AltLabel_2 = uilabel(app.GridLayout_2);
            app.AltLabel_2.Layout.Row = 5;
            app.AltLabel_2.Layout.Column = 1;
            app.AltLabel_2.Text = '高度';

            % Create Alt_2
            app.Alt_2 = uieditfield(app.GridLayout_2, 'text');
            app.Alt_2.Layout.Row = 5;
            app.Alt_2.Layout.Column = 2;

            % Create ClimbspdLabel_2
            app.ClimbspdLabel_2 = uilabel(app.GridLayout_2);
            app.ClimbspdLabel_2.Layout.Row = 5;
            app.ClimbspdLabel_2.Layout.Column = 3;
            app.ClimbspdLabel_2.Text = '升速';

            % Create Climbspd_2
            app.Climbspd_2 = uieditfield(app.GridLayout_2, 'text');
            app.Climbspd_2.Layout.Row = 5;
            app.Climbspd_2.Layout.Column = 4;

            % Create AirspdSelectLabel_2
            app.AirspdSelectLabel_2 = uilabel(app.GridLayout_2);
            app.AirspdSelectLabel_2.Layout.Row = 3;
            app.AirspdSelectLabel_2.Layout.Column = 1;
            app.AirspdSelectLabel_2.Text = '空速';

            % Create AirspdSelect_2
            app.AirspdSelect_2 = uieditfield(app.GridLayout_2, 'numeric');
            app.AirspdSelect_2.Limits = [0 100];
            app.AirspdSelect_2.Layout.Row = 3;
            app.AirspdSelect_2.Layout.Column = 2;

            % Create UAVPanel_3
            app.UAVPanel_3 = uipanel(app.TabFlight);
            app.UAVPanel_3.Title = '[0]离线|锁定';
            app.UAVPanel_3.Position = [1 258 186 238];

            % Create GridLayout_3
            app.GridLayout_3 = uigridlayout(app.UAVPanel_3);
            app.GridLayout_3.ColumnWidth = {29, '1x', 29, '1x'};
            app.GridLayout_3.RowHeight = {'1x', 23, 22, 22, 22};
            app.GridLayout_3.ColumnSpacing = 4.8;
            app.GridLayout_3.RowSpacing = 8;
            app.GridLayout_3.Padding = [4.8 8 4.8 8];

            % Create AngleDeg_3
            app.AngleDeg_3 = uiaeroheading(app.GridLayout_3);
            app.AngleDeg_3.Layout.Row = 1;
            app.AngleDeg_3.Layout.Column = [3 4];

            % Create HudDeg_3
            app.HudDeg_3 = uiaerohorizon(app.GridLayout_3);
            app.HudDeg_3.Layout.Row = 1;
            app.HudDeg_3.Layout.Column = [1 2];

            % Create ModeSet_3
            app.ModeSet_3 = uibutton(app.GridLayout_3, 'push');
            app.ModeSet_3.ButtonPushedFcn = createCallbackFcn(app, @ModeSet_3ButtonPushed, true);
            app.ModeSet_3.Layout.Row = 2;
            app.ModeSet_3.Layout.Column = [3 4];
            app.ModeSet_3.Text = '设置模式';

            % Create ModeList_3
            app.ModeList_3 = uidropdown(app.GridLayout_3);
            app.ModeList_3.Items = {'自稳', '定点', '引导', '降落', '返航', '自动', '刹车', '盘旋', '手动', '起飞', '解锁'};
            app.ModeList_3.Layout.Row = 2;
            app.ModeList_3.Layout.Column = [1 2];
            app.ModeList_3.Value = '自稳';

            % Create GroundspdLabel_3
            app.GroundspdLabel_3 = uilabel(app.GridLayout_3);
            app.GroundspdLabel_3.Layout.Row = 4;
            app.GroundspdLabel_3.Layout.Column = 1;
            app.GroundspdLabel_3.Text = '地速';

            % Create Groundspd_3
            app.Groundspd_3 = uieditfield(app.GridLayout_3, 'text');
            app.Groundspd_3.Layout.Row = 4;
            app.Groundspd_3.Layout.Column = 2;

            % Create AirspdLabel_3
            app.AirspdLabel_3 = uilabel(app.GridLayout_3);
            app.AirspdLabel_3.Layout.Row = 4;
            app.AirspdLabel_3.Layout.Column = 3;
            app.AirspdLabel_3.Text = '空速';

            % Create Airspd_3
            app.Airspd_3 = uieditfield(app.GridLayout_3, 'text');
            app.Airspd_3.Layout.Row = 4;
            app.Airspd_3.Layout.Column = 4;

            % Create AltLabel_3
            app.AltLabel_3 = uilabel(app.GridLayout_3);
            app.AltLabel_3.Layout.Row = 5;
            app.AltLabel_3.Layout.Column = 1;
            app.AltLabel_3.Text = '高度';

            % Create Alt_3
            app.Alt_3 = uieditfield(app.GridLayout_3, 'text');
            app.Alt_3.Layout.Row = 5;
            app.Alt_3.Layout.Column = 2;

            % Create ClimbspdLabel_3
            app.ClimbspdLabel_3 = uilabel(app.GridLayout_3);
            app.ClimbspdLabel_3.Layout.Row = 5;
            app.ClimbspdLabel_3.Layout.Column = 3;
            app.ClimbspdLabel_3.Text = '升速';

            % Create Climbspd_3
            app.Climbspd_3 = uieditfield(app.GridLayout_3, 'text');
            app.Climbspd_3.Layout.Row = 5;
            app.Climbspd_3.Layout.Column = 4;

            % Create AirspdSelectLabel_3
            app.AirspdSelectLabel_3 = uilabel(app.GridLayout_3);
            app.AirspdSelectLabel_3.Layout.Row = 3;
            app.AirspdSelectLabel_3.Layout.Column = 1;
            app.AirspdSelectLabel_3.Text = '空速';

            % Create AirspdSelect_3
            app.AirspdSelect_3 = uieditfield(app.GridLayout_3, 'numeric');
            app.AirspdSelect_3.Limits = [0 100];
            app.AirspdSelect_3.Layout.Row = 3;
            app.AirspdSelect_3.Layout.Column = 2;

            % Create AirspdSet_3
            app.AirspdSet_3 = uibutton(app.GridLayout_3, 'push');
            app.AirspdSet_3.ButtonPushedFcn = createCallbackFcn(app, @AirspdSet_3ButtonPushed, true);
            app.AirspdSet_3.Layout.Row = 3;
            app.AirspdSet_3.Layout.Column = [3 4];
            app.AirspdSet_3.Text = '设置空速';

            % Create UAVPanel_4
            app.UAVPanel_4 = uipanel(app.TabFlight);
            app.UAVPanel_4.Title = '[0]离线|锁定';
            app.UAVPanel_4.Position = [186 258 186 238];

            % Create GridLayout_4
            app.GridLayout_4 = uigridlayout(app.UAVPanel_4);
            app.GridLayout_4.ColumnWidth = {29, '1x', 29, '1x'};
            app.GridLayout_4.RowHeight = {'1x', 23, 23, 22, 22};
            app.GridLayout_4.ColumnSpacing = 4.4;
            app.GridLayout_4.RowSpacing = 7.8888905843099;
            app.GridLayout_4.Padding = [4.4 7.8888905843099 4.4 7.8888905843099];

            % Create AngleDeg_4
            app.AngleDeg_4 = uiaeroheading(app.GridLayout_4);
            app.AngleDeg_4.Layout.Row = 1;
            app.AngleDeg_4.Layout.Column = [3 4];

            % Create HudDeg_4
            app.HudDeg_4 = uiaerohorizon(app.GridLayout_4);
            app.HudDeg_4.Layout.Row = 1;
            app.HudDeg_4.Layout.Column = [1 2];

            % Create ModeSet_4
            app.ModeSet_4 = uibutton(app.GridLayout_4, 'push');
            app.ModeSet_4.ButtonPushedFcn = createCallbackFcn(app, @ModeSet_4ButtonPushed, true);
            app.ModeSet_4.Layout.Row = 2;
            app.ModeSet_4.Layout.Column = [3 4];
            app.ModeSet_4.Text = '设置模式';

            % Create ModeList_4
            app.ModeList_4 = uidropdown(app.GridLayout_4);
            app.ModeList_4.Items = {'自稳', '定点', '引导', '降落', '返航', '自动', '刹车', '盘旋', '手动', '起飞', '解锁'};
            app.ModeList_4.Layout.Row = 2;
            app.ModeList_4.Layout.Column = [1 2];
            app.ModeList_4.Value = '自稳';

            % Create AirspdSet_4
            app.AirspdSet_4 = uibutton(app.GridLayout_4, 'push');
            app.AirspdSet_4.ButtonPushedFcn = createCallbackFcn(app, @AirspdSet_4ButtonPushed, true);
            app.AirspdSet_4.Layout.Row = 3;
            app.AirspdSet_4.Layout.Column = [3 4];
            app.AirspdSet_4.Text = '设置空速';

            % Create GroundspdLabel_4
            app.GroundspdLabel_4 = uilabel(app.GridLayout_4);
            app.GroundspdLabel_4.Layout.Row = 4;
            app.GroundspdLabel_4.Layout.Column = 1;
            app.GroundspdLabel_4.Text = '地速';

            % Create Groundspd_4
            app.Groundspd_4 = uieditfield(app.GridLayout_4, 'text');
            app.Groundspd_4.Layout.Row = 4;
            app.Groundspd_4.Layout.Column = 2;

            % Create AirspdLabel_4
            app.AirspdLabel_4 = uilabel(app.GridLayout_4);
            app.AirspdLabel_4.Layout.Row = 4;
            app.AirspdLabel_4.Layout.Column = 3;
            app.AirspdLabel_4.Text = '空速';

            % Create Airspd_4
            app.Airspd_4 = uieditfield(app.GridLayout_4, 'text');
            app.Airspd_4.Layout.Row = 4;
            app.Airspd_4.Layout.Column = 4;

            % Create AltLabel_4
            app.AltLabel_4 = uilabel(app.GridLayout_4);
            app.AltLabel_4.Layout.Row = 5;
            app.AltLabel_4.Layout.Column = 1;
            app.AltLabel_4.Text = '高度';

            % Create Alt_4
            app.Alt_4 = uieditfield(app.GridLayout_4, 'text');
            app.Alt_4.Layout.Row = 5;
            app.Alt_4.Layout.Column = 2;

            % Create ClimbspdLabel_4
            app.ClimbspdLabel_4 = uilabel(app.GridLayout_4);
            app.ClimbspdLabel_4.Layout.Row = 5;
            app.ClimbspdLabel_4.Layout.Column = 3;
            app.ClimbspdLabel_4.Text = '升速';

            % Create Climbspd_4
            app.Climbspd_4 = uieditfield(app.GridLayout_4, 'text');
            app.Climbspd_4.Layout.Row = 5;
            app.Climbspd_4.Layout.Column = 4;

            % Create AirspdSelectLabel_4
            app.AirspdSelectLabel_4 = uilabel(app.GridLayout_4);
            app.AirspdSelectLabel_4.Layout.Row = 3;
            app.AirspdSelectLabel_4.Layout.Column = 1;
            app.AirspdSelectLabel_4.Text = '空速';

            % Create AirspdSelect_4
            app.AirspdSelect_4 = uieditfield(app.GridLayout_4, 'numeric');
            app.AirspdSelect_4.Limits = [0 100];
            app.AirspdSelect_4.Layout.Row = 3;
            app.AirspdSelect_4.Layout.Column = 2;

            % Create CmdPanel
            app.CmdPanel = uipanel(app.TabFlight);
            app.CmdPanel.Title = '操作台';
            app.CmdPanel.Position = [1 -1 371 260];

            % Create PageScroll
            app.PageScroll = uibutton(app.CmdPanel, 'push');
            app.PageScroll.ButtonPushedFcn = createCallbackFcn(app, @PageScrollButtonPushed, true);
            app.PageScroll.Position = [77 210 66 24];
            app.PageScroll.Text = '翻页';

            % Create DisplayStart
            app.DisplayStart = uibutton(app.CmdPanel, 'state');
            app.DisplayStart.ValueChangedFcn = createCallbackFcn(app, @DisplayStartValueChanged, true);
            app.DisplayStart.Text = '显示';
            app.DisplayStart.Position = [5 210 66 24];

            % Create GuidedStart
            app.GuidedStart = uibutton(app.CmdPanel, 'state');
            app.GuidedStart.ValueChangedFcn = createCallbackFcn(app, @GuidedStartValueChanged, true);
            app.GuidedStart.Text = '控制';
            app.GuidedStart.Position = [5 179 66 24];

            % Create SwitchNavStart
            app.SwitchNavStart = uibutton(app.CmdPanel, 'push');
            app.SwitchNavStart.ButtonPushedFcn = createCallbackFcn(app, @SwitchNavStartButtonPushed, true);
            app.SwitchNavStart.Position = [77 179 66 24];
            app.SwitchNavStart.Text = '切换起点';

            % Create TabPlanning
            app.TabPlanning = uitab(app.TabGroupFlight);
            app.TabPlanning.Title = '任务规划';

            % Create CanvasGroup
            app.CanvasGroup = uibuttongroup(app.TabPlanning);
            app.CanvasGroup.Title = '手动规划';
            app.CanvasGroup.Position = [1 430 60 152];

            % Create CanvasMode_1
            app.CanvasMode_1 = uiradiobutton(app.CanvasGroup);
            app.CanvasMode_1.Enable = 'off';
            app.CanvasMode_1.Text = '增加';
            app.CanvasMode_1.Position = [8 101 46 22];
            app.CanvasMode_1.Value = true;

            % Create CanvasMode_2
            app.CanvasMode_2 = uiradiobutton(app.CanvasGroup);
            app.CanvasMode_2.Enable = 'off';
            app.CanvasMode_2.Text = '删除';
            app.CanvasMode_2.Position = [8 71 46 22];

            % Create CanvasMode_3
            app.CanvasMode_3 = uiradiobutton(app.CanvasGroup);
            app.CanvasMode_3.Enable = 'off';
            app.CanvasMode_3.Text = '移动';
            app.CanvasMode_3.Position = [8 41 46 22];

            % Create CanvasMode_4
            app.CanvasMode_4 = uiradiobutton(app.CanvasGroup);
            app.CanvasMode_4.Enable = 'off';
            app.CanvasMode_4.Text = '插入';
            app.CanvasMode_4.Position = [8 11 46 22];

            % Create TaskGroup
            app.TaskGroup = uibuttongroup(app.TabPlanning);
            app.TaskGroup.Title = '任务区域';
            app.TaskGroup.Position = [1 581 60 152];

            % Create TaskMode_1
            app.TaskMode_1 = uiradiobutton(app.TaskGroup);
            app.TaskMode_1.Text = '航点';
            app.TaskMode_1.Position = [8 104 46 22];
            app.TaskMode_1.Value = true;

            % Create TaskMode_2
            app.TaskMode_2 = uiradiobutton(app.TaskGroup);
            app.TaskMode_2.Enable = 'off';
            app.TaskMode_2.Text = '搜索';
            app.TaskMode_2.Position = [8 79 46 22];

            % Create TaskMode_3
            app.TaskMode_3 = uiradiobutton(app.TaskGroup);
            app.TaskMode_3.Enable = 'off';
            app.TaskMode_3.Text = '避障';
            app.TaskMode_3.Position = [8 54 46 22];

            % Create TaskMode_4
            app.TaskMode_4 = uiradiobutton(app.TaskGroup);
            app.TaskMode_4.Enable = 'off';
            app.TaskMode_4.Text = '拦阻';
            app.TaskMode_4.Position = [8 29 46 22];

            % Create TaskMode_5
            app.TaskMode_5 = uiradiobutton(app.TaskGroup);
            app.TaskMode_5.Enable = 'off';
            app.TaskMode_5.Text = '打击';
            app.TaskMode_5.Position = [8 5 46 22];

            % Create CanvasPanel
            app.CanvasPanel = uipanel(app.TabPlanning);
            app.CanvasPanel.Title = '操作台|地面';
            app.CanvasPanel.Position = [60 430 310 152];

            % Create CanvasGrid
            app.CanvasGrid = uigridlayout(app.CanvasPanel);
            app.CanvasGrid.ColumnWidth = {'100x', 29, '100x', 29, '100x'};
            app.CanvasGrid.RowHeight = {24, 23, 23, 23};
            app.CanvasGrid.RowSpacing = 7.26666870117188;
            app.CanvasGrid.Padding = [10 7.26666870117188 10 7.26666870117188];

            % Create CanvasStart
            app.CanvasStart = uibutton(app.CanvasGrid, 'state');
            app.CanvasStart.ValueChangedFcn = createCallbackFcn(app, @CanvasStartValueChanged, true);
            app.CanvasStart.Enable = 'off';
            app.CanvasStart.Text = '选点/区';
            app.CanvasStart.Layout.Row = 1;
            app.CanvasStart.Layout.Column = 1;

            % Create CanvasClear
            app.CanvasClear = uibutton(app.CanvasGrid, 'push');
            app.CanvasClear.Enable = 'off';
            app.CanvasClear.Layout.Row = 4;
            app.CanvasClear.Layout.Column = 1;
            app.CanvasClear.Text = '航点清空';

            % Create NavDownload
            app.NavDownload = uibutton(app.CanvasGrid, 'push');
            app.NavDownload.ButtonPushedFcn = createCallbackFcn(app, @NavDownloadButtonPushed, true);
            app.NavDownload.Layout.Row = 2;
            app.NavDownload.Layout.Column = 1;
            app.NavDownload.Text = '航点下载';

            % Create NavUpload
            app.NavUpload = uibutton(app.CanvasGrid, 'push');
            app.NavUpload.ButtonPushedFcn = createCallbackFcn(app, @NavUploadButtonPushed, true);
            app.NavUpload.Layout.Row = 3;
            app.NavUpload.Layout.Column = 1;
            app.NavUpload.Text = '航点上传';

            % Create NavIDLabel
            app.NavIDLabel = uilabel(app.CanvasGrid);
            app.NavIDLabel.Layout.Row = 1;
            app.NavIDLabel.Layout.Column = 2;
            app.NavIDLabel.Text = '航点';

            % Create NavID
            app.NavID = uidropdown(app.CanvasGrid);
            app.NavID.Items = {'1', '2', '3', '4'};
            app.NavID.Layout.Row = 1;
            app.NavID.Layout.Column = 3;
            app.NavID.Value = '1';

            % Create NavCmdLabel
            app.NavCmdLabel = uilabel(app.CanvasGrid);
            app.NavCmdLabel.Layout.Row = 2;
            app.NavCmdLabel.Layout.Column = 2;
            app.NavCmdLabel.Text = '类型';

            % Create NavCmd
            app.NavCmd = uidropdown(app.CanvasGrid);
            app.NavCmd.Items = {'路点', '盘旋', '定次', '定时', '返航'};
            app.NavCmd.Layout.Row = 2;
            app.NavCmd.Layout.Column = 3;
            app.NavCmd.Value = '路点';

            % Create NavAltLabel
            app.NavAltLabel = uilabel(app.CanvasGrid);
            app.NavAltLabel.Layout.Row = 1;
            app.NavAltLabel.Layout.Column = 4;
            app.NavAltLabel.Text = '高度';

            % Create NavAlt
            app.NavAlt = uieditfield(app.CanvasGrid, 'numeric');
            app.NavAlt.Layout.Row = 1;
            app.NavAlt.Layout.Column = 5;

            % Create NavRadLabel
            app.NavRadLabel = uilabel(app.CanvasGrid);
            app.NavRadLabel.Layout.Row = 2;
            app.NavRadLabel.Layout.Column = 4;
            app.NavRadLabel.Text = '半径';

            % Create NavRad
            app.NavRad = uieditfield(app.CanvasGrid, 'numeric');
            app.NavRad.Layout.Row = 2;
            app.NavRad.Layout.Column = 5;

            % Create NavSpdLabel
            app.NavSpdLabel = uilabel(app.CanvasGrid);
            app.NavSpdLabel.Layout.Row = 3;
            app.NavSpdLabel.Layout.Column = 4;
            app.NavSpdLabel.Text = '速度';

            % Create NavSpd
            app.NavSpd = uieditfield(app.CanvasGrid, 'numeric');
            app.NavSpd.Layout.Row = 3;
            app.NavSpd.Layout.Column = 5;

            % Create NavTimeLabel
            app.NavTimeLabel = uilabel(app.CanvasGrid);
            app.NavTimeLabel.Layout.Row = 3;
            app.NavTimeLabel.Layout.Column = 2;
            app.NavTimeLabel.Text = '时间';

            % Create NavTime
            app.NavTime = uieditfield(app.CanvasGrid, 'numeric');
            app.NavTime.Layout.Row = 3;
            app.NavTime.Layout.Column = 3;

            % Create NavSwitch
            app.NavSwitch = uibutton(app.CanvasGrid, 'push');
            app.NavSwitch.ButtonPushedFcn = createCallbackFcn(app, @NavSwitchButtonPushed, true);
            app.NavSwitch.Layout.Row = 4;
            app.NavSwitch.Layout.Column = [2 3];
            app.NavSwitch.Text = '切换航点';

            % Create NavModify
            app.NavModify = uibutton(app.CanvasGrid, 'state');
            app.NavModify.Enable = 'off';
            app.NavModify.Text = '修改航点';
            app.NavModify.Layout.Row = 4;
            app.NavModify.Layout.Column = [4 5];

            % Create TaskPanel
            app.TaskPanel = uipanel(app.TabPlanning);
            app.TaskPanel.Title = '操作台|地面';
            app.TaskPanel.Position = [60 581 310 152];

            % Create TaskGrid
            app.TaskGrid = uigridlayout(app.TaskPanel);
            app.TaskGrid.ColumnWidth = {'100x', 29, '100x', 29, '100x'};
            app.TaskGrid.RowHeight = {24, 23, 23, 23};
            app.TaskGrid.RowSpacing = 7.46666870117187;
            app.TaskGrid.Padding = [10 7.46666870117187 10 7.46666870117187];

            % Create TaskClear
            app.TaskClear = uibutton(app.TaskGrid, 'push');
            app.TaskClear.Enable = 'off';
            app.TaskClear.Layout.Row = 4;
            app.TaskClear.Layout.Column = 1;
            app.TaskClear.Text = '任务清空';

            % Create TaskDownload
            app.TaskDownload = uibutton(app.TaskGrid, 'push');
            app.TaskDownload.Enable = 'off';
            app.TaskDownload.Layout.Row = 2;
            app.TaskDownload.Layout.Column = 1;
            app.TaskDownload.Text = '任务下载';

            % Create TaskUpload
            app.TaskUpload = uibutton(app.TaskGrid, 'push');
            app.TaskUpload.Enable = 'off';
            app.TaskUpload.Layout.Row = 3;
            app.TaskUpload.Layout.Column = 1;
            app.TaskUpload.Text = '任务上传';

            % Create TaskSwitch
            app.TaskSwitch = uibutton(app.TaskGrid, 'push');
            app.TaskSwitch.Enable = 'off';
            app.TaskSwitch.Layout.Row = 4;
            app.TaskSwitch.Layout.Column = [2 3];
            app.TaskSwitch.Text = '修改';

            % Create TaskModify
            app.TaskModify = uibutton(app.TaskGrid, 'push');
            app.TaskModify.Enable = 'off';
            app.TaskModify.Layout.Row = 4;
            app.TaskModify.Layout.Column = [4 5];
            app.TaskModify.Text = '读取';

            % Create PlanUAVIDLabel
            app.PlanUAVIDLabel = uilabel(app.TaskGrid);
            app.PlanUAVIDLabel.Layout.Row = 1;
            app.PlanUAVIDLabel.Layout.Column = 2;
            app.PlanUAVIDLabel.Text = '飞机';

            % Create PlanUAVID
            app.PlanUAVID = uidropdown(app.TaskGrid);
            app.PlanUAVID.Items = {'1', '2', '3', '4'};
            app.PlanUAVID.ValueChangedFcn = createCallbackFcn(app, @PlanUAVIDValueChanged, true);
            app.PlanUAVID.Layout.Row = 1;
            app.PlanUAVID.Layout.Column = 3;
            app.PlanUAVID.Value = '1';

            % Create PlanTaskIDLabel
            app.PlanTaskIDLabel = uilabel(app.TaskGrid);
            app.PlanTaskIDLabel.Enable = 'off';
            app.PlanTaskIDLabel.Layout.Row = 2;
            app.PlanTaskIDLabel.Layout.Column = 2;
            app.PlanTaskIDLabel.Text = '任务';

            % Create PlanTaskID
            app.PlanTaskID = uidropdown(app.TaskGrid);
            app.PlanTaskID.Items = {'1', '2', '3', '4'};
            app.PlanTaskID.Enable = 'off';
            app.PlanTaskID.Layout.Row = 2;
            app.PlanTaskID.Layout.Column = 3;
            app.PlanTaskID.Value = '1';

            % Create TaskAltLabel
            app.TaskAltLabel = uilabel(app.TaskGrid);
            app.TaskAltLabel.Layout.Row = 1;
            app.TaskAltLabel.Layout.Column = 4;
            app.TaskAltLabel.Text = '高度';

            % Create TaskAlt
            app.TaskAlt = uieditfield(app.TaskGrid, 'numeric');
            app.TaskAlt.Limits = [0 Inf];
            app.TaskAlt.Layout.Row = 1;
            app.TaskAlt.Layout.Column = 5;

            % Create TaskRadLabel
            app.TaskRadLabel = uilabel(app.TaskGrid);
            app.TaskRadLabel.Enable = 'off';
            app.TaskRadLabel.Layout.Row = 2;
            app.TaskRadLabel.Layout.Column = 4;
            app.TaskRadLabel.Text = '半径';

            % Create TaskRad
            app.TaskRad = uieditfield(app.TaskGrid, 'numeric');
            app.TaskRad.Limits = [0 Inf];
            app.TaskRad.Enable = 'off';
            app.TaskRad.Layout.Row = 2;
            app.TaskRad.Layout.Column = 5;

            % Create TaskAngLabel
            app.TaskAngLabel = uilabel(app.TaskGrid);
            app.TaskAngLabel.Enable = 'off';
            app.TaskAngLabel.Layout.Row = 3;
            app.TaskAngLabel.Layout.Column = 4;
            app.TaskAngLabel.Text = '角度';

            % Create TaskAng
            app.TaskAng = uieditfield(app.TaskGrid, 'numeric');
            app.TaskAng.Limits = [0 360];
            app.TaskAng.Enable = 'off';
            app.TaskAng.Layout.Row = 3;
            app.TaskAng.Layout.Column = 5;

            % Create TaskAltSet
            app.TaskAltSet = uibutton(app.TaskGrid, 'push');
            app.TaskAltSet.ButtonPushedFcn = createCallbackFcn(app, @TaskAltSetButtonPushed, true);
            app.TaskAltSet.Layout.Row = 1;
            app.TaskAltSet.Layout.Column = 1;
            app.TaskAltSet.Text = '一键定高';

            % Create PlanUAVTeam
            app.PlanUAVTeam = uidropdown(app.TaskGrid);
            app.PlanUAVTeam.Items = {'1', '2'};
            app.PlanUAVTeam.Enable = 'off';
            app.PlanUAVTeam.Layout.Row = 3;
            app.PlanUAVTeam.Layout.Column = 3;
            app.PlanUAVTeam.Value = '1';

            % Create PlanUAVTeamLabel
            app.PlanUAVTeamLabel = uilabel(app.TaskGrid);
            app.PlanUAVTeamLabel.Enable = 'off';
            app.PlanUAVTeamLabel.Layout.Row = 3;
            app.PlanUAVTeamLabel.Layout.Column = 2;
            app.PlanUAVTeamLabel.Text = '类型';

            % Create FormationGroup
            app.FormationGroup = uibuttongroup(app.TabPlanning);
            app.FormationGroup.Title = '队形规划';
            app.FormationGroup.Position = [1 218 60 213];

            % Create FormationMode_1
            app.FormationMode_1 = uiradiobutton(app.FormationGroup);
            app.FormationMode_1.Enable = 'off';
            app.FormationMode_1.Text = '一字';
            app.FormationMode_1.Position = [8 164 46 22];

            % Create FormationMode_2
            app.FormationMode_2 = uiradiobutton(app.FormationGroup);
            app.FormationMode_2.Enable = 'off';
            app.FormationMode_2.Text = '三角';
            app.FormationMode_2.Position = [8 125 46 22];
            app.FormationMode_2.Value = true;

            % Create FormationMode_3
            app.FormationMode_3 = uiradiobutton(app.FormationGroup);
            app.FormationMode_3.Enable = 'off';
            app.FormationMode_3.Text = '人字';
            app.FormationMode_3.Position = [8 86 46 22];

            % Create FormationMode_4
            app.FormationMode_4 = uiradiobutton(app.FormationGroup);
            app.FormationMode_4.Enable = 'off';
            app.FormationMode_4.Text = '方形';
            app.FormationMode_4.Position = [8 48 46 22];

            % Create FormationMode_5
            app.FormationMode_5 = uiradiobutton(app.FormationGroup);
            app.FormationMode_5.Enable = 'off';
            app.FormationMode_5.Text = '圆形';
            app.FormationMode_5.Position = [8 10 46 22];

            % Create FormationPanel
            app.FormationPanel = uipanel(app.TabPlanning);
            app.FormationPanel.Title = '操作台|编队';
            app.FormationPanel.Position = [60 218 310 213];

            % Create FormationGrid
            app.FormationGrid = uigridlayout(app.FormationPanel);
            app.FormationGrid.ColumnWidth = {'100x', 29, '100x', 29, '100x'};
            app.FormationGrid.RowHeight = {24, 24, 23, 23, 23, 23};
            app.FormationGrid.RowSpacing = 7.33333478655134;
            app.FormationGrid.Padding = [10 7.33333478655134 10 7.33333478655134];

            % Create FormationStart
            app.FormationStart = uibutton(app.FormationGrid, 'state');
            app.FormationStart.Enable = 'off';
            app.FormationStart.Text = '编队';
            app.FormationStart.Layout.Row = 1;
            app.FormationStart.Layout.Column = 1;

            % Create FormClear
            app.FormClear = uibutton(app.FormationGrid, 'push');
            app.FormClear.Enable = 'off';
            app.FormClear.Layout.Row = 4;
            app.FormClear.Layout.Column = 1;
            app.FormClear.Text = '偏移清空';

            % Create FormDispDownload
            app.FormDispDownload = uibutton(app.FormationGrid, 'push');
            app.FormDispDownload.Enable = 'off';
            app.FormDispDownload.Layout.Row = 2;
            app.FormDispDownload.Layout.Column = 1;
            app.FormDispDownload.Text = '偏移下载';

            % Create FormDispUpload
            app.FormDispUpload = uibutton(app.FormationGrid, 'push');
            app.FormDispUpload.Enable = 'off';
            app.FormDispUpload.Layout.Row = 3;
            app.FormDispUpload.Layout.Column = 1;
            app.FormDispUpload.Text = '偏移上传';

            % Create FormDispModify
            app.FormDispModify = uibutton(app.FormationGrid, 'push');
            app.FormDispModify.Enable = 'off';
            app.FormDispModify.Layout.Row = 6;
            app.FormDispModify.Layout.Column = 1;
            app.FormDispModify.Text = '修改偏移';

            % Create FormDispRead
            app.FormDispRead = uibutton(app.FormationGrid, 'push');
            app.FormDispRead.Enable = 'off';
            app.FormDispRead.Layout.Row = 5;
            app.FormDispRead.Layout.Column = 1;
            app.FormDispRead.Text = '读取偏移';

            % Create FormScaleLabel
            app.FormScaleLabel = uilabel(app.FormationGrid);
            app.FormScaleLabel.Enable = 'off';
            app.FormScaleLabel.Layout.Row = 1;
            app.FormScaleLabel.Layout.Column = 2;
            app.FormScaleLabel.Text = '缩放';

            % Create FormScale
            app.FormScale = uidropdown(app.FormationGrid);
            app.FormScale.Items = {'点形', '队形', 'X/2', 'Y/2'};
            app.FormScale.Enable = 'off';
            app.FormScale.Layout.Row = 1;
            app.FormScale.Layout.Column = 3;
            app.FormScale.Value = '点形';

            % Create FormAngLabel
            app.FormAngLabel = uilabel(app.FormationGrid);
            app.FormAngLabel.Enable = 'off';
            app.FormAngLabel.Layout.Row = 1;
            app.FormAngLabel.Layout.Column = 4;
            app.FormAngLabel.Text = '角度';

            % Create FormAng
            app.FormAng = uidropdown(app.FormationGrid);
            app.FormAng.Items = {'0', '90', '180', '270'};
            app.FormAng.Editable = 'on';
            app.FormAng.Enable = 'off';
            app.FormAng.BackgroundColor = [1 1 1];
            app.FormAng.Layout.Row = 1;
            app.FormAng.Layout.Column = 5;
            app.FormAng.Value = '0';

            % Create FormTypeLabel
            app.FormTypeLabel = uilabel(app.FormationGrid);
            app.FormTypeLabel.Enable = 'off';
            app.FormTypeLabel.Layout.Row = 3;
            app.FormTypeLabel.Layout.Column = 2;
            app.FormTypeLabel.Text = '类型';

            % Create FormType
            app.FormType = uidropdown(app.FormationGrid);
            app.FormType.Items = {'平移', '旋转'};
            app.FormType.Enable = 'off';
            app.FormType.Layout.Row = 3;
            app.FormType.Layout.Column = 3;
            app.FormType.Value = '平移';

            % Create FormRadSliderLabel
            app.FormRadSliderLabel = uilabel(app.FormationGrid);
            app.FormRadSliderLabel.WordWrap = 'on';
            app.FormRadSliderLabel.Enable = 'off';
            app.FormRadSliderLabel.Layout.Row = [5 6];
            app.FormRadSliderLabel.Layout.Column = 2;
            app.FormRadSliderLabel.Text = {'半径'; '百米'};

            % Create FormRadSlider
            app.FormRadSlider = uislider(app.FormationGrid);
            app.FormRadSlider.Limits = [1 10];
            app.FormRadSlider.Enable = 'off';
            app.FormRadSlider.Layout.Row = [5 6];
            app.FormRadSlider.Layout.Column = [3 5];
            app.FormRadSlider.Value = 1;

            % Create FormCenTrackLabel
            app.FormCenTrackLabel = uilabel(app.FormationGrid);
            app.FormCenTrackLabel.Enable = 'off';
            app.FormCenTrackLabel.Layout.Row = 4;
            app.FormCenTrackLabel.Layout.Column = 2;
            app.FormCenTrackLabel.Text = '航线';

            % Create FormCenTrack
            app.FormCenTrack = uidropdown(app.FormationGrid);
            app.FormCenTrack.Items = {'质心', '飞机'};
            app.FormCenTrack.Enable = 'off';
            app.FormCenTrack.Layout.Row = 4;
            app.FormCenTrack.Layout.Column = 3;
            app.FormCenTrack.Value = '质心';

            % Create FormDispXLabel
            app.FormDispXLabel = uilabel(app.FormationGrid);
            app.FormDispXLabel.Enable = 'off';
            app.FormDispXLabel.Layout.Row = 2;
            app.FormDispXLabel.Layout.Column = 4;
            app.FormDispXLabel.Text = 'X偏';

            % Create FormDispX
            app.FormDispX = uieditfield(app.FormationGrid, 'numeric');
            app.FormDispX.Enable = 'off';
            app.FormDispX.Layout.Row = 2;
            app.FormDispX.Layout.Column = 5;

            % Create FormDispYLabel
            app.FormDispYLabel = uilabel(app.FormationGrid);
            app.FormDispYLabel.Enable = 'off';
            app.FormDispYLabel.Layout.Row = 3;
            app.FormDispYLabel.Layout.Column = 4;
            app.FormDispYLabel.Text = 'Y偏';

            % Create FormDispY
            app.FormDispY = uieditfield(app.FormationGrid, 'numeric');
            app.FormDispY.Enable = 'off';
            app.FormDispY.Layout.Row = 3;
            app.FormDispY.Layout.Column = 5;

            % Create FormDispZLabel
            app.FormDispZLabel = uilabel(app.FormationGrid);
            app.FormDispZLabel.Enable = 'off';
            app.FormDispZLabel.Layout.Row = 4;
            app.FormDispZLabel.Layout.Column = 4;
            app.FormDispZLabel.Text = 'Z偏';

            % Create FormDispZ
            app.FormDispZ = uieditfield(app.FormationGrid, 'numeric');
            app.FormDispZ.Enable = 'off';
            app.FormDispZ.Layout.Row = 4;
            app.FormDispZ.Layout.Column = 5;

            % Create FormAltKeepLabel
            app.FormAltKeepLabel = uilabel(app.FormationGrid);
            app.FormAltKeepLabel.Enable = 'off';
            app.FormAltKeepLabel.Layout.Row = 2;
            app.FormAltKeepLabel.Layout.Column = 2;
            app.FormAltKeepLabel.Text = '同高';

            % Create FormAltKeep
            app.FormAltKeep = uidropdown(app.FormationGrid);
            app.FormAltKeep.Items = {'是', '否'};
            app.FormAltKeep.Enable = 'off';
            app.FormAltKeep.Layout.Row = 2;
            app.FormAltKeep.Layout.Column = 3;
            app.FormAltKeep.Value = '否';

            % Create TabDecision
            app.TabDecision = uitab(app.TabGroupFlight);
            app.TabDecision.Title = '在线决策';

            % Create CopyrightLabel
            app.CopyrightLabel = uilabel(app.TabMap);
            app.CopyrightLabel.Position = [1298 3 87 17];
            app.CopyrightLabel.Text = '海山科技 2024 ';

            % Create CtrlTimeLabel
            app.CtrlTimeLabel = uilabel(app.TabMap);
            app.CtrlTimeLabel.Position = [1015 3 264 17];
            app.CtrlTimeLabel.Text = '';

            % Create UAVIDListLabel
            app.UAVIDListLabel = uilabel(app.TabMap);
            app.UAVIDListLabel.HorizontalAlignment = 'right';
            app.UAVIDListLabel.Position = [47 5 101 22];
            app.UAVIDListLabel.Text = '当前连接无人机ID';

            % Create UAVIDList
            app.UAVIDList = uieditfield(app.TabMap, 'text');
            app.UAVIDList.Position = [163 5 353 22];

            % Create MapGPSLatLabel
            app.MapGPSLatLabel = uilabel(app.TabMap);
            app.MapGPSLatLabel.HorizontalAlignment = 'right';
            app.MapGPSLatLabel.Position = [720 5 29 22];
            app.MapGPSLatLabel.Text = '纬度';

            % Create MapGPSLat
            app.MapGPSLat = uieditfield(app.TabMap, 'numeric');
            app.MapGPSLat.ValueDisplayFormat = '%.8f';
            app.MapGPSLat.Position = [752 5 100 22];

            % Create MapGPSLonLabel
            app.MapGPSLonLabel = uilabel(app.TabMap);
            app.MapGPSLonLabel.HorizontalAlignment = 'right';
            app.MapGPSLonLabel.Position = [858 5 29 22];
            app.MapGPSLonLabel.Text = '经度';

            % Create MapGPSLon
            app.MapGPSLon = uieditfield(app.TabMap, 'numeric');
            app.MapGPSLon.ValueDisplayFormat = '%.8f';
            app.MapGPSLon.Position = [890 5 100 22];

            % Create MapGPSSet
            app.MapGPSSet = uibutton(app.TabMap, 'push');
            app.MapGPSSet.ButtonPushedFcn = createCallbackFcn(app, @MapGPSSetButtonPushed, true);
            app.MapGPSSet.Position = [545 4 76 24];
            app.MapGPSSet.Text = '设置原点';

            % Create MapGPSUnify
            app.MapGPSUnify = uibutton(app.TabMap, 'push');
            app.MapGPSUnify.ButtonPushedFcn = createCallbackFcn(app, @MapGPSUnifyButtonPushed, true);
            app.MapGPSUnify.Enable = 'off';
            app.MapGPSUnify.Position = [627 4 76 24];
            app.MapGPSUnify.Text = '统一原点';

            % Create TabSetting
            app.TabSetting = uitab(app.TabGroupMap);
            app.TabSetting.Title = '设置';

            % Create LinkPanel
            app.LinkPanel = uipanel(app.TabSetting);
            app.LinkPanel.Title = '连接';
            app.LinkPanel.Position = [12 405 128 366];

            % Create LinkGrid
            app.LinkGrid = uigridlayout(app.LinkPanel);
            app.LinkGrid.ColumnWidth = {56, 56};
            app.LinkGrid.RowHeight = {22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 23};
            app.LinkGrid.ColumnSpacing = 4.66666666666667;
            app.LinkGrid.RowSpacing = 8.44444529215495;
            app.LinkGrid.Padding = [4.66666666666667 8.44444529215495 4.66666666666667 8.44444529215495];

            % Create LinkButtonOn
            app.LinkButtonOn = uibutton(app.LinkGrid, 'push');
            app.LinkButtonOn.ButtonPushedFcn = createCallbackFcn(app, @LinkButtonOnPushed, true);
            app.LinkButtonOn.Layout.Row = 4;
            app.LinkButtonOn.Layout.Column = 1;
            app.LinkButtonOn.Text = '连接';

            % Create LinkButtonOff
            app.LinkButtonOff = uibutton(app.LinkGrid, 'push');
            app.LinkButtonOff.ButtonPushedFcn = createCallbackFcn(app, @LinkButtonOffPushed, true);
            app.LinkButtonOff.Layout.Row = 4;
            app.LinkButtonOff.Layout.Column = 2;
            app.LinkButtonOff.Text = '断开';

            % Create WorkButtonWrite
            app.WorkButtonWrite = uibutton(app.LinkGrid, 'push');
            app.WorkButtonWrite.Enable = 'off';
            app.WorkButtonWrite.Layout.Row = 11;
            app.WorkButtonWrite.Layout.Column = 1;
            app.WorkButtonWrite.Text = '写入';

            % Create WorkButtonRead
            app.WorkButtonRead = uibutton(app.LinkGrid, 'push');
            app.WorkButtonRead.Enable = 'off';
            app.WorkButtonRead.Layout.Row = 11;
            app.WorkButtonRead.Layout.Column = 2;
            app.WorkButtonRead.Text = '读取';

            % Create LinkIDLabel
            app.LinkIDLabel = uilabel(app.LinkGrid);
            app.LinkIDLabel.HorizontalAlignment = 'right';
            app.LinkIDLabel.Layout.Row = 3;
            app.LinkIDLabel.Layout.Column = 1;
            app.LinkIDLabel.Text = '飞机ID';

            % Create LinkID
            app.LinkID = uidropdown(app.LinkGrid);
            app.LinkID.Items = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32'};
            app.LinkID.Editable = 'on';
            app.LinkID.ValueChangedFcn = createCallbackFcn(app, @LinkIDValueChanged, true);
            app.LinkID.BackgroundColor = [1 1 1];
            app.LinkID.Layout.Row = 3;
            app.LinkID.Layout.Column = 2;
            app.LinkID.Value = '1';

            % Create LinkPortLabel
            app.LinkPortLabel = uilabel(app.LinkGrid);
            app.LinkPortLabel.HorizontalAlignment = 'right';
            app.LinkPortLabel.Layout.Row = 2;
            app.LinkPortLabel.Layout.Column = 1;
            app.LinkPortLabel.Text = '起始端口';

            % Create LinkPort
            app.LinkPort = uieditfield(app.LinkGrid, 'numeric');
            app.LinkPort.Limits = [0 Inf];
            app.LinkPort.ValueDisplayFormat = '%.0f';
            app.LinkPort.Layout.Row = 2;
            app.LinkPort.Layout.Column = 2;
            app.LinkPort.Value = 12550;

            % Create WorkAltMinLabel
            app.WorkAltMinLabel = uilabel(app.LinkGrid);
            app.WorkAltMinLabel.HorizontalAlignment = 'right';
            app.WorkAltMinLabel.Layout.Row = 8;
            app.WorkAltMinLabel.Layout.Column = 1;
            app.WorkAltMinLabel.Text = '最小高度';

            % Create WorkAltMin
            app.WorkAltMin = uieditfield(app.LinkGrid, 'numeric');
            app.WorkAltMin.Limits = [0 Inf];
            app.WorkAltMin.Layout.Row = 8;
            app.WorkAltMin.Layout.Column = 2;
            app.WorkAltMin.Value = 50;

            % Create WorkAltErr
            app.WorkAltErr = uieditfield(app.LinkGrid, 'numeric');
            app.WorkAltErr.Limits = [0 Inf];
            app.WorkAltErr.Layout.Row = 7;
            app.WorkAltErr.Layout.Column = 2;
            app.WorkAltErr.Value = 1;

            % Create WorkAltErrLabel
            app.WorkAltErrLabel = uilabel(app.LinkGrid);
            app.WorkAltErrLabel.HorizontalAlignment = 'right';
            app.WorkAltErrLabel.Layout.Row = 7;
            app.WorkAltErrLabel.Layout.Column = 1;
            app.WorkAltErrLabel.Text = '高度误差';

            % Create WorkAltDist
            app.WorkAltDist = uieditfield(app.LinkGrid, 'numeric');
            app.WorkAltDist.Limits = [0 Inf];
            app.WorkAltDist.Layout.Row = 6;
            app.WorkAltDist.Layout.Column = 2;
            app.WorkAltDist.Value = 10;

            % Create WorkAltDistLabel
            app.WorkAltDistLabel = uilabel(app.LinkGrid);
            app.WorkAltDistLabel.HorizontalAlignment = 'right';
            app.WorkAltDistLabel.Layout.Row = 6;
            app.WorkAltDistLabel.Layout.Column = 1;
            app.WorkAltDistLabel.Text = '工作高差';

            % Create WorkAlt
            app.WorkAlt = uieditfield(app.LinkGrid, 'numeric');
            app.WorkAlt.Limits = [0 Inf];
            app.WorkAlt.Layout.Row = 5;
            app.WorkAlt.Layout.Column = 2;
            app.WorkAlt.Value = 60;

            % Create WorkAltLabel
            app.WorkAltLabel = uilabel(app.LinkGrid);
            app.WorkAltLabel.HorizontalAlignment = 'right';
            app.WorkAltLabel.Layout.Row = 5;
            app.WorkAltLabel.Layout.Column = 1;
            app.WorkAltLabel.Text = '工作高度';

            % Create GPSErrLabel
            app.GPSErrLabel = uilabel(app.LinkGrid);
            app.GPSErrLabel.HorizontalAlignment = 'right';
            app.GPSErrLabel.Layout.Row = 9;
            app.GPSErrLabel.Layout.Column = 1;
            app.GPSErrLabel.Text = 'GPS误差';

            % Create GPSErr
            app.GPSErr = uieditfield(app.LinkGrid, 'numeric');
            app.GPSErr.Limits = [0 Inf];
            app.GPSErr.Layout.Row = 9;
            app.GPSErr.Layout.Column = 2;
            app.GPSErr.Value = 1;

            % Create YawErrLabel
            app.YawErrLabel = uilabel(app.LinkGrid);
            app.YawErrLabel.HorizontalAlignment = 'right';
            app.YawErrLabel.Layout.Row = 10;
            app.YawErrLabel.Layout.Column = 1;
            app.YawErrLabel.Text = '偏航误差';

            % Create YawErr
            app.YawErr = uieditfield(app.LinkGrid, 'numeric');
            app.YawErr.Limits = [0 Inf];
            app.YawErr.Layout.Row = 10;
            app.YawErr.Layout.Column = 2;
            app.YawErr.Value = 0.07;

            % Create IPAddrLabel
            app.IPAddrLabel = uilabel(app.LinkGrid);
            app.IPAddrLabel.HorizontalAlignment = 'right';
            app.IPAddrLabel.Layout.Row = 1;
            app.IPAddrLabel.Layout.Column = 1;
            app.IPAddrLabel.Text = 'IP地址';

            % Create IPAddr
            app.IPAddr = uidropdown(app.LinkGrid);
            app.IPAddr.Items = {'本地', '虚拟', '实验'};
            app.IPAddr.Layout.Row = 1;
            app.IPAddr.Layout.Column = 2;
            app.IPAddr.Value = '本地';

            % Create ConfigPanel
            app.ConfigPanel = uipanel(app.TabSetting);
            app.ConfigPanel.Title = '地图显示';
            app.ConfigPanel.Position = [152 644 200 127];

            % Create ConfigGrid
            app.ConfigGrid = uigridlayout(app.ConfigPanel);
            app.ConfigGrid.ColumnWidth = {41, 56, 56};
            app.ConfigGrid.RowHeight = {22, 22, 23};
            app.ConfigGrid.RowSpacing = 9.06666564941406;
            app.ConfigGrid.Padding = [10 9.06666564941406 10 9.06666564941406];

            % Create ConfigLabelNorth
            app.ConfigLabelNorth = uilabel(app.ConfigGrid);
            app.ConfigLabelNorth.HorizontalAlignment = 'right';
            app.ConfigLabelNorth.Layout.Row = 1;
            app.ConfigLabelNorth.Layout.Column = 1;
            app.ConfigLabelNorth.Text = '北边界';

            % Create ConfigLabelEast
            app.ConfigLabelEast = uilabel(app.ConfigGrid);
            app.ConfigLabelEast.HorizontalAlignment = 'right';
            app.ConfigLabelEast.Layout.Row = 2;
            app.ConfigLabelEast.Layout.Column = 1;
            app.ConfigLabelEast.Text = '东边界';

            % Create ConfigButtonWrite
            app.ConfigButtonWrite = uibutton(app.ConfigGrid, 'push');
            app.ConfigButtonWrite.Enable = 'off';
            app.ConfigButtonWrite.Layout.Row = 3;
            app.ConfigButtonWrite.Layout.Column = 2;
            app.ConfigButtonWrite.Text = '写入';

            % Create ConfigButtonRead
            app.ConfigButtonRead = uibutton(app.ConfigGrid, 'push');
            app.ConfigButtonRead.Enable = 'off';
            app.ConfigButtonRead.Layout.Row = 3;
            app.ConfigButtonRead.Layout.Column = 3;
            app.ConfigButtonRead.Text = '读取';

            % Create ConfigNorthLeft
            app.ConfigNorthLeft = uieditfield(app.ConfigGrid, 'numeric');
            app.ConfigNorthLeft.HorizontalAlignment = 'left';
            app.ConfigNorthLeft.Layout.Row = 1;
            app.ConfigNorthLeft.Layout.Column = 2;
            app.ConfigNorthLeft.Value = -5000;

            % Create ConfigNorthRight
            app.ConfigNorthRight = uieditfield(app.ConfigGrid, 'numeric');
            app.ConfigNorthRight.HorizontalAlignment = 'left';
            app.ConfigNorthRight.Layout.Row = 1;
            app.ConfigNorthRight.Layout.Column = 3;
            app.ConfigNorthRight.Value = 5000;

            % Create ConfigEastLeft
            app.ConfigEastLeft = uieditfield(app.ConfigGrid, 'numeric');
            app.ConfigEastLeft.HorizontalAlignment = 'left';
            app.ConfigEastLeft.Layout.Row = 2;
            app.ConfigEastLeft.Layout.Column = 2;
            app.ConfigEastLeft.Value = -5000;

            % Create ConfigEastRight
            app.ConfigEastRight = uieditfield(app.ConfigGrid, 'numeric');
            app.ConfigEastRight.HorizontalAlignment = 'left';
            app.ConfigEastRight.Layout.Row = 2;
            app.ConfigEastRight.Layout.Column = 3;
            app.ConfigEastRight.Value = 5000;

            % Create ConfigDebug
            app.ConfigDebug = uibutton(app.ConfigGrid, 'state');
            app.ConfigDebug.Enable = 'off';
            app.ConfigDebug.Text = '调试';
            app.ConfigDebug.Layout.Row = 3;
            app.ConfigDebug.Layout.Column = 1;

            % Create PilotPanel
            app.PilotPanel = uipanel(app.TabSetting);
            app.PilotPanel.Title = '飞控参数';
            app.PilotPanel.Position = [152 281 200 352];

            % Create PilotGrid
            app.PilotGrid = uigridlayout(app.PilotPanel);
            app.PilotGrid.ColumnWidth = {115, 60};
            app.PilotGrid.RowHeight = {22, 22, 22, 22, 22, 22, 22, 22, 22, 23};
            app.PilotGrid.ColumnSpacing = 7.66666666666667;
            app.PilotGrid.RowSpacing = 9.93939486416903;
            app.PilotGrid.Padding = [7.66666666666667 9.93939486416903 7.66666666666667 9.93939486416903];

            % Create PilotButtonWrite
            app.PilotButtonWrite = uibutton(app.PilotGrid, 'push');
            app.PilotButtonWrite.Enable = 'off';
            app.PilotButtonWrite.Layout.Row = 10;
            app.PilotButtonWrite.Layout.Column = 1;
            app.PilotButtonWrite.Text = '写入';

            % Create PilotButtonRead
            app.PilotButtonRead = uibutton(app.PilotGrid, 'push');
            app.PilotButtonRead.ButtonPushedFcn = createCallbackFcn(app, @PilotButtonReadPushed, true);
            app.PilotButtonRead.Layout.Row = 10;
            app.PilotButtonRead.Layout.Column = 2;
            app.PilotButtonRead.Text = '读取';

            % Create PilotSysID
            app.PilotSysID = uieditfield(app.PilotGrid, 'numeric');
            app.PilotSysID.Limits = [0 Inf];
            app.PilotSysID.Layout.Row = 1;
            app.PilotSysID.Layout.Column = 2;

            % Create PilotSysIDLabel
            app.PilotSysIDLabel = uilabel(app.PilotGrid);
            app.PilotSysIDLabel.Layout.Row = 1;
            app.PilotSysIDLabel.Layout.Column = 1;
            app.PilotSysIDLabel.Text = 'SYSID_THISMAV';

            % Create PilotWPRad
            app.PilotWPRad = uieditfield(app.PilotGrid, 'numeric');
            app.PilotWPRad.Limits = [0 Inf];
            app.PilotWPRad.Layout.Row = 2;
            app.PilotWPRad.Layout.Column = 2;

            % Create PilotWPRadLabel
            app.PilotWPRadLabel = uilabel(app.PilotGrid);
            app.PilotWPRadLabel.Layout.Row = 2;
            app.PilotWPRadLabel.Layout.Column = 1;
            app.PilotWPRadLabel.Text = 'WP_RADIUS';

            % Create PilotLoiterRad
            app.PilotLoiterRad = uieditfield(app.PilotGrid, 'numeric');
            app.PilotLoiterRad.Limits = [0 Inf];
            app.PilotLoiterRad.Layout.Row = 3;
            app.PilotLoiterRad.Layout.Column = 2;

            % Create PilotLoiterRadLabel
            app.PilotLoiterRadLabel = uilabel(app.PilotGrid);
            app.PilotLoiterRadLabel.Layout.Row = 3;
            app.PilotLoiterRadLabel.Layout.Column = 1;
            app.PilotLoiterRadLabel.Text = 'WP_LOITER_RAD';

            % Create PilotRTLRad
            app.PilotRTLRad = uieditfield(app.PilotGrid, 'numeric');
            app.PilotRTLRad.Limits = [0 Inf];
            app.PilotRTLRad.Layout.Row = 4;
            app.PilotRTLRad.Layout.Column = 2;

            % Create PilotRTLRadLabel
            app.PilotRTLRadLabel = uilabel(app.PilotGrid);
            app.PilotRTLRadLabel.Layout.Row = 4;
            app.PilotRTLRadLabel.Layout.Column = 1;
            app.PilotRTLRadLabel.Text = 'RTL_RADIUS';

            % Create PilotAirspdWork
            app.PilotAirspdWork = uieditfield(app.PilotGrid, 'numeric');
            app.PilotAirspdWork.Limits = [0 Inf];
            app.PilotAirspdWork.Layout.Row = 5;
            app.PilotAirspdWork.Layout.Column = 2;

            % Create PilotAirspdWorkLabel
            app.PilotAirspdWorkLabel = uilabel(app.PilotGrid);
            app.PilotAirspdWorkLabel.Layout.Row = 5;
            app.PilotAirspdWorkLabel.Layout.Column = 1;
            app.PilotAirspdWorkLabel.Text = 'AIRSPEED_CRUISE';

            % Create PilotAirspdMin
            app.PilotAirspdMin = uieditfield(app.PilotGrid, 'numeric');
            app.PilotAirspdMin.Limits = [0 Inf];
            app.PilotAirspdMin.Layout.Row = 6;
            app.PilotAirspdMin.Layout.Column = 2;

            % Create PilotAirspdMinLabel
            app.PilotAirspdMinLabel = uilabel(app.PilotGrid);
            app.PilotAirspdMinLabel.Layout.Row = 6;
            app.PilotAirspdMinLabel.Layout.Column = 1;
            app.PilotAirspdMinLabel.Text = 'AIRSPEED_MIN';

            % Create PilotAirspdMax
            app.PilotAirspdMax = uieditfield(app.PilotGrid, 'numeric');
            app.PilotAirspdMax.Limits = [0 Inf];
            app.PilotAirspdMax.Layout.Row = 7;
            app.PilotAirspdMax.Layout.Column = 2;

            % Create PilotAirspdMaxLabel
            app.PilotAirspdMaxLabel = uilabel(app.PilotGrid);
            app.PilotAirspdMaxLabel.Layout.Row = 7;
            app.PilotAirspdMaxLabel.Layout.Column = 1;
            app.PilotAirspdMaxLabel.Text = 'AIRSPEED_MAX';

            % Create PilotTkoffAlt
            app.PilotTkoffAlt = uieditfield(app.PilotGrid, 'numeric');
            app.PilotTkoffAlt.Limits = [0 Inf];
            app.PilotTkoffAlt.Layout.Row = 8;
            app.PilotTkoffAlt.Layout.Column = 2;

            % Create PilotTkoffAltLabel
            app.PilotTkoffAltLabel = uilabel(app.PilotGrid);
            app.PilotTkoffAltLabel.Layout.Row = 8;
            app.PilotTkoffAltLabel.Layout.Column = 1;
            app.PilotTkoffAltLabel.Text = 'TKOFF_ALT';

            % Create PilotRTLAlt
            app.PilotRTLAlt = uieditfield(app.PilotGrid, 'numeric');
            app.PilotRTLAlt.Limits = [0 Inf];
            app.PilotRTLAlt.Layout.Row = 9;
            app.PilotRTLAlt.Layout.Column = 2;

            % Create PilotRTLAltLabel
            app.PilotRTLAltLabel = uilabel(app.PilotGrid);
            app.PilotRTLAltLabel.Layout.Row = 9;
            app.PilotRTLAltLabel.Layout.Column = 1;
            app.PilotRTLAltLabel.Text = 'RTL_ALTITUDE';

            % Create NetworkPanel
            app.NetworkPanel = uipanel(app.TabSetting);
            app.NetworkPanel.Title = '网络IP';
            app.NetworkPanel.Position = [369 652 160 119];

            % Create NetworkGrid
            app.NetworkGrid = uigridlayout(app.NetworkPanel);
            app.NetworkGrid.ColumnWidth = {29, '1x'};
            app.NetworkGrid.RowHeight = {22, 22, 22};
            app.NetworkGrid.ColumnSpacing = 9.66666666666667;
            app.NetworkGrid.RowSpacing = 7.83333396911621;
            app.NetworkGrid.Padding = [9.66666666666667 7.83333396911621 9.66666666666667 7.83333396911621];

            % Create IPLabel_1
            app.IPLabel_1 = uilabel(app.NetworkGrid);
            app.IPLabel_1.HorizontalAlignment = 'right';
            app.IPLabel_1.Layout.Row = 1;
            app.IPLabel_1.Layout.Column = 1;
            app.IPLabel_1.Text = '本地';

            % Create IP_1
            app.IP_1 = uieditfield(app.NetworkGrid, 'text');
            app.IP_1.Layout.Row = 1;
            app.IP_1.Layout.Column = 2;
            app.IP_1.Value = '127.0.0.1';

            % Create IPLabel_2
            app.IPLabel_2 = uilabel(app.NetworkGrid);
            app.IPLabel_2.HorizontalAlignment = 'right';
            app.IPLabel_2.Layout.Row = 2;
            app.IPLabel_2.Layout.Column = 1;
            app.IPLabel_2.Text = '虚拟';

            % Create IP_2
            app.IP_2 = uieditfield(app.NetworkGrid, 'text');
            app.IP_2.Layout.Row = 2;
            app.IP_2.Layout.Column = 2;
            app.IP_2.Value = '192.168.80.1';

            % Create IPLabel_3
            app.IPLabel_3 = uilabel(app.NetworkGrid);
            app.IPLabel_3.HorizontalAlignment = 'right';
            app.IPLabel_3.Layout.Row = 3;
            app.IPLabel_3.Layout.Column = 1;
            app.IPLabel_3.Text = '实验';

            % Create IP_3
            app.IP_3 = uieditfield(app.NetworkGrid, 'text');
            app.IP_3.Layout.Row = 3;
            app.IP_3.Layout.Column = 2;
            app.IP_3.Value = '192.168.17.188';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = HGC_r1_0

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end