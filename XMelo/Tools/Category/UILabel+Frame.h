//
//  UILabel+Frame.h
//  YiWeiZD
//
//  Created by X.Melody on 2017/5/6.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Frame)


///根据当前条件重设label高度
- (void)updateHeight;
- (void)updateHeightMargin:(CGFloat)margin;

///根据当前条件重设label宽度
- (void)updateWidth;
- (void)updateWidthMargin:(CGFloat)margin;


///修改label部分文字大小
- (void)changeFont:(UIFont *)font range:(NSRange)range;
- (void)changeFont:(UIFont *)font string:(NSString *)string;
- (void)changeFont:(UIFont *)font string:(NSString *)string repetition:(BOOL)isRepetition;

///修改label部分文字颜色
- (void)changeColor:(UIColor *)color range:(NSRange)range;
- (void)changeColor:(UIColor *)color string:(NSString *)string;
- (void)changeColor:(UIColor *)color string:(NSString *)string repetition:(BOOL)isRepetition;
@end
