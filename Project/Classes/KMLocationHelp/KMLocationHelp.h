//
//  KMLocationHelp.h
//  AttributeStringTest
//
//  Created by Kimi.Lin on 16/5/26.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^OnSuccess)(CLLocation *location, NSArray<CLPlacemark *> *placemarks);
typedef void(^OnFail)(NSError *error);
@interface KMLocationHelp : NSObject

/**
 *  开始获取地理位置
 *
 *  @param complete 获取成功回调, 参数location为地球坐标
 *  @param refuse   失败回调，无用户权限时参数Error为nil，获取位置失败时Error有值
 *  @param shouldDecode 是否将地理位置反编译成地点信息
 */
- (void)getLocationWithCompletion:(OnSuccess)complete fail:(OnFail)fail decodeLocation:(BOOL)shouldDecode;

@end


@interface CLLocation (translate)
//从地图坐标转化到火星坐标
- (CLLocation*)locationMarsFromEarth;

//从火星坐标转化到百度坐标
- (CLLocation*)locationBaiduFromMars;

//从百度坐标到火星坐标
- (CLLocation*)locationMarsFromBaidu;

/// 是否在中国区域外
- (BOOL)outOfChina;

@end