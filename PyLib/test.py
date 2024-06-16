from apm_vehicle import Plane
a = Plane("192.168.80.1:12551")
# print(a.wait_home_GPS())
# print(a.wait_curr_GPS())

# print("\nPrint all parameters (iterate `vehicle.parameters`):")
# for key, value in a.vehicle.parameters.items():
#     print(" Key:%s Value:%s" % (key,value))

# for i in range(0,10):
#     j = a.set_waypoint_cmds(i,100+i*100,100-i*100,-60,0,16,200,0)
#     print('%d+1=%d' % (i,j))
    
# a.clear_waypoint()
# a.upload_waypoint()

count,next = a.get_waypoint()
for i in range(1,count+1):
    print(a.get_waypoint(i))
a.close()