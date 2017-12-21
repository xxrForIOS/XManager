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


@end
