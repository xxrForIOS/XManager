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
#import "YVWishAlertView.h"
#import "DictModel.h"
#ifdef DEBUG
#define SLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define SLog(format, ...)
#endif

#define CLog(format, ...)  NSLog(format, ## __VA_ARGS__)
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
@interface ViewController ()

@property (nonatomic, strong) UICollectionView 	*collectionView;
@property (nonatomic, strong) NSArray 			*idNumbers;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor randomColor];
//	[self buttons];
	[self rongCloud];
}

- (NSString *)idNumberHidden:(NSString *)str {
	
	NSString *string = @"";
	NSRange range = NSMakeRange(10, 4);
	for (int i = 0; i < range.length - 1; i++) {
		
		string = [string stringByAppendingString:@"*"];
	}
	
	NSString *result = [str stringByReplacingCharactersInRange:range withString:string];
	return result;
}

#pragma mark- test
- (void)rongCloud {

	//142326**********54
	for (NSString *idNumer in self.idNumbers) {
		
		BOOL isAlright = [idNumer isIDCardNumber];
		
		if (isAlright) {
			
			YVLog(@"hidden %@",[idNumer idNumberHidden]);
		}
		YVLog(@"number %@",isAlright ? @"正确" : kStringFormat(@"不正确 %@",idNumer));
	}
	
	[self.view addTap:^(UIGestureRecognizer *tap) {
		
		tap.view.backgroundColor = [UIColor randomColor];
	}];
	
	
	
	UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[aButton setBackgroundColor:[UIColor redColor] forState:UIControlStateHighlighted];
	aButton.backgroundColor = [UIColor randomColor];
	[self.view addSubview:aButton];
	aButton.timeInterval = 0.001;
	aButton.clickScope = UIEdgeInsetsMake(100, 200, 200, 200);
	[aButton addClick:^(UIButton * _Nullable sender) {
		
		YVLog(@"xxx getclickkkkkk");
	}];
	[aButton mas_makeConstraints:^(MASConstraintMaker *make) {
		
		//		make.left.equalTo(self.view).offset(150);
		make.left.mas_offset(10);
		make.top.mas_offset(250);
		make.width.and.height.offset(100);
	}];

	UIButton *bButton = [UIButton buttonWithType:UIButtonTypeCustom];
	bButton.timeInterval = 0.001;
	[bButton setBackgroundColor:[UIColor redColor] forState:UIControlStateHighlighted];
	bButton.backgroundColor = [UIColor randomColor];
	[self.view addSubview:bButton];
	[bButton addClick:^(UIButton * _Nullable sender) {
		
		YVLog(@"bbbbbbbbb getclick");
	}];
	
	[bButton mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.left.mas_offset(130);
		make.top.offset(250);
		make.width.and.height.offset(50);
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
		theButton.timeInterval = 2;
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

			YVLog(@"xxxx getClick");
			
//			NSUInteger index = (sender.tag - 100) % 4 + 1017;
//			YVWishAlertView *alert = [[YVWishAlertView alloc]initWithType:index];
//			[alert showAlertView];
			
//			XListViewController *vcc 	= [[XListViewController alloc]init];
//			vcc.type 					= sender.tag - 100 + 1;
//			UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vcc];
//			[self presentViewController:nav animated:YES completion:nil];
		}];
	}
}

- (NSArray *)idNumbers {
	
	if (!_idNumbers) {
		
		_idNumbers = @[@"421121198811193424", @"360702198006218406", @"512111198803045555",
					   @"510401199403318750", @"34122619850901051X", @"540127198908129048"];
	}
	
	return _idNumbers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
