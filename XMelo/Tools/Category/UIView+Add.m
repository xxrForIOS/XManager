//
//  UIView+Add.m
//  YiWeiZD
//
//  Created by X.Melo on 2017/5/16.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import "UIView+Add.h"

@implementation UIView (Add)


- (void)setX:(CGFloat)x {
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    
    self.frame = frame;
}

- (CGFloat)y {
    
    return self.frame.origin.y;
}

- (CGFloat)maxX {
    
    return self.x + self.width;
}

- (CGFloat)maxY {
    
    return self.y + self.height;
}

- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    
    return self.center.y;
}

- (void)setWidth:(CGFloat)width {
    
    CGRect frame = self.frame;
    frame.size.width = width;
    
    self.frame = frame;
}

- (CGFloat)width {
    
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    
    CGRect frame = self.frame;
    frame.size.height = height;
    
    self.frame = frame;
}

- (CGFloat)height {
    
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    
    CGRect frame = self.frame;
    frame.size =size;
    self.frame = frame;
}

- (CGSize)size{
    
    return self.frame.size;
}

- (void)setOrign:(CGPoint)orign{
    
    CGRect frame = self.frame;
    frame.origin = orign;
    
    self.frame = frame;
}

- (CGPoint)orign {
    
    return self.frame.origin;
}

- (UIViewController *)viewController{
    
    //获取当前view的superView对应的控制器
    UIResponder *next = [self nextResponder];
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
    
}

- (void)changeCorner:(UIRectCorner)corners cornerRadii:(CGFloat)radii {
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                           byRoundingCorners:corners
                                                 cornerRadii:CGSizeMake(radii,radii)].CGPath;
    self.layer.mask = maskLayer;
}

@end
