//
//  FontViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/9/1.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "FontViewController.h"

@interface FontViewController ()

@property (nonatomic, strong) NSArray       *fonts;

@end

@implementation FontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fonts = [[UIFont familyNames] copy];
    self.navigationItem.title = @"系统字体一览";
	self.numberOfSections = 2;
	[self configBottomTool];
    @kWeakSelf;
	
	self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
		
//		return [@[@(2), @(selfWeak.fonts.count)][section] integerValue];
		
		return [@[@(2), @(13)][section] integerValue];

		//        return selfWeak.controllers.count;
	};
	
	self.heightForHeadrAtIndexPath = ^CGFloat(NSInteger section) {
		
//		if (section == 0) {
//
//			return [[NSNumber numberWithFloat:CGFLOAT_MIN] floatValue];
//		} else {
//
//			return 10;
//		}
		
		double xx = CGFLOAT_MIN;
		id xd = @(CGFLOAT_MIN);
		double xxd = [@(CGFLOAT_MIN) floatValue];
		
		NSArray *height = @[@(CGFLOAT_MIN), @(10)];
		
		NSNumber *height11 = height[0];
		
		CGFloat heighttttt = [height11 floatValue];
		
		return [@[@(CGFLOAT_MIN), @(10)][section] floatValue];
	};
	
//    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
//
//        return selfWeak.fonts.count;
//    };
	
    self.heightForRowAtIndexPath = ^CGFloat(NSIndexPath *indexPath) {
        
        return 50;
    };
    
    self.creatCellView = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
      
        cell.textLabel.font = [UIFont fontWithName:selfWeak.fonts[indexPath.row] size:15];
        cell.textLabel.text = selfWeak.fonts[indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
    };
    
    self.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {

        [XManager showAlertWith:selfWeak.fonts[indexPath.row]];
        YVLog(@"font: %@",selfWeak.fonts[indexPath.row]);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configBottomTool {
	
	UIButton *button            = [UIButton buttonWithType:UIButtonTypeCustom];
	button.backgroundColor 		= [UIColor whiteColor];
	[button setImage:kImageName(@"wish_grab_10") forState:UIControlStateNormal];
	[button setTitle:@"评论" forState:UIControlStateNormal];
	[button setTitleColor:kColorHex(0x999999) forState:UIControlStateNormal];
	button.titleLabel.font 		= [UIFont systemFontOfSize:15];
	[button changePosition:XRButtonDrawStyleLeft space:10];
	[self.view addSubview:button];
	
	@kWeakSelf;
	[button addBlockWithTouchUpInside:^(UIButton * _Nullable button) {
		
		//		kPush(selfWeak, [[YVSDCommentPublishVC alloc]init]);
	}];
	[button mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.centerX.equalTo(self.view);
		make.bottom.equalTo(self.view).offset(kIphoneXDevice ? -30.0f : 0);
		make.size.mas_equalTo(CGSizeMake(kScreenWidth, 50));
	}];
	
	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
		
		make.edges.equalTo(selfWeak.view).insets(UIEdgeInsetsMake(0.0f, 0.0f, selectConstraint(85.0f, 55.0f), 0.0f));
	}];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
