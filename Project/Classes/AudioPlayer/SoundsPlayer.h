//
//  SoundsPlayer.h
//  PreEducation
//
//  Created by 林杜波 on 15/6/6.
//  Copyright (c) 2015年 w. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundsPlayer : NSObject
@property(assign,nonatomic)BOOL isBGMPlaying;
/**
 *  播放背景音乐
 *
 *  @param path 文件路径
 */
+ (void)playBackgroundMusicOfPath:(NSString*)path repeat:(BOOL)isRepeat;

/**
 *  播放音效，默认不重复
 *
 *  @param path 文件路径
 */
+ (void)playEffectMusicOfPath:(NSString*)path;


/**
 *  停止播放背景音乐
 */
+ (void)stopBackgroundMusic;

/**
 *  获取单例
 */
+ (instancetype)shareInstance;

@end
