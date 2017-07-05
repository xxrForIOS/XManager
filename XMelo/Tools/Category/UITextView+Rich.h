//
//  UITextView+Rich.h
//  YiWeiZD
//
//  Created by X.Melo on 2017/5/18.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Rich)


- (void)updateWidthMargin:(CGFloat)margin;


- (void)updateHeighMargin:(CGFloat)margin;


- (void)changeFont:(UIFont *)font withRange:(NSRange)range;
- (void)changeFont:(UIFont *)font withString:(NSString *)string isRepetition:(BOOL)isRe;
- (void)changeColor:(UIColor *)color withRange:(NSRange)range;
- (void)changeColor:(UIColor *)color withString:(NSString *)string isRepetition:(BOOL)isRe;
@end
