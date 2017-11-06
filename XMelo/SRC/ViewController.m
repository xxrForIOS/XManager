//
//  ViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ViewController.h"

#import "XListViewController.h"
#import <CoreText/CoreText.h>
#import "NNValidationView.h"

@interface ViewController () 


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
	UIButton * testButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 74, 200, 64)];
//	[testButton setBackgroundColor:[UIColor lightGrayColor]];
	[testButton addTarget:self action:@selector(onButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:testButton];

	CALayer * temp = [CALayer layer];
	temp.frame = CGRectMake(1, 1, testButton.bounds.size.width - 2, testButton.bounds.size.height - 2);
	[temp setBackgroundColor:[UIColor redColor].CGColor];
//	temp.borderColor = [UIColor blackColor].CGColor;
//	temp.borderWidth = 1;

	UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:temp.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(32, 32)];

	CAShapeLayer * mask  = [[CAShapeLayer alloc] initWithLayer:temp];
	mask.path = path.CGPath;
	temp.mask = mask;
	[testButton.layer addSublayer:temp];

//	UIBezierPath * path2 = [UIBezierPath bezierPathWithRoundedRect:testButton.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(4, 4)];
//	CAShapeLayer * mask2  = [[CAShapeLayer alloc] initWithLayer:temp];
//	mask2.path = path2.CGPath;
//	testButton.layer.mask = mask2;

	testButton.layer.masksToBounds = YES;

	
//	kPush(<#pushFrom#>, <#pushTo#>)
    NSArray *animations = @[@"move",
                            @"alpha",
                            @"fall",
                            @"shake",
                            @"over",
                            @"toTop",
                            @"spring",
                            @"shrink",
                            @"layDonw",
                            @"rote"];
   
    CGFloat theWidth = (kScreenWidth - 40 - 10 * 3)/4;
    for (int index = 0; index < animations.count; index ++) {

        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
        theButton.frame = CGRectMake(20 + (theWidth + 10) * (index%4), 200 + (35 + 20) * (index/4), theWidth, 35);
//        theButton.layer.cornerRadius = theButton.height/2;
        theButton.layer.borderColor = [UIColor redColor].CGColor;
        [theButton setTitle:animations[index] forState:UIControlStateNormal];
        [theButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        theButton.backgroundColor = [UIColor whiteColor];
//        theButton.layer.masksToBounds = YES;

		[theButton changeCorner:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:theButton.height/2];
		theButton.layer.borderWidth = 1;
        theButton.titleLabel.font = kFontTheme(12);
        [self.view addSubview:theButton];

		[theButton addBlockWithTouchUpInside:^(UIButton *sender) {

			sender.backgroundColor = kColorRandom;
		}];

//		[[theButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
//
//			XListViewController *vcc = [[XListViewController alloc]init];
//			vcc.animation = x.currentTitle;
//			UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vcc];
//			[self presentViewController:nav animated:YES completion:nil];
//		}];
    }
    
//    NSInteger count = 4;
//    CGFloat imageWidth = kScreenWidth - 12 * 2;
//
//    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 210, kScreenWidth, 200)];
//    scrollView.backgroundColor = [UIColor brownColor];
//    scrollView.contentSize = CGSizeMake(12 + kScreenWidth * count, 200);
//    scrollView.pagingEnabled = YES;
//    [self.view addSubview:scrollView];
//
//    for (int index = 0; index < count; index ++) {
//
//        UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(12 + kScreenWidth * index, 5, imageWidth, 200)];
//        imageView.backgroundColor = kColorRandom;
//        [scrollView addSubview:imageView];
//    }

//    [UIView animateWithDuration:2 animations:^{
//        
//        self.view.backgroundColor = kColor_yuebai;
//    } completion:^(BOOL finished) {
//        
//        [XManager showHUDWithString:@"Oops I Dit It Again" completion:^{
//            
//            [self configRootViewController];
//        }];
//    }];
//    
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
//
//        [self configRootViewController];
//    }]];
}

- (void)configRootViewController {
    
    XListViewController *firstVC = [[XListViewController alloc] init];
	UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:firstVC];
	[self presentViewController:nav animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
