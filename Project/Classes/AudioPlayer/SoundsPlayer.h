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
 *  play background music, repeated (播放背景音乐，重复)
 *
 *  @param path file path (文件路径)
 */
+ (void)playBackgroundMusicOfPath:(NSString*)path repeat:(BOOL)isRepeat;

/**
 *  play sound effect, not repeated (播放音效，不重复)
 *
 *  @param path file path (文件路径)
 */
+ (void)playEffectMusicOfPath:(NSString*)path;


/**
 *  stop play background music (停止播放背景音乐)
 */
+ (void)stopBackgroundMusic;

/**
 *  get singleton (获取单例)
 */
+ (instancetype)shareInstance;

@end
