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
	
	/*
	 * 默认值为1 kClickTimeInterval 宏定义控制
	 * 不需要可设为0.0001即可
	 */
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
	
		self.timeInterval = self.timeInterval == 0 ? kClickTimeInterval : self.timeInterval;
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
	if (UIEdgeInsetsEqualToEdgeInsets(self.clickScope, UIEdgeInsetsZero) ||
		!self.enabled ||
		self.hidden) {
		
		return [super pointInside:point withEvent:event];
	}
	
	CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.clickScope);
	return CGRectContainsPoint(hitFrame, point);
}




#pragma mark- 点击block
- (void)addClick:(void(^_Nonnull)(UIButton * _Nullable sender))clickBlock {

	[[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:clickBlock];
}


#pragma mark- 修改文字图标位置

- (void)changePosition:(XRButtonDrawStyle)style space:(CGFloat)space {
	
	[self setTitle:self.currentTitle forState:UIControlStateNormal];
	[self setImage:self.currentImage forState:UIControlStateNormal];
	
	CGFloat imageWidth = self.imageView.image.size.width;
	CGFloat imageHeight = self.imageView.image.size.height;
	
	CGFloat labelWidth = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height)
														 options:NSStringDrawingUsesLineFragmentOrigin
													  attributes:@{NSFontAttributeName : self.titleLabel.font}
														 context:nil].size.width;
	
	CGFloat labelHeight = [self.currentTitle boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT)
														  options:NSStringDrawingUsesLineFragmentOrigin
													   attributes:@{NSFontAttributeName : self.titleLabel.font}
														  context:nil].size.height;
	
	CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
	CGFloat imageOffsetY = imageHeight / 2 + space / 2;//image中心移动的y距离
	CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
	CGFloat labelOffsetY = labelHeight / 2 + space / 2;//label中心移动的y距离
	
	CGFloat tempWidth = MAX(labelWidth, imageWidth);
	CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
	CGFloat tempHeight = MAX(labelHeight, imageHeight);
	CGFloat changedHeight = labelHeight + imageHeight + space - tempHeight;
	
	switch (style) {
		case XRButtonDrawStyleLeft:
			self.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2, 0, space/2);
			self.titleEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, -space/2);
			self.contentEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, space/2);
			break;
			
		case XRButtonDrawStyleRight:
			self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + space/2, 0, -(labelWidth + space/2));
			self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + space/2), 0, imageWidth + space/2);
			self.contentEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, space/2);
			break;
			
		case XRButtonDrawStyleTop:
			self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
			self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
			self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
			break;
			
		case XRButtonDrawStyleBottom:
			self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
			self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
			self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
			break;
			
		default:
			break;
	}
}


- (void)setBackgroundColor:(UIColor *_Nullable)backgroundColor forState:(UIControlState)state {
	
	if (![backgroundColor isKindOfClass:[UIColor class]]) {
		
		YVLog(@"入参不是UIColor");
		return;
	}
	
	[self setBackgroundImage:[UIImage imageWithColor:backgroundColor size:self.size] forState:state];
}
@end
