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
	
	NSArray *aa1 = @[];
	NSArray *aa2 = @[@"11"];
	
	if (aa1.count) {
		
		YVLog(@"111  非空");
	} else {
		
		YVLog(@"111 空");
	}
	
	if (aa2.count) {
		
		YVLog(@"222  非空");
	} else {
		
		YVLog(@"222 空");
	}
	
	
	@kTODO("something汉字");
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

        UIButton *theButton 		= [UIButton buttonWithType:UIButtonTypeCustom];
        theButton.frame 			= CGRectMake(20 + (theWidth + 10) * (index%4), 200 + (35 + 20) * (index/4), theWidth, 35);
        theButton.layer.borderColor = [UIColor redColor].CGColor;
		theButton.backgroundColor 	= kColorRandom;
		theButton.titleLabel.font 	= kFontTheme(12);
		theButton.tag 				= 100 + index;
        [theButton setTitle:animations[index] 			forState:UIControlStateNormal];
        [theButton setTitleColor:[UIColor blackColor] 	forState:UIControlStateNormal];
		[theButton changeCorner:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:theButton.height/2];
        [self.view addSubview:theButton];

		[theButton addBlockWithTouchUpInside:^(UIButton *sender) {
			
			XListViewController *vcc 	= [[XListViewController alloc]init];
			vcc.type 					= sender.tag - 100 + 1;
			UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vcc];
//			self.view.window.rootViewController = nav;
			[self presentViewController:nav animated:YES completion:nil];
		}];
    }
}

//MARK:- private
- (void)getBeforTodayDate {
	
	NSDate *currentDate 	= [NSDate date];
	NSCalendar *calendar 	= [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSRange range 			= [calendar rangeOfUnit:NSCalendarUnitDay inUnit: NSCalendarUnitMonth forDate:currentDate];
	
	NSDateFormatter *format=[[NSDateFormatter alloc] init];
	[format setDateFormat:@"yyyy-MM"];
	NSDate *newDate = [NSDate date];//[format dateFromString:dateStr];
	double interval = 0;
	NSDate *beginDate = nil;
	NSDate *endDate = nil;
	//	NSCalendar *calendar = [NSCalendar currentCalendar];
	[calendar setFirstWeekday:2];//设定周一为周首日
	if ([calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate]) {
		
		endDate = [beginDate dateByAddingTimeInterval:interval-1];
	}
	
	for (int index = 0; index < range.length; index ++) {
		
		NSDate *theDate 			= [NSDate dateWithTimeInterval:24*60*60*index sinceDate:beginDate];
		NSTimeInterval timeBetween 	= [currentDate timeIntervalSinceDate:theDate];
		
		if (timeBetween < 0) {
			
			
		} else {
			
			YVLog(@"out of today %@",theDate);
		}
	}
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
