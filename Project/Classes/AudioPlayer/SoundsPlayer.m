//
//  SoundsPlayer.m
//  PreEducation
//
//  Created by 林杜波 on 15/6/6.
//  Copyright (c) 2015年 w. All rights reserved.
//

#import "SoundsPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface SoundsPlayer ()<AVAudioPlayerDelegate>
@property(nonatomic,strong)AVAudioPlayer * backgroundPlayer;
@property(nonatomic,strong)AVAudioPlayer * effectPlayer;
@end

@implementation SoundsPlayer

+ (instancetype)shareInstance
{
    static SoundsPlayer *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SoundsPlayer alloc]init];
        
        // 后台播放
        AVAudioSession *sesson = [AVAudioSession sharedInstance];
        NSError *categoryError = nil;
        [sesson setCategory:AVAudioSessionCategoryPlayback error:&categoryError];
        if (categoryError) {
            NSLog(@"Set Category Error:%@",categoryError.localizedDescription);
        }
        
        NSError *activeError = nil;
        [sesson setActive:YES error:&activeError];
        if (activeError) {
            NSLog(@"Set Active Error:%@",activeError.localizedDescription);
        }
    });
    return instance;
}

+ (void)playBackgroundMusicOfPath:(NSString *)path repeat:(BOOL)isRepeat
{
    SoundsPlayer *instance = [self shareInstance];
    
    [self stopBackgroundMusic];
    
    if (path.length == 0) return;
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:path ofType:@"mp3"];
    NSURL *fileUrl = [NSURL URLWithString:filePath];
    if (!fileUrl) return;
    
    NSError *error = nil;
    instance.backgroundPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:&error];
    if (!error) {
        
        [instance configPlayer:instance.backgroundPlayer repeat:isRepeat delegate:instance];
        
        if ([instance.backgroundPlayer prepareToPlay]) {
            if ([instance.backgroundPlayer play]) {
                instance.isBGMPlaying = YES;
            }
            
        }
        else
        {
            NSLog(@"Unready to play,retrying in 0.3s");
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)NSEC_PER_SEC * 0.2);
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                if ([instance.backgroundPlayer play]) {
                    instance.isBGMPlaying = YES;
                }
            });
        }
    }
    else
    {
        NSLog(@"initial error:%@",error.localizedDescription);
    }
    
}

+ (void)stopBackgroundMusic
{
    SoundsPlayer *instance = [self shareInstance];
    
    [instance stopBackgroundMusic];
}

- (void)stopBackgroundMusic
{
    if (self.backgroundPlayer) {
        [self.backgroundPlayer stop];
        self.backgroundPlayer.delegate = nil;
        self.backgroundPlayer = nil;
        self.isBGMPlaying = NO;
    }
}

+ (void)playEffectMusicOfPath:(NSString *)path
{
    SoundsPlayer *instace = [self shareInstance];
    if (instace.effectPlayer) {
        [instace.effectPlayer stop];
        instace.effectPlayer.delegate = nil;
        instace.effectPlayer = nil;
    }
    
    if (path.length == 0) return;
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:path ofType:@"mp3"];
    NSURL *fileURL = [NSURL URLWithString:filePath];
    if (!fileURL) return;
    
    
    NSError *error = nil;
    instace.effectPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:&error];
    if (!error) {
        [instace configPlayer:instace.effectPlayer repeat:NO delegate:instace];
        if ([instace.effectPlayer prepareToPlay]) {
            [instace.effectPlayer play];
        }
        else
        {
            NSLog(@"Unready to play,retrying in 0.3s");
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)NSEC_PER_SEC * 0.2);
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                [instace.backgroundPlayer play];
            });
        }
    }
    else
    {
         NSLog(@"initial error:%@",error.localizedDescription);
    }
}

- (void)configPlayer:(AVAudioPlayer*)player repeat:(BOOL)isRepeat delegate:(id<AVAudioPlayerDelegate>)delegate
{
    player.numberOfLoops = isRepeat?-1:0; // 循环播放
    player.volume = 1.; // 音量
    player.rate = 1.; // 速度
    player.enableRate = YES;
    player.delegate = delegate != nil?delegate:nil;
}

#pragma mark - Delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    player.delegate = nil;
    player = nil;
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    player.delegate = nil;
    player = nil;
    NSLog(@"Decode error:%@",error.localizedDescription);
}

// 被中断后继续播放
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags
{
    if (flags == AVAudioSessionInterruptionOptionShouldResume) {
        [player play];
    }
}

@end


















