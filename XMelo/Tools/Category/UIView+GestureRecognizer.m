//
//  UIView+GestureRecognizer.m
//  XMelo
//
//  Created by X.Melo on 2017/11/9.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "UIView+GestureRecognizer.h"

@implementation UIView (GestureRecognizer)

- (void)addGestureRecognizerTap:(void (^)(UIGestureRecognizer *tap))tapBlock {

	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
	[[tap rac_gestureSignal] subscribeNext:tapBlock];
	[self addGestureRecognizer:tap];
}

- (void)addGestureRecognizer:(UIGestureRecognizer *)gesture gestureRecognizer:(void (^)(UIGestureRecognizer *tap))grBlock {

	[[gesture rac_gestureSignal]subscribeNext:grBlock];
	[self addGestureRecognizer:gesture];
}

@end
