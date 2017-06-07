//
//  UIImage+kmExt.m
//  Project
//
//  Created by kimiLin on 2016/11/25.
//  Copyright © 2016年 kimiLin. All rights reserved.
//

#import "UIImage+KMExtension.h"

@implementation UIImage (KMExtension)

+ (UIImage *) km_resizeImageWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:@"Image"];
    CGFloat wid = image.size.width * 0.5;
    CGFloat hei = image.size.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(hei, wid, hei, wid)];
}

+ (UIImage *) km_imageWithColor:(UIColor *)color
{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


+ (instancetype)km_screenshotImageWithStatusBar:(BOOL)containStatusBar {
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    CGRect bounds = window.bounds;
    
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, YES, [UIScreen mainScreen].scale);
    
    [window drawViewHierarchyInRect:bounds afterScreenUpdates:YES];
    
    if (containStatusBar) {
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"];
        [statusBar drawViewHierarchyInRect:CGRectMake(0, 0, bounds.size.width, 20) afterScreenUpdates:YES];
    }
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
        image = [self rotateUIInterfaceOrientationImage:image];
    }
    return image;
}

#pragma mark - Helper
+(UIImage *)rotateUIInterfaceOrientationImage:(UIImage *)image{
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (orientation) {
        case UIInterfaceOrientationLandscapeRight:
        {
            image = [UIImage imageWithCGImage:image.CGImage scale:1 orientation:UIImageOrientationLeft];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
            image = [UIImage imageWithCGImage:image.CGImage scale:1 orientation:UIImageOrientationRight];
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            image = [UIImage imageWithCGImage:image.CGImage scale:1 orientation:UIImageOrientationDown];
        }
            break;
        case UIInterfaceOrientationPortrait:
        {
            image = [UIImage imageWithCGImage:image.CGImage scale:1 orientation:UIImageOrientationUp];
        }
            break;
        default:
            break;
    }
    
    return image;
}

@end
