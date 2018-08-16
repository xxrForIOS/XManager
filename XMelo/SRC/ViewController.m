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


@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor randomColor];
	
	
	@kWeakSelf;
	
	BOOL isGoList = YES;
//	BOOL isGoList = NO;

//	[self.view addTap:^(UIGestureRecognizer *tap) {
//
//		NSLog(@"xxxxxx");
//		//			[selfWeak functionForTest];
//	}];
	
	
	UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
	theButton.frame = CGRectMake(20, 200, 100, 100);
	theButton.backgroundColor = [UIColor randomColor];
	[self.view addSubview:theButton];
	[theButton addClick:^(UIButton * _Nullable sender) {
		
		
		self.view.backgroundColor = [UIColor randomColor];
	}];

//
	if (isGoList) {

		self.view.userInteractionEnabled = YES;
		[self.view addTap:^(UIGestureRecognizer *tap) {

			[selfWeak goPresentViewController];
		}];
	} else {

		[self.view addTap:^(UIGestureRecognizer *tap) {

			NSLog(@"xxxxxx");
//			[selfWeak functionForTest];
		}];
	}
}

- (void)goPresentViewController {
	
	XListViewController *vcc 	= [[XListViewController alloc]init];
	vcc.type 					= XRCellAnimationTypeOverTurn;
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
