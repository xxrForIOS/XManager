//
//  UIButton+ClickTimeInterval.h
//  XMelo
//
//  Created by X.Melo on 2017/11/8.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>

#define defaultInterval 1//默认时间间隔

@interface UIButton (ClickTimeInterval)

///设置button的点击间隔 默认为1
@property(nonatomic,assign)NSTimeInterval timeInterval;

///YES不允许点击NO允许点击
@property(nonatomic,assign)BOOL isIgnoreEvent;

@end
