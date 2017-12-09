//
//  ViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ViewController.h"
#import "XListViewController.h"

@interface ViewController () 


@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor whiteColor];
	
	UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
	theButton.frame = CGRectMake(100, 40, 100, 100);
	theButton.backgroundColor = [UIColor redColor];
	[theButton addClick:^(UIButton *sender) {
		
		YVLog(@"xxx getclick");
	}];
	theButton.clickScope 			= UIEdgeInsetsMake(-20, 0, -20, 0);
	[self.view addSubview:theButton];
	
	UILabel *theLabel 	= [[UILabel alloc]init];
	theLabel.text 		= @"xjibaljxjibaljibalbaljibaluanxuanxriibaluanxuanxri";
	theLabel.font 		= kFontTheme(14);
	theLabel.textColor 	= [UIColor blackColor];
	theLabel.backgroundColor 	= [UIColor cyanColor];
	theLabel.numberOfLines 		= 0;
	[self.view addSubview:theLabel];
	
	[theLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.left.offset(20);
		make.top.offset(500);
		make.right.offset(-20);
//		make.width.lessThanOrEqualTo(theLabel.superview);
	}];
	
	@kWeakObj(theLabel);
	[theLabel addTap:^(UIGestureRecognizer *tap) {

		NSString *str = [NSString randomString:(arc4random()%10 + 1)];
		YVLog(@"  %@",str);
//		theLabelWeak.text = str;
		UILabel *label = (UILabel *)tap.view;
//		label.text = str;
		((UILabel *)tap.view).text = str;
	}];
	
//	[theLabel changeSize:XRLabelChangeTypeWidth maxValue:kScreenWidth - 40 marginSpace:10];
//	[theLabel changeSize:XRLabelChangeTypeHeight marginSpace:0];
//	[theLabel resizeWithType:XRLabelSizeTypeWidth marginSpace:0];
	
//	[theLabel reSetSizeWithType:XRLabelSizeTypeHeight marginSpace:200];
	[theLabel reSetValueWithType:XRLabelValueTypeColor value:[UIColor redColor] range:[theLabel getRangeOf:@"ji"]];
	
	[theLabel reSetValueWithType:XRLabelValueTypeFont value:kFontTheme(20) range:[theLabel getRangeOf:@"a"]];
	
	
    NSArray *animations = @[@"move", @"alpha", @"fall", @"shake", @"over", @"toTop", @"spring", @"shrink", @"layDonw", @"rote"];
   
	CGFloat width = (kScreenWidth - 20 * 2 - 15 * 4)/5;
    for (int index = 0; index < animations.count; index ++) {

        UIButton *theButton 		= [UIButton buttonWithType:UIButtonTypeCustom];
//        theButton.frame 			= CGRectMake(20 + (theWidth + 10) * (index%4), 200 + (35 + 20) * (index/4), theWidth, 35);
        theButton.layer.borderColor = [UIColor redColor].CGColor;
		theButton.backgroundColor 	= kColorRandom;
		theButton.titleLabel.font 	= kFontTheme(12);
		theButton.tag 				= 100 + index;
        [theButton setTitle:animations[index] 			forState:UIControlStateNormal];
        [theButton setTitleColor:[UIColor blackColor] 	forState:UIControlStateNormal];
//		[theButton changeCorner:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:width/2];
        [self.view addSubview:theButton];
		
//		CGFloat theX = 20 + (theWidth + 10) * (index%4);
//		CGFloat theY = 200 + (35 + 20) * (index/4);
		
		CGFloat theWidth = 20 + (width + 15) * (index % 5);
		CGFloat theHeigh = 200 + (width + 15) * (index / 5);
		[theButton mas_makeConstraints:^(MASConstraintMaker *make) {
			
			make.height.mas_equalTo(width);
			make.width.mas_equalTo(width);
			make.left.mas_equalTo(theWidth);
			make.top.mas_equalTo(theHeigh);
			
		}];
		
		
		[theButton addClick:^(UIButton *sender) {
			
			XListViewController *vcc 	= [[XListViewController alloc]init];
			vcc.type 					= sender.tag - 100 + 1;
			UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vcc];
			[self presentViewController:nav animated:YES completion:nil];
		}];
    }
	
	[self.view addTap:^(UIGestureRecognizer *tap) {
		
	}];
	
//	[self justTesttt];
}

- (void)justTesttt {
	
	
	
	UIView *bgView = [[UIView alloc]init];
	bgView.backgroundColor = [UIColor lightGrayColor];
	[self.view addSubview:bgView];
	
	[bgView mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.top.mas_equalTo(kScreenHeight - 400);
		make.left.mas_equalTo(0);
		make.right.mas_equalTo(0);
		make.height.mas_equalTo(350);
	}];
	
	CGFloat width = (kScreenWidth - 20 * 2 - 15 * 4)/5;
	
	for (int i = 0; i < 17; i++) {
		UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		UIColor *theColor = kColorRandom;
		theButton.backgroundColor = [UIColor whiteColor];
		theButton.layer.cornerRadius = width/2;
		theButton.layer.borderColor = theColor.CGColor;
		theButton.layer.borderWidth = 1;
		[theButton setTitleColor:theColor forState:UIControlStateNormal];
		[theButton setTitle:[NSString stringWithFormat:@"🔥 %D",i] forState:UIControlStateNormal];
		theButton.titleLabel.font = kFontTheme(12);
		theButton.tag = 100 + i;
		[bgView addSubview:theButton];
		
		[theButton addTap:^(UIGestureRecognizer *tap) {
			
		}];
		
		[theButton addClick:^(UIButton *sender) {
			
			
		}];
		
		
		[theButton addClick:^(UIButton *sender) {
			
			UIButton *button = (UIButton *)sender;
//			[YVCoreManager showAlertWith:[NSString stringWithFormat:@"click %ld",button.tag - 100] showIn:self];
		}];
		
		CGFloat theWidth = 20 + (width + 15) * (i % 5);
		CGFloat theHeigh = 20 + (width + 15) * (i / 5);
		[theButton mas_makeConstraints:^(MASConstraintMaker *make) {
			
			make.height.mas_equalTo(width);
			make.width.mas_equalTo(width);
			make.left.mas_equalTo(theWidth);
			make.top.mas_equalTo(theHeigh);
			
		}];
	}

	[self DOSOMETHING:^(BOOL successed, BOOL isAlright) {
		
	}];
}

+ (NSString *)getPayType:(YVServerPayType)type {
	
	if (type < 10) {
		
		return kStringFormat(@"0%lu",(unsigned long)type);
	} else {
		
		return kStringFormat(@"%lu",(unsigned long)type);
	}
}

- (void)DOSOMETHING:(YVHttpBlockBool)str {
	
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
