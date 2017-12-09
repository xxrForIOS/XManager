//
//  UIButton+Melo.m
//  XMelo
//
//  Created by melo on 2017/11/24.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "UIButton+Melo.h"

static char buttonclickScopeKey;

@implementation UIButton (Melo)

- (void)setClickScope:(UIEdgeInsets)clickScope
{
	NSValue *value = [NSValue valueWithUIEdgeInsets:clickScope];
	objc_setAssociatedObject(self, &buttonclickScopeKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// *  UIEdgeInsets insets = {top, left, bottom, right};

- (UIEdgeInsets)clickScope
{
	NSValue * value = objc_getAssociatedObject(self, &buttonclickScopeKey);
	if(value) {
		return [value UIEdgeInsetsValue];
	}
	return UIEdgeInsetsZero;
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
	if (UIEdgeInsetsEqualToEdgeInsets(self.clickScope, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
		return [super pointInside:point withEvent:event];
	}
	
	CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.clickScope);
	
	return CGRectContainsPoint(hitFrame, point);
}

//集成rac点击block
- (void)addClick:(void(^)(UIButton *sender))clickBlock {
	
	[[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:clickBlock];
}

@end
