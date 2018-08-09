//
//  UIImage+Color.m
//  XMelo
//
//  Created by melo on 2017/12/21.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)aColor size:(CGSize)aSize{
	
	if (aSize.width == 0.0f || aSize.width == 0.0f) {
		
		aSize = CGSizeMake(kScreenWidth, kScreenHeight);
	}
	CGRect rect 			= CGRectMake(0.0f, 0.0f, aSize.width, aSize.height);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context	= UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [aColor CGColor]);
	CGContextFillRect(context, rect);
	UIImage *theImage		= UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return theImage;
}

+ (UIImage *)imageWithColor:(UIColor *)aColor {
	
	return [self imageWithColor:aColor size:[UIScreen mainScreen].bounds.size];
}

- (UIImage *)imageAddShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur{
	
	CGSize border = CGSizeMake(fabs(offset.width) + blur,
							   fabs(offset.height) + blur);
	CGSize size = CGSizeMake(self.size.width + border.width * 2.0f,
							 self.size.height + border.height * 2.0f);
	UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetShadowWithColor(context, offset, blur, color.CGColor);
	[self drawAtPoint:CGPointMake(border.width, border.height)];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

@end
