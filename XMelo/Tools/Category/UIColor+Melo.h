//
//  UIColor+Melo.h
//  XMelo
//
//  Created by melo on 2017/12/20.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Melo)

///生成一个随机色
+ (UIColor *)randomColor;

///16进制颜色转化
+ (UIColor *)colorWithHexString:(NSString *)string;

@end
