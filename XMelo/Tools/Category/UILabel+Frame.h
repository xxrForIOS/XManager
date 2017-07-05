//
//  UILabel+Frame.h
//  YiWeiZD
//
//  Created by X.Melody on 2017/5/6.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Frame)


/**
 根据当前条件重设label高度
 */
- (void)updateHeigh;
- (void)updateHeighMargin:(CGFloat)margin;
- (void)updateWidth;
- (void)updateWidthMargin:(CGFloat)margin;


/**
 修改部分文字属性
 */
- (void)changeFont:(UIFont *)font withRange:(NSRange)range;
- (void)changeFont:(UIFont *)font withString:(NSString *)string isRepetition:(BOOL)isRe;
- (void)changeColor:(UIColor *)color withRange:(NSRange)range;
- (void)changeColor:(UIColor *)color withString:(NSString *)string isRepetition:(BOOL)isRe;

@end
