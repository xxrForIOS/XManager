//
//  UIColor+Melo.m
//  XMelo
//
//  Created by melo on 2017/12/20.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "UIColor+Melo.h"

@implementation UIColor (Melo)

+ (UIColor *)randomColor {
	
	UIColor *aColor = [UIColor colorWithRed:arc4random()% 255 / 255.0
									  green:arc4random()% 255 / 255.0
									   blue:arc4random()% 255 / 255.0
									  alpha:1];
	return aColor;
}

+ (UIColor *)xxrandomColor {
	
	CGFloat xxR = (CGFloat)RAND_MAX / random();
	CGFloat xxG = (CGFloat)RAND_MAX / random();
	CGFloat xxB = (CGFloat)RAND_MAX / random();
	
	UIColor *aColor = [UIColor colorWithRed:xxR green:xxG blue:xxB alpha:1];
	return aColor;
}

+ (UIColor *)colorWithHexString:(NSString *)string {
	
	//http://www.jianshu.com/p/79e4dd8a44bc
	NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	NSString *cString = [[string stringByTrimmingCharactersInSet:set] uppercaseString];
	
	if ([cString length] != 6)		return [UIColor clearColor];
	if ([cString hasPrefix:@"0X"]) 	cString = [cString substringFromIndex:2];
	if ([cString hasPrefix:@"#"]) 	cString = [cString substringFromIndex:1];

	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];

	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];

	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	UIColor *aColor = [UIColor colorWithRed:((float) r / 255.0f)
									  green:((float) g / 255.0f)
									   blue:((float) b / 255.0f)
									  alpha:1.0f];
	return aColor;
}


@end
