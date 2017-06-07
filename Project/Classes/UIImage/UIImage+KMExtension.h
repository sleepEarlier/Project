//
//  UIImage+kmExt.h
//  Project
//
//  Created by kimiLin on 2016/11/25.
//  Copyright © 2016年 kimiLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KMExtension)

/// use center part to resize image
+ (instancetype) km_resizeImageWithName:(NSString*)imageName;

/// create image with color
+ (instancetype) km_imageWithColor:(UIColor*)color;

/// create a screenshot image with or without status bar
+ (instancetype)km_screenshotImageWithStatusBar:(BOOL)containStatusBar;

@end
