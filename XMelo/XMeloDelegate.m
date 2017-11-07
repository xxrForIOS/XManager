//
//  XMeloDelegate.m
//  XMelo
//
//  Created by X.Melo on 2017/10/18.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XMeloDelegate.h"
#import "IQKeyboardManager.h"
#import "XHead.h"

@implementation XMeloDelegate

+ (void)load {

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{

		[[self class] setIQKeyboardManager];

		[[self class] setNavigationBar];

		[[self class] setCrashLog];
	});
}

///MARK:- 处理键盘遮盖
+ (void)setIQKeyboardManager {

	IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
	manager.enable = YES;
	manager.shouldResignOnTouchOutside = YES;
	manager.shouldToolbarUsesTextFieldTintColor = YES;
	manager.toolbarDoneBarButtonItemText = @"完成";
	manager.enableAutoToolbar = YES;
	manager.toolbarManageBehaviour = IQAutoToolbarByTag;
}

///MARK:- 设置导航条
+ (void)setNavigationBar {

	//使用appearence（主题）设置，统一修改所有导航栏样式
//	UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
//	NSDictionary *textAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
//	UIImage *colorImage = [XManager getImageFromColor:kColorThemeOrange withSize:CGSizeMake(kScreenWidth, 64)];
//	[navigationBarAppearance setBackgroundImage:colorImage forBarMetrics:UIBarMetricsDefault];
//	[navigationBarAppearance setTitleTextAttributes:textAttributes];
//	[navigationBarAppearance setTintColor:[UIColor whiteColor]];
//	[navigationBarAppearance setBarTintColor:[UIColor whiteColor]];
//	[navigationBarAppearance setShadowImage:[[UIImage alloc]init]];
//	[[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];//将title 文字的颜色改为透明
//	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

	UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
	UIColor *theMeColor = kColorIceBlue1;//[UIColor blackColor];
	UIImage *colorImage = [XManager getImageFromColor:kColorIceBlue withSize:CGSizeMake(kScreenWidth, 64)];
	[navigationBarAppearance setBackgroundImage:colorImage forBarMetrics:UIBarMetricsDefault];
	[navigationBarAppearance setTintColor:theMeColor];
	[navigationBarAppearance setBarTintColor:theMeColor];
	[navigationBarAppearance setShadowImage:[UIImage new]];
	[navigationBarAppearance setTitleTextAttributes:@{NSForegroundColorAttributeName:theMeColor,
													  NSFontAttributeName:kFontTheme(17)}];

	//使用appearence（主题）设置，统一修改所有导航栏样式

}

///MARK:- bug邮件
void UncaughtExceptionHandler(NSException *exception) {

	NSArray *arr = [exception callStackSymbols];
	NSString *reason = [exception reason];
	NSString *name = [exception name];
	NSString *urlStr = [NSString stringWithFormat:@"mailto://xr_112@163.com?subject=bug报告&body=感谢您的配合!<br><br><br>""错误详情:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@", name,reason,[arr componentsJoinedByString:@"<br>"]];
	NSURL *aUrl = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];

	//NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[[UIApplication sharedApplication] openURL:aUrl];

	//或者直接用代码，输入这个崩溃信息，以便在console中进一步分析错误原因
	NSLog(@"1heqin, CRASH: %@", exception);
	NSLog(@"heqin, Stack Trace: %@", [exception callStackSymbols]);
}

+ (void)setCrashLog {

	NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}
@end
