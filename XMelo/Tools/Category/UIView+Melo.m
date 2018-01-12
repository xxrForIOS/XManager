//
//  UIView+Frame.m
//  XMelo
//
//  Created by melo on 2017/11/24.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "UIView+Melo.h"

@implementation UIView (Melo)

#pragma mark- frame
- (CGFloat)left {
	
	return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
	
	CGRect frame 	= self.frame;
	frame.origin.x 	= x;
	self.frame 		= frame;
}

- (CGFloat)top {
	
	return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
	
	CGRect frame 	= self.frame;
	frame.origin.y 	= y;
	self.frame 		= frame;
}

- (CGFloat)right {
	
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
	
	CGRect frame 	= self.frame;
	frame.origin.x 	= right - frame.size.width;
	self.frame 		= frame;
}

- (CGFloat)bottom {
	
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
	
	CGRect frame 	= self.frame;
	frame.origin.y 	= bottom - frame.size.height;
	self.frame 		= frame;
}

- (CGFloat)width {
	
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
	
	CGRect frame 		= self.frame;
	frame.size.width 	= width;
	self.frame 			= frame;
}

- (CGFloat)height {
	
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
	
	CGRect frame 		= self.frame;
	frame.size.height 	= height;
	self.frame 			= frame;
}

- (CGFloat)centerX {
	
	return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
	
	self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
	
	return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
	
	self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
	
	return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
	
	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame 	= frame;
}

- (CGSize)size {
	
	return self.frame.size;
}

- (void)setSize:(CGSize)size {
	
	CGRect frame 	= self.frame;
	frame.size 		= size;
	self.frame 		= frame;
}

#pragma mark- 移除view上所有子控件
- (void)removeAllSubviews {
	
	while (self.subviews.count) {
		
		[self.subviews.lastObject removeFromSuperview];
	}
}

#pragma mark-  获取当前view的superView对应的控制器
- (UIViewController *)viewController{
	
	UIResponder *next = [self nextResponder];
	do {
		if ([next isKindOfClass:[UIViewController class]]) {
			
			return (UIViewController *)next;
		}
		next = [next nextResponder];
	} while (next != nil);
	
	return nil;
}

#pragma mark- 切圆角
- (void)changeCorner:(UIRectCorner)corners cornerRadii:(CGFloat)radii {
	
	CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
	maskLayer.frame = self.bounds;
	maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
										   byRoundingCorners:corners
												 cornerRadii:CGSizeMake(radii,radii)].CGPath;
	self.layer.mask = maskLayer;
}


+ (void)addRradualColorFor:(UIView *)theView colors:(NSArray *)colors showType:(YVRradualColorShowType)type {
	
	/*
	 layer.colors = @[(__bridge id)[UIColor redColor].CGColor,
	 (__bridge id)[UIColor yellowColor].CGColor,
	 (__bridge id)[UIColor blueColor].CGColor];
	 */
	CAGradientLayer *layer 	= [[CAGradientLayer alloc] init];
	layer.frame 			= theView.bounds;
	layer.colors 			= colors;
	
	if (type == YVRradualColorShowTypeLeftRight) {
		
		[layer setStartPoint:CGPointMake(0, 0.5)];
		[layer setEndPoint:CGPointMake(1, 0.5)];
	}
	
	if (type == YVRradualColorShowTypeTopBottom) {
		
		[layer setStartPoint:CGPointMake(0.5, 0)];
		[layer setEndPoint:CGPointMake(0.5, 1.0)];
	}
	
	if (type == YVRradualColorShowTypeLTopToRBottom) {
		
		[layer setStartPoint:CGPointMake(0, 0)];
		[layer setEndPoint:CGPointMake(1, 1)];
	}
	
	if (type == YVRradualColorShowTypeLBottomToRTop) {
		
		[layer setStartPoint:CGPointMake(0, 1)];
		[layer setEndPoint:CGPointMake(1, 0)];
	}
	[theView.layer addSublayer:layer];
}

- (void)shake{

	CALayer *viewLayer = self.layer;
	CGPoint position = viewLayer.position;
	CGPoint x = CGPointMake(position.x + 5, position.y);
	CGPoint y = CGPointMake(position.x - 5, position.y);
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
	[animation setFromValue:[NSValue valueWithCGPoint:x]];
	[animation setToValue:[NSValue valueWithCGPoint:y]];
	[animation setAutoreverses:YES];
	[animation setDuration:0.075];
	[animation setRepeatCount:3];
	[viewLayer addAnimation:animation forKey:nil];
}

- (void)addLine {
	
	CAShapeLayer *imaginaryLine = [CAShapeLayer layer];
	imaginaryLine.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
	imaginaryLine.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:0].CGPath;
	imaginaryLine.lineWidth = 1. / [[UIScreen mainScreen] scale];
	imaginaryLine.lineDashPattern = @[@2, @2];
	imaginaryLine.fillColor = [UIColor clearColor].CGColor;
	imaginaryLine.strokeColor = [UIColor grayColor].CGColor;
	[self.layer addSublayer:imaginaryLine];
}

#pragma mark- tap手势
- (void)addTap:(void (^)(UIGestureRecognizer * tap))tapBlock{
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
	[[tap rac_gestureSignal]subscribeNext:tapBlock];
	self.userInteractionEnabled = YES;
	[self addGestureRecognizer:tap];
}


@end
