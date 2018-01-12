//
//  UILabel+ChangeValue.h
//  XMelo
//
//  Created by melo on 2018/1/12.
//  Copyright © 2018年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ChangeValue)


//MARK: 改变指定文字字体
- (void)changeTextColor:(UIColor *)aColor range:(NSRange)aRange;

//MARK: 改变指定文字字体颜色
- (void)changeTextFont:(NSFont *)aFont range:(NSRange)aRange;

//MARK: 改变指定文字背景颜色
- (void)changeTextBackGroundColor:(UIColor *)aColor range:(NSRange)aRange;

//MARK: 改变
- (void)changeAttributedText:(NSAttributedStringKey)key value:(id)value range:(NSRange)aRange;
@end
