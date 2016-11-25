//
//  UIImage+kmExt.h
//  Project
//
//  Created by kimiLin on 2016/11/25.
//  Copyright © 2016年 kimiLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (kmExt)
/**根据文件名返回一张新的拉伸后的图片（以图片中部拉伸）*/
+ (UIImage *) km_resizeImageWithName:(NSString*)imageName;

/**根据颜色创建图片*/
+ (UIImage *) km_imageWithColor:(UIColor*)color;

/**屏幕截图*/
+ (instancetype)km_screenShowImageWithStatusBar:(BOOL)containStatusBar;
@end
