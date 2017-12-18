//
//  UIButton+Melo.m
//  XMelo
//
//  Created by X.Melo on 2017/11/8.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "UIButton+Melo.h"

@implementation UIButton (Melo)

#pragma mark- 点击间隔
- (void)setTimeInterval:(NSTimeInterval)timeInterval{
	
	objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)timeInterval{
	
	return[objc_getAssociatedObject(self,_cmd)doubleValue];
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
	
	objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isIgnoreEvent{
	
	return[objc_getAssociatedObject(self,_cmd)boolValue];
}

+ (void)load{

	//http://www.jianshu.com/p/3c94e8cd21ab
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{

		SEL selA = @selector(sendAction:to:forEvent:);
		SEL selB = @selector(mySendAction:to:forEvent:);

		Method methodA = class_getInstanceMethod(self, selA);
		Method methodB = class_getInstanceMethod(self, selB);

		//将methodB的实现添加到系统方法中也就是说将methodA方法指针添加成方法methodB的返回值表示是否添加成功
		BOOL isAdd = class_addMethod(self,
									 selA,
									 method_getImplementation(methodB),
									 method_getTypeEncoding(methodB));

		//添加成功了说明本类中不存在methodB所以此时必须将方法b的实现指针换成方法A的，否则b方法将没有实现。
		if(isAdd) {

			class_replaceMethod(self,
								selB,
								method_getImplementation(methodA),
								method_getTypeEncoding(methodA));
		}else{

			//添加失败了说明本类中有methodB的实现，此时只需要将methodA和methodB的IMP互换一下即可。
			method_exchangeImplementations(methodA, methodB);
		}
	});
}

- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent*)event{
	
	if([NSStringFromClass(self.class)isEqualToString:@"UIButton"]) {
	
		self.timeInterval = self.timeInterval == 0 ? kClickIntervalDefa : self.timeInterval;
		if(self.isIgnoreEvent){
			
			return;
		} else if (self.timeInterval > 0){
			
			[self performSelector:@selector(resetState)
					   withObject:nil
					   afterDelay:self.timeInterval];
		}
	}

	//此处methodA和methodB方法IMP互换了，实际上执行sendAction；所以不会死循环
	self.isIgnoreEvent = YES;
	[self mySendAction:action to:target forEvent:event];
}

- (void)resetState{
	
	[self setIsIgnoreEvent:NO];
}






#pragma mark- 点击范围
- (void)setClickScope:(UIEdgeInsets)clickScope {
	
	NSValue *cScope = [NSValue valueWithUIEdgeInsets:clickScope];
	objc_setAssociatedObject(self, @selector(clickScope), cScope, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)clickScope {
	
	return[objc_getAssociatedObject(self,_cmd)UIEdgeInsetsValue];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
	if (UIEdgeInsetsEqualToEdgeInsets(self.clickScope, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
		return [super pointInside:point withEvent:event];
	}
	
	CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.clickScope);
	
	return CGRectContainsPoint(hitFrame, point);
}


#pragma mark- 点击block
- (void)addClick:(void(^)(UIButton *sender))clickBlock {
	
	[[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:clickBlock];
}

@end
