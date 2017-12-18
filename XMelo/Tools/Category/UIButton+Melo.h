//
//  UIButton+Melo.h
//  XMelo
//
//  Created by X.Melo on 2017/11/8.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kClickIntervalDefa 1//默认时间间隔

@interface UIButton (Melo)

///设置button的点击间隔 默认为1 不需要间隔设置0.001之类就可以
@property(nonatomic, assign) NSTimeInterval 	timeInterval;
@property(nonatomic, assign) BOOL 				isIgnoreEvent;
@property(nonatomic, assign) UIEdgeInsets 		clickScope;

- (void)addClick:(void(^)(UIButton *sender))clickBlock;
@end
