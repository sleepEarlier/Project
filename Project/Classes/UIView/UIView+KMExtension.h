//
//  UIView+kmExt.h
//  Project
//
//  Created by kimiLin on 2016/11/25.
//  Copyright © 2016年 kimiLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KMExtension)

/// origin.x
@property (nonatomic, assign) CGFloat km_x;

/// origin.y
@property (nonatomic, assign) CGFloat km_y;

/// size.width
@property (nonatomic, assign) CGFloat km_width;

/// size.height
@property (nonatomic, assign) CGFloat km_height;

/// equal to origin.y
@property (nonatomic, assign) CGFloat km_top;

/// maxY of frame
@property (nonatomic, assign) CGFloat km_bottom;

/// equal to origin.x
@property (nonatomic, assign) CGFloat km_left;

/// maxX of frame
@property (nonatomic, assign) CGFloat km_right;

/// frame.origin
@property (nonatomic, assign) CGPoint km_origin;

/// frame.size
@property (nonatomic, assign) CGSize km_size;

/// capture image from self's layer
- (UIImage *) km_captureImage;

/// remove all subviews
-(void)km_removeAllSubviews;

@end


@interface CALayer (KMExtension)

/// frame.origin.x
@property (nonatomic, assign) CGFloat km_x;

/// frame.origin.y
@property (nonatomic, assign) CGFloat km_y;

/// frame.size.width
@property (nonatomic, assign) CGFloat km_width;

/// frame.size.height
@property (nonatomic, assign) CGFloat km_height;

/// equal to y
@property (nonatomic, assign) CGFloat km_top;

/// max y of frame
@property (nonatomic, assign) CGFloat km_bottom;

/// equla to x
@property (nonatomic, assign) CGFloat km_left;

/// max x of frame
@property (nonatomic, assign) CGFloat km_right;

/// frame.origin
@property (nonatomic, assign) CGPoint km_origin;

/// frame.size
@property (nonatomic, assign) CGSize km_size;

/// centerX of frame
@property (nonatomic, assign) CGFloat km_centerX;

/// centerY of frame
@property (nonatomic, assign) CGFloat km_centerY;

@end
