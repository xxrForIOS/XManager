//
//  UINavigationBar+ThemeColor.m
//  XMelo
//
//  Created by melo on 2018/1/3.
//  Copyright © 2018年 欣欣然. All rights reserved.
//

#import "UINavigationBar+ThemeColor.h"

@implementation UINavigationBar (ThemeColor)

- (void)configThemeColor {
	
	UIColor *tmColor = kColorThemeOrange;
	UIColor *ttColor = [UIColor whiteColor];
	UINavigationBar *navigation = self;
	UIImage *colorImage = [UIImage imageWithColor:tmColor size:CGSizeMake(kScreenWidth, 64)];
	[navigation setBackgroundImage:colorImage forBarMetrics:UIBarMetricsDefault];
	[navigation setTintColor:ttColor];
	[navigation setBarTintColor:ttColor];
	[navigation setShadowImage:[[UIImage alloc]init]];
	[navigation setTitleTextAttributes:@{NSForegroundColorAttributeName: ttColor,
										 NSFontAttributeName:kFontTheme(17)}];
}


- (void)configThemeColor:(UIColor *)themeColor textColor:(UIColor *)textColor {
	
	UIColor *tmColor = themeColor;
	UIColor *ttColor = textColor;
	UINavigationBar *navigation = self;
	UIImage *colorImage = [UIImage imageWithColor:tmColor size:CGSizeMake(kScreenWidth, 64)];
	[navigation setBackgroundImage:colorImage forBarMetrics:UIBarMetricsDefault];
	[navigation setTintColor:ttColor];
	[navigation setBarTintColor:ttColor];
	[navigation setShadowImage:[[UIImage alloc]init]];
	[navigation setTitleTextAttributes:@{NSForegroundColorAttributeName: ttColor,
										 NSFontAttributeName:kFontTheme(17)}];
}


@end
