#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function

from dronekit import connect, VehicleMode, LocationGlobalRelative, Command, LocationGlobal
from pymavlink import mavutil # Needed for command message definitions
from map_location import LocationProjection
import numpy as np
import time
import math

def qtn2rpy(x, y, z, w):
    roll = math.atan2(2 * (w * x + y * z), 1 - 2 * (x * x + y * y))
    sinp = 2 * (w * y - x * z)
    if sinp>=1:
        pitch = math.copysign(math.pi/2, sinp)
    else:
        pitch = math.asin(sinp)
    yaw = math.atan2(2 * (w * z + x * y), 1 - 2 * (z * z + y * y))
    return roll, pitch, yaw

def rpy2qtn(roll, pitch, yaw):
    cy = math.cos(yaw * 0.5)
    sy = math.sin(yaw * 0.5)
    cp = math.cos(pitch * 0.5)
    sp = math.sin(pitch * 0.5)
    cr = math.cos(roll * 0.5)
    sr = math.sin(roll * 0.5)
    w = cy * cp * cr + sy * sp * sr
    x = cy * cp * sr - sy * sp * cr
    y = sy * cp * sr + cy * sp * cr
    z = sy * cp * cr - cy * sp * sr
    return x, y, z, w

def get_yaw_err(yaw_err,deadzone=0.0):
    if (yaw_err>math.pi):
        yaw_err -= math.pi*2
    elif (yaw_err<-math.pi):
        yaw_err += math.pi*2
    elif (abs(yaw_err)<deadzone):
        yaw_err = 0.0
    return yaw_err

