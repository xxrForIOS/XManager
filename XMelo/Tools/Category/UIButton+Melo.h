//
//  UIButton+Melo.h
//  XMelo
//
//  Created by X.Melo on 2017/11/8.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kClickTimeInterval 1

///图片文字显示位置
typedef NS_ENUM(NSInteger, XRButtonDrawStyle) {
	
	///图片左 文字右
	XRButtonDrawStyleLeft    = 0,
	///图片右 文字左
	XRButtonDrawStyleRight   = 1,
	///图片上 文字下
	XRButtonDrawStyleTop     = 2,
	///图片下 文字上
	XRButtonDrawStyleBottom  = 3
};
@interface UIButton (Melo)

//点击间隔 默认为1
@property(nonatomic, assign) NSTimeInterval 	timeInterval;

//YES不允许点击NO允许点击
@property(nonatomic, assign) BOOL 				isIgnoreEvent;

///点击范围
@property(nonatomic, assign) UIEdgeInsets 		clickScope;

///rac添加点击block
- (void)addClick:(void(^_Nonnull)(UIButton * _Nullable sender))clickBlock;

///改变图片文字的位置
- (void)changePosition:(XRButtonDrawStyle)style space:(CGFloat)space;

///设置不同状态下的颜色图片
- (void)setBackgroundColor:(UIColor *_Nullable)backgroundColor forState:(UIControlState)state;

@end
