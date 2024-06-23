from apm_vehicle import Plane
a = Plane("192.168.80.1:12551")
print(" Autopilot Firmware version: %s" % a.vehicle.version)
print("   Major version number: %s" % a.vehicle.version.major)
print("   Minor version number: %s" % a.vehicle.version.minor)
print("   Patch version number: %s" % a.vehicle.version.patch)
print("   Release type: %s" % a.vehicle.version.release_type())
print("   Release version: %s" % a.vehicle.version.release_version())
print("   Stable release?: %s" % a.vehicle.version.is_stable())
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

# count,next = a.get_waypoint()
# for i in range(1,count+1):
#     print(a.get_waypoint(i))

print(a.get_waypoint(0))  
a.close()
