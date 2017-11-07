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

#import "SignInViewController.h"
#import "ThirdSignViewController.h"

#define kColorThemeOrange   kColorHex(0xfb6b2b)
#define kColorThemeRed      kColorHex(0xfc4c4c)
#define kColorThemeBlack    kColorHex(0x2a2e36)
#define kColorThemeGray     kColorHex(0x959595)
#define kColorThemeBlue     kColorHex(0x2a83fb)
#define kColorThemeLine     kColorHex(0xeaeaea)
@interface ViewController () 


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//	UIView *colorView = [[UIView alloc] init];
//	[colorView setFrame:CGRectMake(10, 190,
//								   self.view.frame.size.width - 20,
//								   35 * 3 + 40 + 10 * 2)];
//	[self.view addSubview:colorView];

//	[XManager addRradualColorFor:colorView colors:@[(id)kColor_chi.CGColor, (id)kColor_dailan.CGColor] showType:YVRradualColorShowTypeBottomToTop];

	for (int index = 0; index < 4; index ++) {

		UIButton *theView = [UIButton buttonWithType:UIButtonTypeCustom];

		theView.frame = CGRectMake(20, 20 + (150 + 10) * index, kScreenWidth - 40, 150);
		[self.view addSubview:theView];
		[theView addBlockWithTouchUpInside:^(UIButton *sender) {

//			[XManager addRradualColorFor:sender
//								  colors:@[(id)kColorRandom.CGColor,
//										   (id)kColorRandom.CGColor]
//								showType:index];

			[self addAnimation:sender];

//			SignInViewController *firstVC = [[SignInViewController alloc] init];
			ThirdSignViewController *firstVC = [[ThirdSignViewController alloc] init];

			UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:firstVC];
			[self presentViewController:nav animated:YES completion:nil];
		}];
		[XManager addRradualColorFor:theView
							  colors:@[(id)kColorThemeRed.CGColor,
									   (id)kColorThemeBlack.CGColor]
							showType:index];
	}
//	CAGradientLayer *gradient = [CAGradientLayer layer];
//	gradient.frame = colorView.bounds;
//	gradient.colors = [NSArray arrayWithObjects:
//					   (id)[UIColor colorWithRed:0 green:143/255.0 blue:234/255.0 alpha:1.0].CGColor,
////					   (id)[UIColor colorWithRed:0 green:173/255.0 blue:234/255.0 alpha:1.0].CGColor,
//					   (id)[UIColor whiteColor].CGColor, nil];
//	[colorView.layer addSublayer:gradient];

//	CAGradientLayer *gradientLayer0 = [[CAGradientLayer alloc] init];
//	gradientLayer0.cornerRadius = 12.5;
//	gradientLayer0.frame = colorView.bounds;
//	gradientLayer0.colors = @[(id)kColor_chi.CGColor,
//							  (id)kColor_dailan.CGColor];
//	gradientLayer0.locations = @[@0.2, @1];
//	[gradientLayer0 setStartPoint:CGPointMake(0, 0.5)];
//	[gradientLayer0 setEndPoint:CGPointMake(1, 0.5)];
//	[colorView.layer addSublayer:gradientLayer0];

	
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
        theButton.frame = CGRectMake(20 + (theWidth + 10) * (index%4),
									 200 + (35 + 20) * (index/4), theWidth, 35);
//        theButton.layer.cornerRadius = theButton.height/2;
        theButton.layer.borderColor = [UIColor redColor].CGColor;
        [theButton setTitle:animations[index] forState:UIControlStateNormal];
        [theButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        theButton.backgroundColor = kColorRandom;
//        theButton.layer.masksToBounds = YES;

		[theButton changeCorner:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:theButton.height/2];
//		theButton.layer.borderWidth = 1;
        theButton.titleLabel.font = kFontTheme(12);
//        [self.view addSubview:theButton];

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

- (void) addAnimation:(UIView *)theView {

	CABasicAnimation *rotationAnimation;
	rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
	rotationAnimation.toValue = @(M_PI * 1);
	rotationAnimation.duration = 1;
	rotationAnimation.cumulative = YES;
//	rotationAnimation.repeatCount = 10
	[theView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

//	theView.userInteractionEnabled = NO;

//	CGAffineTransform transform = CGAffineTransformRotate(theView.transform,M_PI);
//	[UIView beginAnimations:@"rotate" context:nil ];
//	[UIView setAnimationDuration:0.5];
//	[UIView setAnimationDelegate:self];
//	theView.userInteractionEnabled = NO;
//	[theView setTransform:transform];
//	[UIView commitAnimations];

//	[XManager dispatchAfter:1 completion:^{
//
//		theView.userInteractionEnabled = YES;
//	}];
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
