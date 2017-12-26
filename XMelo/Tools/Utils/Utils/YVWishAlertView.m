//
//  YVWishAlertView.m
//  YVPinRoot
//
//  Created by melo on 2017/12/25.
//  Copyright © 2017年 大兵布莱恩特. All rights reserved.
//

#import "YVWishAlertView.h"

@interface YVWishAlertView()

@property (nonatomic,strong) UIImageView 			*alertView;
@property (nonatomic,strong) UIButton	 			*leftButton;
@property (nonatomic,strong) UIButton	 			*rightButton;

@end

@implementation YVWishAlertView

- (instancetype)initWithType:(YVWishErrorType)type{
	
	YVLog(@"show type %lu",(unsigned long)type);
	self = [self init];
	if (self) {
		
		@kWeakSelf;
		UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
		self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
		[rootWindow addSubview:self];
		
		[self mas_makeConstraints:^(MASConstraintMaker *make) {
			
			make.left.top.right.bottom.offset(0);
		}];
		
		self.alertView 			= [[UIImageView alloc] init];
		NSString *name 			= kStringFormat(@"wish_alert_%lu",type - 1017);
		self.alertView.image 	= kImageName(@"%@", name);
		self.alertView.contentMode 				= UIViewContentModeScaleAspectFit;
		self.alertView.userInteractionEnabled 	= YES;
		[self addSubview:self.alertView];
		
		[self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
			
			make.center.equalTo(selfWeak);
			make.size.mas_offset(CGSizeMake(276, 260));
		}];
		
		[self.alertView addTap:^(UIGestureRecognizer *tap) {
			
			[selfWeak removeFromSuperview];
		}];

		
		self.leftButton = ({
			
			UIButton *theButton 			= [UIButton buttonWithType:UIButtonTypeCustom];
			theButton.layer.cornerRadius 	= 40/2;
			theButton.layer.borderColor 	= [UIColor lightGrayColor].CGColor;
			theButton.layer.borderWidth 	= 0.25;
			theButton.backgroundColor 		= [UIColor whiteColor];
			theButton.layer.shadowColor 	= [UIColor blackColor].CGColor;
			theButton.layer.shadowOffset 	= CGSizeMake(0, 3);
			theButton.layer.shadowOpacity 	= 0.75;
			theButton.layer.shadowRadius 	= 3;
			theButton.titleLabel.font 		= kFontTheme(14);
			[theButton setTitleColor:kColorThemeRed forState:UIControlStateNormal];
			[self.alertView addSubview:theButton];
			theButton;
		});
		
		self.rightButton = ({
			
			UIButton *theButton 			= [UIButton buttonWithType:UIButtonTypeCustom];
			theButton.layer.cornerRadius 	= 40/2;
			theButton.layer.borderColor 	= [UIColor whiteColor].CGColor;
			theButton.layer.borderWidth 	= 1;
			theButton.layer.masksToBounds 	= YES;
			theButton.backgroundColor 		= [UIColor randomColor];
			[self.alertView addSubview:theButton];
			theButton;
		});
		
		[self.leftButton setTitle:@"哦 知道了" forState:UIControlStateNormal];
		if (type == YVWishErrorTypeNeedSend) {
			
			[self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
				
				make.centerX.equalTo(selfWeak.alertView);
				make.bottom.offset(-30);
				make.left.offset(40);
				make.right.offset(-40);
				make.height.offset(40);
			}];
		} else {
			
			CGFloat space = 40;
			CGFloat theWidth = (276 - 40 * 2 - 10)/2;
			[self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
				
				make.bottom.offset(-30);
				make.left.offset(space);
				make.width.mas_offset(theWidth);
				make.height.mas_equalTo(@40);
			}];
			
			[self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {

				make.bottom.offset(-30);
				make.left.equalTo(selfWeak.leftButton.mas_right).offset(10);
				make.right.offset(-40);
				make.width.mas_offset(theWidth);
				make.height.mas_equalTo(@40);
			}];
			
			[self.rightButton setTitle:@"发布心愿" forState:UIControlStateNormal];
			if (type == YVWishErrorTypeNeedTypeTwo) {
				
				[self.rightButton setTitle:@"发布祝福" forState:UIControlStateNormal];
			}
		}
		
		return self;
	}
	return self;
}

- (void)showAlertView{
	UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
	[rootWindow addSubview:self];
	
	self.alertView.layer.position = self.center;
	self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
	[UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
		
		self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
	} completion:nil];
}

@end
