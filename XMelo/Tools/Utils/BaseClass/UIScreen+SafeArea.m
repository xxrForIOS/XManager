//
//  UIScreen+SafeArea.m
//  XMelo
//
//  Created by melo on 2017/11/15.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "UIScreen+SafeArea.h"
#import <objc/runtime.h>

@implementation UIScreen (SafeArea)


/**
 安全区域尺寸
 */
- (CGSize) safeArea {
	
	NSValue *value = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(@"safeArea"));
	if (!value) {

		value = [NSValue valueWithCGSize:kSafeArea()];
		objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(@"safeArea"), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	CGSize size = CGSizeZero;
	[value getValue:&size];
	
	return size;
}
/**
 导航高度
 */
- (CGFloat) navHeight {
	return 44.0f;
}
/**
 底部工具条高度
 */
- (CGFloat) toolBarHeight {
	return 49.0f;
}

/**
 获取iOS设备安全区域尺寸
 */
static inline CGSize kSafeArea() {
	
	CGSize deviceSize    = [UIScreen mainScreen].bounds.size;
	if (CGSizeEqualToSize(deviceSize, CGSizeMake(320.0f, 568.0f))) {
		
		return CGSizeMake(320.0f, 548.0f);
	} else if (CGSizeEqualToSize(deviceSize, CGSizeMake(375.0f, 667.0f))) {
		
		return CGSizeMake(375.0f, 647.0f);
	} else if (CGSizeEqualToSize(deviceSize, CGSizeMake(414.0f, 736.0f))) {
		
		return CGSizeMake(414.0f, 716.0f);
	} else if (CGSizeEqualToSize(deviceSize, CGSizeMake(375.0f, 812.0f))) {
		
		return CGSizeMake(375.0f, 734.0f);
	} else {
		
		return CGSizeMake(320.0f, 460.0f);
	}
	
}

/**
 屏幕物理尺寸宽度
 */
- (CGFloat) width {
	return [UIScreen mainScreen].bounds.size.width;
}

/**
 屏幕物理尺寸高度
 */
- (CGFloat) height {
	return [UIScreen mainScreen].bounds.size.height;
}

/**
 屏幕物理尺寸
 */
- (CGSize) size {
	return [UIScreen mainScreen].bounds.size;
}

/**
 适配 iPhone X和其他设备约束
 */
CGFloat selectConstraint(CGFloat iphonex , CGFloat iPhoneOhter) {
	CGFloat constraint = [UIScreen mainScreen].safeArea.height == 734.0f ? iphonex : iPhoneOhter;
	return constraint;
}
@end
