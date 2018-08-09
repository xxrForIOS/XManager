//
//  UIScreen+SafeArea.h
//  XMelo
//
//  Created by melo on 2017/11/15.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (SafeArea)

/**
 安全区域尺寸
 */
- (CGSize) safeArea;

/**
 导航高度
 */
- (CGFloat) navHeight;

/**
 底部工具条高度
 */
- (CGFloat) toolBarHeight;

/**
 屏幕物理尺寸宽度
 */
- (CGFloat) width;

/**
 屏幕物理尺寸高度
 */
- (CGFloat) height;

/**
 屏幕物理尺寸
 */
- (CGSize) size;

/**
 适配 iPhone X和其他设备约束
 */
CGFloat setIphoneXSize(CGFloat iphonex , CGFloat iPhoneOhter);
@end
