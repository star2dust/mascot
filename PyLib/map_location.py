import math
import numpy as np
from dronekit import LocationGlobalRelative

class LocationProjection:

    def __init__(self, ref_lat=39.965112616395785, ref_lon=116.32218749213817) -> None:
         self.CONSTANTS_RADIUS_OF_EARTH = 6371000.     # meters (m) 6378137.0
         self.ref_lat, self.ref_lon = ref_lat, ref_lon # BIT playground

    def GPStoXYwithRef(self, lat, lon, ref_lat, ref_lon):
            # input GPS and Reference GPS in degrees
            # output XY in meters (m) X:North Y:East
            if (abs(lat-ref_lat)<0.00000001)&(abs(lon-ref_lon)<0.00000001):
                x = 0
                y = 0
            else:
                lat_rad = math.radians(lat)
                lon_rad = math.radians(lon)
                ref_lat_rad = math.radians(ref_lat)
                ref_lon_rad = math.radians(ref_lon)

                sin_lat = math.sin(lat_rad)
                cos_lat = math.cos(lat_rad)
                ref_sin_lat = math.sin(ref_lat_rad)
                ref_cos_lat = math.cos(ref_lat_rad)

                cos_d_lon = math.cos(lon_rad - ref_lon_rad)

                arg = np.clip(ref_sin_lat * sin_lat + ref_cos_lat * cos_lat * cos_d_lon, -1.0, 1.0)
                c = math.acos(arg)

                k = 1.0
                if abs(c) > 0:
                    k = (c / math.sin(c))

                x = float(k * (ref_cos_lat * sin_lat - ref_sin_lat * cos_lat * cos_d_lon) * self.CONSTANTS_RADIUS_OF_EARTH)
                y = float(k * cos_lat * math.sin(lon_rad - ref_lon_rad) * self.CONSTANTS_RADIUS_OF_EARTH)

            return x, y
    
    def GPStoXY(self, lat, lon):
         return self.GPStoXYwithRef(lat, lon, self.ref_lat, self.ref_lon)

    def XYtoGPSwithRef(self, x, y, ref_lat, ref_lon):
            # input XY and Reference GPS in degrees
            # output GPS in degrees (deg)
            if (abs(x)<0.001)&(abs(y)<0.001):
                 lat = ref_lat
                 lon = ref_lon
            else:
                x_rad = float(x) / self.CONSTANTS_RADIUS_OF_EARTH
                y_rad = float(y) / self.CONSTANTS_RADIUS_OF_EARTH
                c = math.sqrt(x_rad * x_rad + y_rad * y_rad)

                ref_lat_rad = math.radians(ref_lat)
                ref_lon_rad = math.radians(ref_lon)

                ref_sin_lat = math.sin(ref_lat_rad)
                ref_cos_lat = math.cos(ref_lat_rad)

                if abs(c) > 0:
                    sin_c = math.sin(c)
                    cos_c = math.cos(c)

                    lat_rad = math.asin(cos_c * ref_sin_lat + (x_rad * sin_c * ref_cos_lat) / c)
                    lon_rad = (ref_lon_rad + math.atan2(y_rad * sin_c, c * ref_cos_lat * cos_c - x_rad * ref_sin_lat * sin_c))

                    lat = math.degrees(lat_rad)
                    lon = math.degrees(lon_rad)

                else:
                    lat = math.degrees(ref_lat)
                    lon = math.degrees(ref_lon)

            return lat, lon
    
    def XYtoGPS(self, x, y):
         return self.XYtoGPSwithRef(x, y, self.ref_lat, self.ref_lon)

    def GPSOffsetMeters(self, dNorth, dEast, dDown, point=LocationGlobalRelative(0,0,0)):
        """
        Returns a LocationGlobal object containing the latitude/longitude `dNorth` and `dEast` metres from the
        specified `home_location`. The returned Location has the same `alt` value
        as `home_location`.
        The function is useful when you want to move the vehicle around specifying locations relative to
        the current vehicle position.
        The algorithm is relatively accurate over small distances (10m within 1km) except close to the poles.
        For more information see:
        http://gis.stackexchange.com/questions/2951/algorithm-for-offsetting-a-latitude-longitude-by-some-amount-of-meters
        """
        earth_radius=self.CONSTANTS_RADIUS_OF_EARTH # Radius of "spherical" earth
        # Default point is map origin
        if point.lat*point.lon==0:
             point = LocationGlobalRelative(self.ref_lat,self.ref_lon,0)
        # Coordinate offsets in radians
        dLat = dNorth/earth_radius
        dLon = dEast/(earth_radius*math.cos(math.pi*point.lat/180))
        # New position in decimal degrees
        newlat = point.lat + (dLat * 180/math.pi)
        newlon = point.lon + (dLon * 180/math.pi)
        return LocationGlobalRelative(newlat, newlon, point.alt-dDown)