//
//  KMLocationHelp.h
//  AttributeStringTest
//
//  Created by Kimi.Lin on 16/5/26.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^OnSuccess)(CLLocation *location, id result);
typedef void(^OnFail)(NSError *error);
@interface KMLocationHelp : NSObject

/**
 *  start to get user location
 *
 *  @param complete callback on success with Eearth Coordinate location (获取成功回调, 参数location为地球坐标)
 *  @param fail callback on fail with a error infomation (失败回调，提供错误信息)
 *  @param shouldDecode should decode CLLocation to CLPlacemarks, if so result is @[<CLPlacemark *>], else a CLLocation object.(是否将地理位置反编译成地点信息)
 */
- (void)getLocationWithCompletion:(OnSuccess)complete fail:(OnFail)fail decodeLocation:(BOOL)shouldDecode;

@end


@interface CLLocation (translate)
/// Earth coordinate to Mars coordinate (从地图坐标转化到火星坐标)
- (CLLocation*)locationMarsFromEarth;

/// Mars coordinate to Baidu map coordinate (从火星坐标转化到百度坐标)
- (CLLocation*)locationBaiduFromMars;

/// Baidu map coordinate to Mars coordinate (从百度坐标到火星坐标)
- (CLLocation*)locationMarsFromBaidu;

/// is location out of china (是否在中国区域外)
- (BOOL)outOfChina;

@end
