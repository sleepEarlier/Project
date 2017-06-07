//
//  UIView+kmExt.m
//  Project
//
//  Created by kimiLin on 2016/11/25.
//  Copyright © 2016年 kimiLin. All rights reserved.
//

#import "UIView+KMExtension.h"

@implementation UIView (KMExtension)

-(CGFloat)km_x{
    return self.frame.origin.x;
}



-(void)setKm_x:(CGFloat)x{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(x, r.origin.y, r.size.width, r.size.height)];
}

-(CGFloat)km_y{
    return self.frame.origin.y;
}

-(void)setKm_y:(CGFloat)y{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(r.origin.x, y, r.size.width, r.size.height)];
}

-(CGFloat)km_width{
    return self.frame.size.width;
}

-(void)setKm_width:(CGFloat)width{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(r.origin.x, r.origin.y, width, r.size.height)];
}

-(CGFloat)km_height{
    return self.frame.size.height;
}

-(void)setKm_height:(CGFloat)height{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(r.origin.x, r.origin.y, r.size.width, height)];
}

-(CGFloat)km_top{
    return self.frame.origin.y;
}

-(void)setKm_top:(CGFloat)top{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(r.origin.x, top, r.size.width, r.size.height)];
}

-(CGFloat)km_bottom{
    return CGRectGetMaxY(self.frame);
}

-(void)setKm_bottom:(CGFloat)bottom{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(r.origin.x, bottom-r.size.height, r.size.width, r.size.height)];
}

-(CGFloat)km_left{
    return self.frame.origin.x;
}

- (void)setKm_left:(CGFloat)left
{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(left,r.origin.y, r.size.width, r.size.height)];
}

-(CGFloat)km_right{
    return CGRectGetMaxX(self.frame);
}

-(void)setKm_right:(CGFloat)right
{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(right-r.size.width,r.origin.y, r.size.width, r.size.height)];
}

- (CGPoint)km_origin { return self.frame.origin; }

- (void)setKm_origin:(CGPoint)km_origin {
    CGRect r = self.frame;
    self.frame = (CGRect){km_origin, r.size};
}

- (CGSize)km_size { return self.bounds.size; }

- (void)setKm_size:(CGSize)km_size {
    CGRect r = self.frame;
    self.frame = (CGRect){r.origin, km_size};
}

- (UIImage *) km_captureImage
{
    UIGraphicsBeginImageContextWithOptions(self.km_size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *renderImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return renderImage;
}

-(void)km_removeAllSubviews{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}



@end




@implementation CALayer (KMExtension)

-(CGFloat)km_x{
    return self.frame.origin.x;
}



-(void)setKm_x:(CGFloat)x{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(x, r.origin.y, r.size.width, r.size.height)];
}

-(CGFloat)km_y{
    return self.frame.origin.y;
}

-(void)setKm_y:(CGFloat)y{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(r.origin.x, y, r.size.width, r.size.height)];
}

-(CGFloat)km_width{
    return self.frame.size.width;
}

-(void)setKm_width:(CGFloat)width{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(r.origin.x, r.origin.y, width, r.size.height)];
}

-(CGFloat)km_height{
    return self.frame.size.height;
}

-(void)setKm_height:(CGFloat)height{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(r.origin.x, r.origin.y, r.size.width, height)];
}

-(CGFloat)km_top{
    return self.frame.origin.y;
}

-(void)setKm_top:(CGFloat)top{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(r.origin.x, top, r.size.width, r.size.height)];
}

-(CGFloat)km_bottom{
    return CGRectGetMaxY(self.frame);
}

-(void)setKm_bottom:(CGFloat)bottom{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(r.origin.x, bottom-r.size.height, r.size.width, r.size.height)];
}

-(CGFloat)km_left{
    return self.frame.origin.x;
}

- (void)setKm_left:(CGFloat)left
{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(left,r.origin.y, r.size.width, r.size.height)];
}

-(CGFloat)km_right{
    return CGRectGetMaxX(self.frame);
}

-(void)setKm_right:(CGFloat)right
{
    CGRect r = self.frame;
    [self setFrame:CGRectMake(right-r.size.width,r.origin.y, r.size.width, r.size.height)];
}

- (CGPoint)km_origin { return self.frame.origin; }

- (void)setKm_origin:(CGPoint)km_origin {
    CGRect r = self.frame;
    self.frame = (CGRect){km_origin, r.size};
}

- (CGSize)km_size { return self.bounds.size; }

- (void)setKm_size:(CGSize)km_size {
    CGRect r = self.frame;
    self.frame = (CGRect){r.origin, km_size};
}

- (void)setKm_centerX:(CGFloat)km_centerX {
    CGRect frame = self.frame;
    frame.origin.x = km_centerX - self.km_width * 0.5;
    self.frame = frame;
}

- (CGFloat)km_centerX {
    return self.km_left + self.km_width * 0.5;
}

- (void)setKm_centerY:(CGFloat)km_centerY {
    CGRect frame = self.frame;
    frame.origin.y = km_centerY - self.km_height * 0.5;
    self.frame = frame;
}

- (CGFloat)km_centerY {
    return self.km_top + self.km_height * 0.5;
}

@end
