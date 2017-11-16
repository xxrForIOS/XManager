//
//  XInputViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/8/26.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XInputViewController.h"
#import "UITextView+ZWLimitCounter.h"
#import "UITextView+ZWPlaceHolder.h"

@interface XInputViewController ()

@property (nonatomic, strong) UILabel           *fsLabel;

@end

@implementation XInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	[self setUpZWTextView];
}

- (void)setUpZWTextView {
	
	UITextView *textView 		= [[UITextView alloc]initWithFrame:CGRectMake(15, 50 + 70 + 50, kScreenWidth - 15 * 2, 70)];
	textView.contentMode 		= UIControlContentVerticalAlignmentTop;
	textView.backgroundColor 	= [UIColor whiteColor];
	textView.textColor 			= [UIColor blackColor];
	textView.font 				= kFontTheme(10);
	textView.zw_placeHolder 	= @"szwwwwwwwwwing";
	textView.zw_limitCount 		= 20;
	[self.view addSubview:textView];
	
	UITextView *theView = [[UITextView alloc]initWithFrame:CGRectMake(10, textView.maxY + 30, kScreenWidth - 20, 100)];
	//            theView.contentMode = UIControlContentVerticalAlignmentTop;
//	theView.layer.borderColor = [UIColor grayColor].CGColor;
//	theView.layer.borderWidth = 1;
//	theView.layer.cornerRadius = 5;
	theView.tag = 666;
	theView.zw_placeHolder = @"请输入您的问题";
	[self.view addSubview:theView];

//	textView.zw_limitCount 		= 15;
//	textView.zw_inputLimitLabel.text = @"xxx";
}

@end