class Copter:
    def __init__(self, 
                 connection_string ='127.0.0.1:14551', 
                 uav_name='1copter',
                 alt_work=15.0,
                 alt_err=1.0,
                 alt_min=5.0,
                 speed_max=5.0,
                 acc_max = 1.0,
                 GPS_err=1.0,
                 yaw_err=0.07):# 10 deg
        self.connection_string = connection_string
        self.name = uav_name
        self.alt_work = alt_work
        self.alt_err = alt_err
        self.alt_min = alt_min
        self.speed_max = speed_max
        self.acc_max = acc_max
        self.GPS_err = GPS_err
        self.yaw_err = yaw_err
        self.connect()
        self.init_map_origin_GPS(30.392654222833386,114.33210876882845)

    def connect(self):
        # Connect to the Vehicle
        print('[ %s ] Connect to %s' % (self.name, self.connection_string))
        self.vehicle = connect(self.connection_string, wait_ready=True)
                
    def init_map_origin_GPS(self,ref_lat,ref_lon):
        self.map_origin = LocationProjection(ref_lat,ref_lon)
    
    def get_curr_GPS(self):
        return self.vehicle.location.global_relative_frame.lat, self.vehicle.location.global_relative_frame.lon

    def get_curr_XY(self):
        x,y = self.map_origin.GPStoXY(self.vehicle.location.global_relative_frame.lat, self.vehicle.location.global_relative_frame.lon)
        return x,y
    
    def get_curr_alt(self):
        return self.vehicle.location.global_relative_frame.alt

    def get_curr_qtn(self):
        yaw = self.vehicle.attitude.yaw
        roll = self.vehicle.attitude.roll
        pitch = self.vehicle.attitude.pitch
        return rpy2qtn(roll,pitch,yaw)
    
    def get_curr_RPY(self):
        return self.vehicle.attitude.yaw,self.vehicle.attitude.roll,self.vehicle.attitude.pitch
    
    def get_waypoint(self,i=0):
        cmds = self.vehicle.commands
        # i<=0 更新并输出count,next
        if i<=0:
            cmds.download()
            cmds.wait_ready()
            return cmds.count,cmds.next
        # i>0 输出相应航点信息 cmds[0]-cmds[count-1]
        else:
            if i<=cmds.count:
                return cmds[i-1].command,cmds[i-1].param1,cmds[i-1].param2,cmds[i-1].param3,cmds[i-1].param4,cmds[i-1].x,cmds[i-1].y,cmds[i-1].z
            else:
                return 0
    
    def get_spd_XYZ(self):
        return self.vehicle._vx,self.vehicle._vy,self.vehicle._vz
    
    def get_spd_RPY(self):
        return self.vehicle._rollspeed,self.vehicle._pitchspeed,self.vehicle._yawspeed
    
    def set_mode(self,mode):
        mode_str = self.get_mode()
        if isinstance(mode,int):
            if self.mode_uint2str(mode)!="OTHER" and self.mode_uint2str(mode)!="DISCONN":
                mode_str = self.mode_uint2str(mode)
            else:
                print("[ %s ] Setting mode ID not correct!" % (self.name))
                return -1
        elif isinstance(mode,str):
            if mode!="OTHER" and mode!="DISCONN":
                mode_str = mode
            else:
                print("[ %s ] Setting mode STR not correct!" % (self.name))
                return -1
        else:
            print("[ %s ] Setting mode should be ID or STR!" % (self.name))
        if mode_str != self.get_mode():
            print("[ %s ] Setting %s mode" % (self.name, mode_str))
            self.vehicle.mode = VehicleMode(mode_str)
            time.sleep(0.01)
        else:
            print("[ %s ] Setting same mode" % (self.name))

    def get_mode(self):
        return self.vehicle.mode.name

    def set_map_origin_GPS(self,lat,lon):
        self.map_origin.ref_lat = lat
        self.map_origin.ref_lon = lon

    def get_home_XY(self):
        return self.map_origin.GPStoXY(self.vehicle.home_location.lat,self.vehicle.home_location.lon)

    def get_home_GPS(self):
        return self.vehicle.home_location.lat,self.vehicle.home_location.lon

    def mode_str2uint(self):
        if self.vehicle.mode.name=="DISCONN":    
            return 0
        elif self.vehicle.mode.name=="STABILIZE":    
            return 1
        elif self.vehicle.mode.name=="POSHOLD":
            return 2
        elif self.vehicle.mode.name=="GUIDED":
            return 3
        elif self.vehicle.mode.name=="LAND":
            return 4
        elif self.vehicle.mode.name=="RTL":
            return 5
        elif self.vehicle.mode.name=="AUTO":
            return 6
        elif self.vehicle.mode.name=="BRAKE":
            return 7
        elif self.vehicle.mode.name=="LOITER":
            return 8
        else:
            return 15
        
    def mode_uint2str(self,mode,cn=False):
        if cn:
            if mode==0:    
                return "离线"
            elif mode==1:    
                return "自稳"
            elif mode==2:
                return "定点"
            elif mode==3:
                return "引导"
            elif mode==4:
                return "降落"
            elif mode==5:
                return "返航"
            elif mode==6:
                return "自动"
            elif mode==7:
                return "刹车"
            elif mode==8:
                return "盘旋"
            else:
                return "其他"
        else:
            if mode==0:    
                return "DISCONN"
            elif mode==1:    
                return "STABILIZE"
            elif mode==2:
                return "POSHOLD"
            elif mode==3:
                return "GUIDED"
            elif mode==4:
                return "LAND"
            elif mode==5:
                return "RTL"
            elif mode==6:
                return "AUTO"
            elif mode==7:
                return "BRAKE"
            elif mode==8:
                return "LOITER"
            else:
                return "OTHER"
    
    def arm(self):
        # Copter should arm in GUIDED mode
        self.vehicle.mode = VehicleMode("GUIDED")
        self.vehicle.armed = True  

    def disarm(self):
        # Copter disarm
        self.vehicle.armed = False

    def check_and_arm(self):
        print("[ %s ] Basic pre-arm checks" % self.name)
        # Don't let the user try to arm until autopilot is ready
        while not self.vehicle.is_armable:
            print(" Waiting for vehicle to initialise...")
            time.sleep(1)
            
        print("[ %s ] Arming motors" % self.name)
        # Copter should arm in GUIDED mode
        self.arm()

        while not self.vehicle.armed:      
            print(" Waiting for arming...")
            self.arm()
            time.sleep(1)    

    def check_and_disarm(self):
        print("[ %s ] Disarming motors" % self.name)
        self.disarm()

        while self.vehicle.armed:      
            print(" Waiting for disarming...")
            self.disarm()
            time.sleep(1)  

    def is_guided_armed(self):
        time.sleep(0.01)
        return self.get_mode()=="GUIDED" and self.vehicle.armed    
    
    def set_mode_echo(self,str,count):
        while count and self.get_mode()!=str:
            self.set_mode(str)
            count = count-1
            time.sleep(0.1)
    
    def arm_and_takeoff(self, alt_target=0.0):
        # sometimes need to be armed in guided mode
        while not self.is_guided_armed():
            self.set_mode("GUIDED")
            self.check_and_arm()
        print("[ %s ] Taking off!" % self.name)
        if alt_target<self.alt_min:
            alt_target = self.alt_min
        # Take off to target altitude
        # must be guided and armed
        self.vehicle.simple_takeoff(alt_target) 

    def dist_to_point_XY(self, x_tar_to_home, y_tar_to_home):
        north,east = self.get_curr_XY()
        uavxy = np.array((north,east))
        tarxy = np.array((x_tar_to_home,y_tar_to_home))
        dis_to_pt = np.linalg.norm(uavxy-tarxy)
        return dis_to_pt
    
    def yaw_to_point_XY(self, x_tar_to_home, y_tar_to_home):
        north,east = self.get_curr_XY()
        yaw_pt = math.atan2(y_tar_to_home-east,x_tar_to_home-north)
        return get_yaw_err(self.vehicle.attitude.yaw-yaw_pt)
    
    # def goto_point_XY(self, x_tar_to_home, y_tar_to_home, alt_tar_to_home, flight_time=0, check_reached=False, use_spd=0):
    #     print("[ %s ] LINE to Point (N:%s, E:%s) with alt %sm" % (self.name, x_tar_to_home, y_tar_to_home, alt_tar_to_home))
    #     # LocationGlobalRelative是一个类，它由经纬度(WGS84)和相对于home点的高度组成
    #     if  np.linalg.norm(np.array((x_tar_to_home,y_tar_to_home)))<0.1:
    #         lat_tar, lon_tar = self.map_origin.ref_lat, self.map_origin.ref_lon
    #     else:
    #         print(" Point (N:%s, E:%s) is not home location" % (x_tar_to_home, y_tar_to_home))
    #         lat_tar, lon_tar = self.map_origin.XYtoGPS(x_tar_to_home, y_tar_to_home)
    #     # 根据给定飞行时间，计算航点飞行速度（默认airspeed），按匀加速减速算（加速度默认为1）
    #     dis_to_pt = self.dist_to_point_XY(x_tar_to_home, y_tar_to_home)
    #     if flight_time < math.sqrt(4*dis_to_pt/self.acc_max):
    #         # 给定时间小于最短时间，则以最短时间计算飞行速度
    #         flight_time = math.sqrt(4*dis_to_pt/self.acc_max)
    #     speed = self.speed_max/2
    #     if use_spd:
    #         speed = self.acc_max*(flight_time-math.sqrt(flight_time*flight_time-4*dis_to_pt/self.acc_max))/2
    #         print(" Flight time: %.2f, Groundspeed: %.3f" %(flight_time, speed))
    #     else:
    #         speed = self.acc_max*(flight_time-math.sqrt(flight_time*flight_time-4*dis_to_pt/self.acc_max))/2
    #         print(" Flight time: %.2f, Airspeed: %.3f" %(flight_time, speed))
    #     # 运行goto_point_GPS
    #     self.goto_point_GPS(lat_tar, lon_tar, alt_tar_to_home, speed, use_spd)
    #     # simple_goto函数只发送指令，不判断有没有到达目标航点
    #     # 到达目标航点由航点距离<=GPS_err判定
    #     if check_reached:
    #         pt_not_reached = True
    #         loop = 1
    #         count = 0
    #         while pt_not_reached:
    #             dis_to_pt = self.dist_to_point_XY(x_tar_to_home, y_tar_to_home)
    #             yaw_to_pt = self.yaw_to_point_XY(x_tar_to_home, y_tar_to_home)
    #             print(" Time pass: %.2f, Dist: %.2f, Yaw: %.2f" %(dis_to_pt, yaw_to_pt,count*loop))
    #             pt_not_reached = dis_to_pt>self.GPS_err
    #             count = count+1
    #             time.sleep(loop)
    #         print("[ %s ] Reached target point" % self.name)

    # def goto_point_GPS(self, lat_tar, lon_tar, alt_tar_to_home, speed, use_spd=True):
    #     # vehicle.groundspeed/vehicle.airspeed变量可读可写，且读、写时的含义不同。
    #     # 读取时，为无人机的当前地/空速；写入时，设定无人机在执行航点任务时的默认速度（后设置的为准）
    #     # airspeed优先用，groundspeed有时候无法覆盖航点速度
    #     # 如果设置完groundspeed又设置airspeed，则groundspeed失效，最后默认速度为airspeed
    #     if use_spd:
    #         self.vehicle.groundspeed = speed
    #         print(" Set default groundspeed to %sm/s" % speed)
    #     else:
    #         self.vehicle.airspeed = speed
    #         print(" Set default airspeed to %sm/s" % speed)
    #     # 设置GPS目标点LocationGlobalRelative
    #     # LocationGlobalRelative是一个类，它由经纬度(WGS84)和相对于home点的高度组成
    #     point = LocationGlobalRelative(lat_tar, lon_tar, alt_tar_to_home)
    #     print(" Set GPS point to (lat: %s, lon: %s)" % (lat_tar, lon_tar))
    #     # simple_goto函数将位置发送给无人机，生成一个目标航点
    #     self.vehicle.simple_goto(point)

    def goto_point_XYZ(self, x, y, z, use_spd=0, speed=2.0):
        wp = self.map_origin.GPSOffsetMeters(x,y,z)
        self.goto_point_GPS(wp,speed,use_spd)
    
    def goto_point_GPS(self, point, use_spd=0, speed=2.0):
        # vehicle.groundspeed/vehicle.airspeed变量可读可写，且读、写时的含义不同。
        # 读取时，为无人机的当前地/空速；写入时，设定无人机在执行航点任务时的默认速度（后设置的为准）
        # airspeed优先用，groundspeed有时候无法覆盖航点速度
        # 如果设置完groundspeed又设置airspeed，则groundspeed失效，最后默认速度为airspeed
        self.set_speed(speed, use_spd)
        # 设置GPS目标点LocationGlobalRelative
        # LocationGlobalRelative是一个类，它由经纬度(WGS84)和相对于home点的高度组成
        # point = LocationGlobalRelative(lat_tar, lon_tar, alt_tar_to_home)
        print(" Set GPS point to (lat: %s, lon: %s, alt: %s)" % (point.lat, point.lon, point.alt))
        # simple_goto函数将位置发送给无人机，生成一个目标航点
        if self.get_mode()!="GUIDED":
            self.set_mode("GUIDED")
        self.vehicle.simple_goto(point)

    def set_speed(self,speed,use_spd=1):
        # apm already has spd bound
        if use_spd and speed:
            if use_spd==1:
                self.vehicle.groundspeed = speed
                print(" Set groundspeed to %.1fm/s - curr %.1fm/s" % (speed,self.vehicle.groundspeed))
            else:
                self.vehicle.airspeed = speed
                print(" Set airspeed to %.1fm/s - curr %.1fm/s" % (speed,self.vehicle.airspeed))

    def send_yaw_rate_velocity_global(self, velocity_x, velocity_y, velocity_z, yaw_rate):
        msg = self.vehicle.message_factory.set_position_target_local_ned_encode(
            0,       # time_boot_ms (not used)
            0, 0,    # target system, target component
            mavutil.mavlink.MAV_FRAME_LOCAL_NED, # frame
            0b0000011111000111, # type_mask (only speeds enabled)
            0, 0, 0, # x, y, z positions (not used)
            velocity_x, velocity_y, velocity_z, # x, y, z velocity in m/s
            0, 0, 0, # x, y, z acceleration (not supported yet, ignored in GCS_Mavlink)
            0, yaw_rate)    # yaw, yaw_rate (not supported yet, ignored in GCS_Mavlink) 
        self.vehicle.send_mavlink(msg)

    def send_yaw_rate_velocity(self, velocity_x, velocity_y, velocity_z, yaw_rate):
        yaw = self.vehicle.attitude.yaw
        vx_n = velocity_x*math.cos(yaw)-velocity_y*math.sin(yaw)
        vy_e = velocity_x*math.sin(yaw)+velocity_y*math.cos(yaw)
        msg = self.vehicle.message_factory.set_position_target_local_ned_encode(
            0,       # time_boot_ms (not used)
            0, 0,    # target system, target component
            mavutil.mavlink.MAV_FRAME_LOCAL_NED, # frame
            0b0000011111000111, # type_mask (only speeds enabled)
            0, 0, 0, # x, y, z positions (not used)
            vx_n, vy_e, velocity_z, # x, y, z velocity in m/s
            0, 0, 0, # x, y, z acceleration (not supported yet, ignored in GCS_Mavlink)
            0, yaw_rate)    # yaw, yaw_rate (not supported yet, ignored in GCS_Mavlink) 
        self.vehicle.send_mavlink(msg)


    def circle_round(self, speed, radius, freq, round_num=1):
        # Circle path using speed
        print("[ %s ] CIRCLE with speed %.2fm/s and radius %.2fm" % (self.name, speed, radius))
        # speed>0顺时针，speed<0逆时针
        yaw_rate = speed/radius
        cycle_time = abs(math.ceil(2*math.pi*round_num/yaw_rate))
        print(' Circling %d round, Yaw rate %.2frad/s, Time %.2fs...' % (round_num, yaw_rate, cycle_time))
        # send command to vehicle on 1 Hz
        cycle_not_reached = True
        loop = 1/freq
        count = 0
        while cycle_not_reached:
            if count%(freq*5)==0:
                print(' Time pass: %.2fs, Process: %d/100' % (count*loop, count*loop/cycle_time*100))
            cycle_not_reached = (count+1)*loop<cycle_time
            self.send_yaw_rate_velocity(abs(speed),0,0,yaw_rate)
            count = count+1
            time.sleep(loop)
        print("[ %s ] Finished circle path" % self.name)

    def close(self):
        #Close vehicle object before exiting script
        print("[ %s ] Close vehicle object" % self.name)
        self.vehicle.close()
    
    def cmd_nav_waypoint(self,x,y,z=-15.0,use_gps=False):
        if use_gps:
            # gps: lat,lon,alt
            wp = LocationGlobalRelative(x,y,z)
        else:
            # xyz: north,east,down
            wp = self.map_origin.GPSOffsetMeters(x, y, z)
        cmd = Command(0,0,0, mavutil.mavlink.MAV_FRAME_GLOBAL_RELATIVE_ALT, mavutil.mavlink.MAV_CMD_NAV_WAYPOINT, 0, 1, 0, 0, 0, 0, wp.lat, wp.lon, wp.alt)
        return cmd

    def cmd_nav_return(self,x=0.0,y=0.0,z=0.0,use_gps=False):
        if use_gps:
            # gps: lat,lon,alt
            wp = LocationGlobalRelative(x,y,z)
        else:
            # xyz: north,east,down
            wp = self.map_origin.GPSOffsetMeters(x,y,z)
        cmd = Command(0,0,0, mavutil.mavlink.MAV_FRAME_MISSION, mavutil.mavlink.MAV_CMD_NAV_RETURN_TO_LAUNCH, 0, 1, 0, 0, 0, 0, wp.lat, wp.lon, wp.alt)
        return cmd
    
    def cmd_nav_loiter(self,x,y,z=-15.0,turns=0,rad=10.0,use_gps=False):
        if use_gps:
            # gps: lat,lon,alt
            wp = LocationGlobalRelative(x,y,z)
        else:
            # xyz: north,east,down
            wp = self.map_origin.GPSOffsetMeters(x,y,z)
        if turns:
            cmd = Command(0,0,0, mavutil.mavlink.MAV_FRAME_GLOBAL_RELATIVE_ALT, mavutil.mavlink.MAV_CMD_NAV_LOITER_TURNS, 0, 1, turns, 0, rad, 0, wp.lat, wp.lon, wp.alt)
        else:
            cmd = Command(0,0,0, mavutil.mavlink.MAV_FRAME_GLOBAL_RELATIVE_ALT, mavutil.mavlink.MAV_CMD_NAV_LOITER_UNLIM, 0, 1, 0, 0, rad, 0, wp.lat, wp.lon, wp.alt)
        return cmd


