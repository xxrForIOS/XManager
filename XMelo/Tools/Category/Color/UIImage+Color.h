//
//  UIImage+Color.h
//  XMelo
//
//  Created by melo on 2017/12/21.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/// 颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)aColor;

/// 颜色生成图片 控制大小
+ (UIImage *)imageWithColor:(UIColor *)aColor size:(CGSize)aSize;

/// 给图片添加阴影
- (UIImage *)imageAddShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur;

@end
