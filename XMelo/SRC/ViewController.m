//
//  ViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ViewController.h"
#import "XListViewController.h"




#import "DictModel.h"
#import <MJExtension/MJExtension.h>

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = kColorIceBlue1;//[UIColor randomColor];
	
	
	@kWeakSelf;
	
//	BOOL isGoList = YES;
	BOOL isGoList = NO;

	if (isGoList) {
		
		[self.view addTap:^(UIGestureRecognizer *tap) {
			
			[selfWeak goPresentViewController];
		}];
	} else {
		
		[selfWeak functionForTest];
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
	
//	[NSUserDefaults saveValue:@"112" withKey:@"name"];
	
	
	UIImage *theImage = [UIImage imageNamed:@"wish_top"];
	
	UIImage *shadowImage = [theImage imageAddShadowColor:[UIColor whiteColor] offset:CGSizeMake(10, 5) blur:15];
	
	
	
	UIImageView *theView = [[UIImageView alloc]init];
	
	theView.image = shadowImage;
	[self.view addSubview:theView];
	
	
	[theView mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.center.equalTo(self.view);
		make.size.mas_offset(CGSizeMake(300, 180));
	}];
	
	[self.view layoutIfNeeded];
	
//	NSArray *array = @[(__bridge id)[UIColor blackColor].CGColor,
//					   //						   (__bridge id)[UIColor yellowColor].CGColor,
//					   (__bridge id)[UIColor redColor].CGColor];
//
//
//	CAGradientLayer *layer 	= [[CAGradientLayer alloc] init];
//	layer.frame 			= theView.bounds;
//	layer.colors 			= array;
//
//	[layer setStartPoint:CGPointMake(0, 0)];
//	[layer setEndPoint:CGPointMake(1, 1)];
//	[theView.layer addSublayer:layer];
	
	// 0.1秒后获取frame， 设置为0秒也可以获取，具体参考链接
//	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//
//	});


	
//	[UIView addRradualColorFor:theView colors:array showType:YVRradualColorShowTypeLBottomToRTop];
}


@end
