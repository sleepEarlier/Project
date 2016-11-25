//
//  UIView+kmExt.h
//  Project
//
//  Created by kimiLin on 2016/11/25.
//  Copyright © 2016年 kimiLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (kmExt)
@property (nonatomic, assign) CGFloat km_x;

@property (nonatomic, assign) CGFloat km_y;

@property (nonatomic, assign) CGFloat km_width;

@property (nonatomic, assign) CGFloat km_height;

@property (nonatomic, assign) CGFloat km_top;

@property (nonatomic, assign) CGFloat km_bottom;

@property (nonatomic, assign) CGFloat km_left;

@property (nonatomic, assign) CGFloat km_right;

@property (nonatomic, assign) CGPoint km_origin;

@property (nonatomic, assign) CGSize km_size;

- (UIImage *) km_captureImage;

-(void)km_removeAllSubviews;

@end
