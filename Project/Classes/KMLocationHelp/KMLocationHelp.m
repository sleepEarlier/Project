//
//  KMLocationHelp.m
//  AttributeStringTest
//
//  Created by Kimi.Lin on 16/5/26.
//  Copyright © 2016年 man. All rights reserved.
//

#import "KMLocationHelp.h"
#import <UIKit/UIKit.h>

@interface KMLocationHelp ()<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *manager;
@property (copy, nonatomic) OnSuccess successAction;
@property (copy, nonatomic) OnFail fail;
@property (assign, nonatomic) BOOL shouldDecodeLocation;
@end

@implementation KMLocationHelp

- (void)getLocationWithCompletion:(OnSuccess)complete fail:(OnFail)fail decodeLocation:(BOOL)shouldDecode{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusDenied) {
        if (fail) {
            fail([NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:@"User authorize failed.(未取得用户地理位置授权)"}]);
        }
    } else {
        self.shouldDecodeLocation = shouldDecode;
        self.successAction = complete;
        self.fail = fail;
        [self.manager startUpdatingLocation];
    }
}

#pragma mark - CLLoationManaget Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    [manager stopUpdatingLocation];
    
    CLLocation *latestLocation = locations.lastObject;
    if (self.shouldDecodeLocation) {
        
        CLGeocoder *coder = [[CLGeocoder alloc]init];
        [coder reverseGeocodeLocation:latestLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (self.successAction) {
                self.successAction(latestLocation, placemarks);
            }
        }];
    }
    else {
        if (self.successAction) {
            self.successAction(latestLocation,latestLocation);
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [manager stopUpdatingLocation];
    self.fail(error);
}

#pragma mark - Help

#pragma mark - Lazy load
- (CLLocationManager *)manager {
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
        _manager.distanceFilter = kCLDistanceFilterNone;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.delegate = self;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {
                [_manager requestWhenInUseAuthorization];
                [_manager requestAlwaysAuthorization];
            }
        }
    }
    return _manager;
}
@end
/*
 从 CLLocationManager 取出来的经纬度放到 mapView 上显示，是错误的!
 从 CLLocationManager 取出来的经纬度去 Google Maps API 做逆地址解析，当然是错的！
 从 MKMapView 取出来的经纬度去 Google Maps API 做逆地址解析终于对了。去百度地图API做逆地址解析，依旧是错的！
 从上面两处取的经纬度放到百度地图上显示都是错的！错的！的！
 
 分为 地球坐标，火星坐标（iOS mapView 高德 ， 国内google ,搜搜、阿里云 都是火星坐标），百度坐标(百度地图数据主要都是四维图新提供的)
 
 火星坐标: MKMapView
 地球坐标: CLLocationManager
 
 
 API                坐标系
 百度地图API         百度坐标
 腾讯搜搜地图API      火星坐标
 搜狐搜狗地图API      搜狗坐标
 阿里云地图API       火星坐标
 图吧MapBar地图API   图吧坐标
 高德MapABC地图API   火星坐标
 灵图51ditu地图API   火星坐标
 
 */


@implementation CLLocation (translate)

void transform_earth_from_mars(double lat, double lng, double* tarLat, double* tarLng);
void transform_mars_from_baidu(double lat, double lng, double* tarLat, double* tarLng);
void transform_baidu_from_mars(double lat, double lng, double* tarLat, double* tarLng);

- (CLLocation*)locationMarsFromEarth
{
    double lat = 0.0;
    double lng = 0.0;
    transform_earth_from_mars(self.coordinate.latitude, self.coordinate.longitude, &lat, &lng);
    return [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat, lng)
                                         altitude:self.altitude
                               horizontalAccuracy:self.horizontalAccuracy
                                 verticalAccuracy:self.verticalAccuracy
                                           course:self.course
                                            speed:self.speed
                                        timestamp:self.timestamp];
}

- (CLLocation*)locationEarthFromMars
{
    // 二分法查纠偏文件
    // http://xcodev.com/131.html
    return nil;
}

- (CLLocation*)locationBaiduFromMars
{
    if ([self outOfChina]) {
        return self;
    }
    double lat = 0.0;
    double lng = 0.0;
    transform_mars_from_baidu(self.coordinate.latitude, self.coordinate.longitude, &lat, &lng);
    return [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat, lng)
                                         altitude:self.altitude
                               horizontalAccuracy:self.horizontalAccuracy
                                 verticalAccuracy:self.verticalAccuracy
                                           course:self.course
                                            speed:self.speed
                                        timestamp:self.timestamp];
}

- (CLLocation*)locationMarsFromBaidu
{
    if ([self outOfChina]) {
        return self;
    }
    double lat = 0.0;
    double lng = 0.0;
    transform_baidu_from_mars(self.coordinate.latitude, self.coordinate.longitude, &lat, &lng);
    return [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat, lng)
                                         altitude:self.altitude
                               horizontalAccuracy:self.horizontalAccuracy
                                 verticalAccuracy:self.verticalAccuracy
                                           course:self.course
                                            speed:self.speed
                                        timestamp:self.timestamp];
}

- (BOOL)outOfChina {
    if (self.coordinate.longitude < 72.004 || self.coordinate.longitude > 137.8347) {
        return YES;
    }
    if (self.coordinate.latitude < 0.8293 || self.coordinate.latitude > 55.8271) {
        return YES;
    }
    return NO;
}


@end



// --- transform_earth_from_mars ---
// 参考来源：https://on4wp7.codeplex.com/SourceControl/changeset/view/21483#353936
// Krasovsky 1940
//
// a = 6378245.0, 1/f = 298.3
// b = a * (1 - f)
// ee = (a^2 - b^2) / a^2;
const double a = 6378245.0;
const double ee = 0.00669342162296594323;

bool transform_sino_out_china(double lat, double lon)
{
    if (lon < 72.004 || lon > 137.8347)
        return true;
    if (lat < 0.8293 || lat > 55.8271)
        return true;
    return false;
}

double transform_earth_from_mars_lat(double x, double y)
{
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}

double transform_earth_from_mars_lng(double x, double y)
{
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return ret;
}

void transform_earth_from_mars(double lat, double lng, double* tarLat, double* tarLng)
{
    if (transform_sino_out_china(lat, lng))
    {
        *tarLat = lat;
        *tarLng = lng;
        return;
    }
    double dLat = transform_earth_from_mars_lat(lng - 105.0, lat - 35.0);
    double dLon = transform_earth_from_mars_lng(lng - 105.0, lat - 35.0);
    double radLat = lat / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * M_PI);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * M_PI);
    *tarLat = lat + dLat;
    *tarLng = lng + dLon;
}

// --- transform_earth_from_mars end ---
// --- transform_mars_vs_bear_paw ---
// 参考来源：http://blog.woodbunny.com/post-68.html
const double x_pi = M_PI * 3000.0 / 180.0;

void transform_mars_from_baidu(double gg_lat, double gg_lon, double *bd_lat, double *bd_lon)
{
    double x = gg_lon, y = gg_lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    *bd_lon = z * cos(theta) + 0.0065;
    *bd_lat = z * sin(theta) + 0.006;
}

void transform_baidu_from_mars(double bd_lat, double bd_lon, double *gg_lat, double *gg_lon)
{
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    *gg_lon = z * cos(theta);
    *gg_lat = z * sin(theta);
}




