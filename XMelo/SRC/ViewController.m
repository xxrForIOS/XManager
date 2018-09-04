//
//  ViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ViewController.h"
#import "XListViewController.h"

#import "FontViewController.h"
#import "DictModel.h"
#import <MJExtension/MJExtension.h>
#import "XIBBBViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor randomColor];
	
	NSString *point1 = @"丶";
	NSString *point2 = @"ヽ";
	
	BOOL isSame = [point1 isEqualToString:point2];
	
	@kWeakSelf;
	
	BOOL isGoList = YES;
//	BOOL isGoList = NO;
	
	CGSize safeSize = [[UIScreen mainScreen] safeArea];

	
	UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
	theButton.frame = CGRectMake(20,
								 setIphoneXSize(44, 0), 100,
								 setIphoneXSize(kScreenSize.height - 34 - 44,
												kScreenSize.height));
	theButton.backgroundColor = [UIColor randomColor];
	theButton.timeInterval = 0.001;
	[self.view addSubview:theButton];
	
	[theButton addClick:^(UIButton * _Nullable sender) {
		
		NSLog(@" %D",rand()%10 + 1);
	}];

//
	if (isGoList) {

		self.view.userInteractionEnabled = YES;
		[self.view addTap:^(UIGestureRecognizer *tap) {

			[selfWeak goPresentViewController];
		}];
	} else {

		[self.view addTap:^(UIGestureRecognizer *tap) {

			[selfWeak functionForTest];
		}];
	}
}

- (void)goPresentViewController {
	
	
//	XListViewController *vcc 	= [[XListViewController alloc]init];
	XIBBBViewController *vcc 	= [[XIBBBViewController alloc]init];
	
//	vcc.type 					= rand()%10 + 1;//XRCellAnimationTypeShake;
	UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vcc];
	[self presentViewController:nav animated:YES completion:nil];
}


#pragma mark- test

- (void)functionForTest {

	
	
	NSLog(@"xxxxxx");
	
	
//	Class cls = NSClassFromString(selfWeak.controllers[indexPath.row]);
//	kPush(selfWeak, [[cls alloc] init]);
//	NSClassFromString(selfWeak.controllers[indexPath.row])
//	
//		Class cls = NSClassFromString(@"FontViewController");
//
////	FontViewController *vcc = [[FontViewController alloc]init];
//	kPresent([[cls alloc]init]);
	
//	[self presentViewController:[[cls alloc]init] animated:YES completion:nil];
}


@end