class Plane:
    def __init__(self, 
                 connection_string ='127.0.0.1:14551', 
                 uav_name='1plane',
                 alt_work=60.0,
                 alt_dist=10.0, # 编队时高度差
                 alt_err=1.0,
                 alt_min=30.0,
                 GPS_err=1.0, # 1 m
                 yaw_err=0.07):# 1 deg
        self.connection_string = connection_string
        self.name = uav_name
        self.type, self.id = self.name2typeid()
        self.alt_work = alt_work
        self.alt_dist = alt_dist
        self.alt_err = alt_err
        self.alt_min = alt_min
        self.GPS_err = GPS_err
        self.yaw_err = yaw_err
        self.wp_list = []
        self.connect()
        self.init_map_origin_GPS(30.392654222833386,114.33210876882845)
        # self.vehicle.parameters['SYSID_THISMAV']
        # self.vehicle.parameters['WP_RADIUS']
        # self.vehicle.parameters['WP_LOITER_RAD']
        # self.vehicle.parameters['RTL_RADIUS']
        # self.vehicle.parameters['AIRSPEED_CRUISE']
        # self.vehicle.parameters['AIRSPEED_MIN']
        # self.vehicle.parameters['AIRSPEED_MAX']
        # self.vehicle.parameters['TKOFF_ALT']
        # self.vehicle.parameters['RTL_ALTITUDE']

    def name2typeid(self):
        from itertools import groupby
        ss = [''.join(list(g)) for k, g in groupby(self.name, key=lambda x:x.isdigit())]
        return ss[1], int(ss[0])
    
    def connect(self):
        # Connect to the Vehicle
        self.vehicle = connect(self.connection_string, wait_ready=True)
        print('[ %s ] Connect to %s' % (self.name, self.connection_string))
                
    def init_map_origin_GPS(self,ref_lat,ref_lon):
        self.map_origin = LocationProjection(ref_lat,ref_lon)

    def get_curr_GPS(self):
        return self.vehicle.location.global_relative_frame.lat, self.vehicle.location.global_relative_frame.lon

    def wait_curr_GPS(self):
        count = 20
        while count and (not self.vehicle.location.global_relative_frame):
            time.sleep(0.1)
            count = count-1
            print("[ %s ] Wait for curr GPS..." % (self.name))
        try:
            return self.get_curr_GPS()
        except:
            print("[ %s ] Curr GPS type none" % (self.name))
            return 0

    def get_curr_XY(self):
        x,y = self.map_origin.GPStoXY(self.vehicle.location.global_relative_frame.lat, self.vehicle.location.global_relative_frame.lon)
        return x,y
        
    def get_curr_alt(self):
        return self.vehicle.location.global_relative_frame.alt

    def get_curr_qtn(self):
        yaw = self.vehicle.attitude.yaw
        roll = self.vehicle.attitude.roll
        pitch = self.vehicle.attitude.pitch
        return rpy2qtn(roll,pitch,yaw)
    
    def get_curr_RPY(self):
        return self.vehicle.attitude.yaw,self.vehicle.attitude.roll,self.vehicle.attitude.pitch
    
    def get_waypoint(self,i=0):
        cmds = self.vehicle.commands
        # i<=0 更新并输出count,next
        if i<=0:
            cmds.download()
            cmds.wait_ready()
            return cmds.count,cmds.next
        # i>0 输出相应航点信息 cmds[0]~cmds[count-1]
        else:
            if i<=cmds.count:
                return cmds[i-1].command,cmds[i-1].param1,cmds[i-1].param2,cmds[i-1].param3,cmds[i-1].param4,cmds[i-1].x,cmds[i-1].y,cmds[i-1].z
            else:
                return 0
            
    def get_waypoint_cmds(self):
        cmds = self.vehicle.commands
        cmds.download()
        cmds.wait_ready()
        return cmds
            
    def set_waypoint(self,i=0):
        cmds = self.get_waypoint_cmds()
        cmds.next = i

    def clear_waypoint(self):
        cmds = self.get_waypoint_cmds()
        clear_count = 0
        while not cmds.count==0:
            cmds.clear()
            cmds.upload()
            time.sleep(0.01)
            cmds = self.get_waypoint_cmds()
            clear_count = clear_count+1
            print("[ %s ] Clear all cmds %d times!" % (self.name, clear_count))

    def upload_waypoint(self):
        cmds = self.get_waypoint_cmds()
        upload_count = 0
        while not cmds.count==len(self.wp_list):
            cmds.clear()
            for wp in self.wp_list:
                cmds.add(wp)
            cmds.upload()
            time.sleep(0.01)
            cmds = self.get_waypoint_cmds()
            upload_count = upload_count+1
            print("[ %s ] Upload %d cmds %d times!" % (self.name, len(self.wp_list), upload_count))

    def set_waypoint_alt(self,alt=60.0):
        cmds = self.get_waypoint_cmds()
        self.wp_list = []
        for wp in cmds:
            wp.z = alt
            self.wp_list.append(wp)
        print("[ %s ] Save wp list!" % (self.name))
        count = cmds.count
        while not cmds.count==0:
            cmds.clear()
            cmds.upload()
            time.sleep(0.01)
            cmds = self.get_waypoint_cmds()
        print("[ %s ] Clear cmds!" % (self.name))
        while not cmds.count==count:
            cmds.clear()
            for wp in self.wp_list:
                cmds.add(wp)
            cmds.upload()
            time.sleep(0.01)
            cmds = self.get_waypoint_cmds()
        print("[ %s ] Upload cmds!" % (self.name))

    def set_waypoint_cmds(self,i,x,y,z,use_gps=0,cmd=0,rad=0,turns=0):
        cmds = self.get_waypoint_cmds()
        # if first wp clear wp_list
        # i start from 0
        if i==0:
            self.wp_list = []
        # wp should be added in order 
        if i==len(self.wp_list):
            if i<=cmds.count and cmd==0:
                # only change x,y,z
                if use_gps:
                    # gps: lat,lon,alt
                    wp = LocationGlobalRelative(x,y,z)
                else:
                    # xyz: north,east,down
                    wp = self.map_origin.GPSOffsetMeters(x,y,z)
                cmds[i].x = wp.lat
                cmds[i].y = wp.lon
                cmds[i].z = wp.alt
                self.wp_list.append(cmds[i])
                print("[ %s ] Modify wp %d: [%d,%.1f,%.1f,%.1f,%.1f,%.7f,%.7f,%.1f]!" % (self.name, i+1, cmds[i].command, cmds[i].param1, cmds[i].param2, cmds[i].param3, cmds[i].param4, cmds[i].x, cmds[i].y, cmds[i].z))
            else:
                # add new cmd
                wp_added = 1
                if cmd==16:
                    self.wp_list.append(self.cmd_nav_waypoint(x,y,z,rad,use_gps))
                elif cmd==17 or cmd==18 or cmd==19:
                    self.wp_list.append(self.cmd_nav_loiter(x,y,z,cmd,turns,rad,use_gps))
                elif cmd==20:
                    self.wp_list.append(self.cmd_nav_return(x,y,z,use_gps))
                else:
                    wp_added = 0
                if wp_added==1:
                    print("[ %s ] Add new wp %d: [%d,%.1f,%.1f,%.1f,%.1f,%.7f,%.7f,%.1f]!" % (self.name, i+1, self.wp_list[i].command, self.wp_list[i].param1, self.wp_list[i].param2, self.wp_list[i].param3, self.wp_list[i].param4, self.wp_list[i].x, self.wp_list[i].y, self.wp_list[i].z))
                else:
                    print("[ %s ] Add new wp %d failed!" % (self.name, i+1))
        else:
            print("[ %s ] Next wp should be %d!" % (self.name, len(self.wp_list)+1))
        return len(self.wp_list)
    
    def get_spd_XYZ(self):
        return self.vehicle._vx,self.vehicle._vy,self.vehicle._vz
    
    def get_spd_RPY(self):
        return self.vehicle._rollspeed,self.vehicle._pitchspeed,self.vehicle._yawspeed
    
    def set_mode(self,mode):
        mode_str = self.get_mode()
        if isinstance(mode,int):
            if self.mode_uint2str(mode)!="OTHER" and self.mode_uint2str(mode)!="DISCONN":
                mode_str = self.mode_uint2str(mode)
            else:
                print("[ %s ] Setting mode ID not correct!" % (self.name))
                return 0
        elif isinstance(mode,str):
            if mode!="OTHER" and mode!="DISCONN":
                mode_str = mode
            else:
                print("[ %s ] Setting mode STR not correct!" % (self.name))
                return 0
        else:
            print("[ %s ] Setting mode should be ID or STR!" % (self.name))
            return 0
        if mode_str != self.get_mode():
            print("[ %s ] Setting %s mode" % (self.name, mode_str))
            self.vehicle.mode = VehicleMode(mode_str)
            time.sleep(0.01)
        else:
            print("[ %s ] Setting same mode" % (self.name))
        return 1

    def get_mode(self):
        return self.vehicle.mode.name

    def set_map_origin_GPS(self,lat,lon):
        self.map_origin.ref_lat = lat
        self.map_origin.ref_lon = lon

    def wait_home_GPS(self, use_alt=False):
        count = 20
        while count and (not self.vehicle.home_location):
            time.sleep(0.1)
            count = count-1
            print("[ %s ] Wait for home GPS..." % (self.name))
        try:
            return self.get_home_GPS(use_alt)
        except:
            print("[ %s ] Home GPS type none" % (self.name))
            return 0
    
    def get_home_XY(self):
        return self.map_origin.GPStoXY(self.vehicle.home_location.lat,self.vehicle.home_location.lon)
    
    def get_home_GPS(self, use_alt=False):
        if use_alt:
            return self.vehicle.home_location.lat,self.vehicle.home_location.lon,self.vehicle.home_location.alt
        else:
            return self.vehicle.home_location.lat,self.vehicle.home_location.lon
        
    def mode_str2uint(self):
        if self.vehicle.mode.name=="DISCONN":    
            return 0
        elif self.vehicle.mode.name=="STABILIZE":    
            return 1
        elif self.vehicle.mode.name=="GUIDED":
            return 3
        elif self.vehicle.mode.name=="RTL":
            return 5
        elif self.vehicle.mode.name=="AUTO":
            return 6
        elif self.vehicle.mode.name=="LOITER":
            return 8
        elif self.vehicle.mode.name=="MANUAL":
            return 9
        elif self.vehicle.mode.name=="TAKEOFF":
            return 10
        elif self.vehicle.mode.name=="FBWA":
            return 11
        elif self.vehicle.mode.name=="FBWB":
            return 12
        else:
            return 15
        
    def mode_uint2str(self,mode,cn=False):
        if cn:
            if mode==0:    
                return "离线"
            elif mode==1:    
                return "自稳"
            elif mode==3:
                return "引导"
            elif mode==5:
                return "返航"
            elif mode==6:
                return "自动"
            elif mode==8:
                return "盘旋"
            elif mode==9:
                return "手动"
            elif mode==10:
                return "起飞"
            elif mode==11:
                return "A增稳"
            elif mode==12:
                return "B增稳"
            else:
                return "其他"
        else:
            if mode==0:    
                return "DISCONN"
            elif mode==1:    
                return "STABILIZE"
            elif mode==3:
                return "GUIDED"
            elif mode==5:
                return "RTL"
            elif mode==6:
                return "AUTO"
            elif mode==8:
                return "LOITER"
            elif mode==9:
                return "MANUAL"
            elif mode==10:
                return "TAKEOFF"
            elif mode==11:
                return "FBWA"
            elif mode==12:
                return "FBWB"
            else:
                return "OTHER"
    
    def arm(self):
        # Copter should arm in GUIDED mode
        self.vehicle.mode = VehicleMode("GUIDED")
        self.vehicle.armed = True  

    def disarm(self):
        # Copter disarm
        self.vehicle.armed = False

    def check_and_arm(self):
        print("[ %s ] Basic pre-arm checks" % self.name)
        # Don't let the user try to arm until autopilot is ready
        while not self.vehicle.is_armable:
            print(" Waiting for vehicle to initialise...")
            time.sleep(1)
            
        print("[ %s ] Arming motors" % self.name)
        # Copter should arm in GUIDED mode
        self.arm()

        while not self.vehicle.armed:      
            print(" Waiting for arming...")
            self.arm()
            time.sleep(1)    

    def check_and_disarm(self):
        print("[ %s ] Disarming motors" % self.name)
        self.disarm()

        while self.vehicle.armed:      
            print(" Waiting for disarming...")
            self.disarm()
            time.sleep(1)      
    
    def is_guided_armed(self):
        time.sleep(0.1)
        return self.get_mode()=="GUIDED" and self.vehicle.armed
    
    def set_mode_echo(self,str,count):
        while count and self.get_mode()!=str:
            self.set_mode(str)
            count = count-1
            time.sleep(0.1)

    def arm_and_takeoff(self):
        while not self.is_guided_armed():
            self.set_mode("GUIDED")
            self.check_and_arm()
        print("[ %s ] Taking off!" % self.name)
        self.set_mode_echo("TAKEOFF",10) # Take off to target altitude
        return self.get_mode()=="TAKEOFF" and self.vehicle.armed  

    def dist_to_point_XY(self, x_tar_to_home, y_tar_to_home):
        north,east = self.get_curr_XY()
        uavxy = np.array((north,east))
        tarxy = np.array((x_tar_to_home,y_tar_to_home))
        dis_to_pt = np.linalg.norm(uavxy-tarxy)
        if abs(dis_to_pt)<self.GPS_err:
            dis_to_pt = 0.0
        return dis_to_pt
    
    def yaw_to_point_XY(self, x_tar_to_home, y_tar_to_home):
        north,east = self.get_curr_XY()
        yaw_pt = math.atan2(y_tar_to_home-east,x_tar_to_home-north)
        return get_yaw_err(self.vehicle.attitude.yaw-yaw_pt,self.yaw_err)

    def goto_point_XYZ(self, x, y, z, use_spd=0, speed=25.0):
        wp = self.map_origin.GPSOffsetMeters(x,y,z)
        self.goto_point_GPS(wp,speed,use_spd)
    
    def goto_point_GPS(self, point, use_spd=0, speed=25.0):
        # vehicle.groundspeed/vehicle.airspeed变量可读可写，且读、写时的含义不同。
        # 读取时，为无人机的当前地/空速；写入时，设定无人机在执行航点任务时的默认速度（后设置的为准）
        # airspeed优先用，groundspeed有时候无法覆盖航点速度
        # 如果设置完groundspeed又设置airspeed，则groundspeed失效，最后默认速度为airspeed
        self.set_speed(speed, use_spd)
        # 设置GPS目标点LocationGlobalRelative
        # LocationGlobalRelative是一个类，它由经纬度(WGS84)和相对于home点的高度组成
        # point = LocationGlobalRelative(lat_tar, lon_tar, alt_tar_to_home)
        print(" Set GPS point to (lat: %s, lon: %s, alt: %s)" % (point.lat, point.lon, point.alt))
        # simple_goto函数将位置发送给无人机，生成一个目标航点
        if self.get_mode()!="GUIDED":
            self.set_mode("GUIDED")
        self.vehicle.simple_goto(point)

    def set_speed(self,speed,use_spd=2):
        # apm already has spd bound
        if use_spd and speed:
            if use_spd==1:
                print(" Set groundspeed to %.1fm/s - curr %.1fm/s" % (speed,self.vehicle.groundspeed))
                self.vehicle.groundspeed = speed
            else:
                print(" Set airspeed to %.1fm/s - curr %.1fm/s" % (speed,self.vehicle.airspeed))  
                self.vehicle.airspeed = speed        
            
    def close(self):
        #Close vehicle object before exiting script
        print("[ %s ] Close vehicle object" % self.name)
        self.vehicle.close()

    def cmd_nav_waypoint(self,x,y,z=-60.0,rad=0.0,use_gps=0):
        if not use_gps==0:
            # gps: lat,lon,alt
            wp = LocationGlobalRelative(x,y,z)
        else:
            # xyz: north,east,down
            wp = self.map_origin.GPSOffsetMeters(x, y, z)
        cmd = Command(0,0,0, mavutil.mavlink.MAV_FRAME_GLOBAL_RELATIVE_ALT, mavutil.mavlink.MAV_CMD_NAV_WAYPOINT, 0, 1, 0, rad, 0, 0, wp.lat, wp.lon, wp.alt)
        return cmd

    def cmd_nav_return(self,x=0.0,y=0.0,z=0.0,use_gps=0):
        if not use_gps==0:
            # gps: lat,lon,alt
            wp = LocationGlobalRelative(x,y,z)
        else:
            # xyz: north,east,down
            wp = self.map_origin.GPSOffsetMeters(x,y,z)
        cmd = Command(0,0,0, mavutil.mavlink.MAV_FRAME_MISSION, mavutil.mavlink.MAV_CMD_NAV_RETURN_TO_LAUNCH, 0, 1, 0, 0, 0, 0, wp.lat, wp.lon, wp.alt)
        return cmd
    
    def cmd_nav_loiter(self,x,y,z=-60.0,cmd=17,turns=0,rad=250.0,use_gps=0):
        if not use_gps==0:
            # gps: lat,lon,alt
            wp = LocationGlobalRelative(x,y,z)
        else:
            # xyz: north,east,down
            wp = self.map_origin.GPSOffsetMeters(x,y,z)
        if cmd==18:
            nav = Command(0,0,0, mavutil.mavlink.MAV_FRAME_GLOBAL_RELATIVE_ALT, mavutil.mavlink.MAV_CMD_NAV_LOITER_TURNS, 0, 1, turns, 0, rad, 0, wp.lat, wp.lon, wp.alt)
        elif cmd==17:
            nav = Command(0,0,0, mavutil.mavlink.MAV_FRAME_GLOBAL_RELATIVE_ALT, mavutil.mavlink.MAV_CMD_NAV_LOITER_UNLIM, 0, 1, 0, 0, rad, 0, wp.lat, wp.lon, wp.alt)
        else:
            # 该模式有bug，rad_accept和rad_pass不管怎么设，都是0和1
            # 此外yaw=0代表从中心离开盘旋圆，yaw=1代表从切线离开盘旋圆
            nav = Command(0,0,0, mavutil.mavlink.MAV_FRAME_GLOBAL_RELATIVE_ALT, mavutil.mavlink.MAV_CMD_NAV_LOITER_TIME, 0, 1, turns, 0, rad, 0, wp.lat, wp.lon, wp.alt)
        return nav
