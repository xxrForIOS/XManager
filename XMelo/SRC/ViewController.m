//
//  ViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ViewController.h"
#import "XListViewController.h"
#import "XRHttpHelper.h"

@interface ViewController ()

@property (nonatomic, strong) UICollectionView 	*collectionView;
@property (nonatomic, strong) NSArray 			*images;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor randomColor];
	[self buttons];
	[self rongCloud];
}

#pragma mark- test
- (void)rongCloud {
	
	[self.view addTap:^(UIGestureRecognizer *tap) {
		
		tap.view.backgroundColor = [UIColor randomColor];
	}];
}


- (void)buttons {
	
	NSArray *animations = @[@"move", @"alpha", @"fall", @"shake", @"over", @"toTop", @"spring", @"shrink", @"layDonw", @"rote"];
	
	CGFloat width = (kScreenWidth - 20 * 2 - 15 * 4)/5;
	for (int index = 0; index < animations.count; index ++) {
		
		UIButton *theButton 		= [UIButton buttonWithType:UIButtonTypeCustom];
		theButton.layer.borderColor = [UIColor redColor].CGColor;
		theButton.backgroundColor 	= kColorRandom;
		theButton.titleLabel.font 	= kFontTheme(12);
		theButton.tag 				= 100 + index;
		[theButton setTitle:animations[index] 				forState:UIControlStateNormal];
		[theButton setTitleColor:[UIColor blackColor] 		forState:UIControlStateNormal];
		[theButton setBackgroundColor:[UIColor randomColor] forState:UIControlStateNormal];
		theButton.clickScope = UIEdgeInsetsMake(0, 10, -20, -20);
		[self.view addSubview:theButton];
		
		CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
		maskLayer.frame = theButton.bounds;
		maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, width)
											   byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight
													 cornerRadii:CGSizeMake(width/4,width/4)].CGPath;
		theButton.layer.mask = maskLayer;
		
		CGFloat theWidth = 20 + (width + 15) * (index % 5);
		CGFloat theHeigh = 300 + (width + 15) * (index / 5);
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
