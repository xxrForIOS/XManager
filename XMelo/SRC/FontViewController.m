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
		
		return [@[@(3), @(selfWeak.fonts.count)][section] integerValue];
	};
	
	self.heightForHeadrAtIndexPath = ^CGFloat(NSInteger section) {
		
		return [@[@(0.001), @(10)][section] floatValue];
	};
	
//    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
//
//        return selfWeak.fonts.count;
//    };
//
    self.heightForRowAtIndexPath = ^CGFloat(NSIndexPath *indexPath) {
        
        return 50;
    };
    
    self.creatCellView = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
      
        cell.textLabel.font = [UIFont fontWithName:selfWeak.fonts[indexPath.row] size:15];
        cell.textLabel.text = selfWeak.fonts[indexPath.row];
		cell.textLabel.textColor = kColor_yan;
    };
    
    self.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {

        [XAlertController showAlertWith:selfWeak.fonts[indexPath.row]];
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
	[button addClick:^(UIButton * _Nullable button) {
		
		//		kPush(selfWeak, [[YVSDCommentPublishVC alloc]init]);
	}];
	[button mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.centerX.equalTo(self.view);
		make.bottom.equalTo(self.view).offset(kIphoneXDevice ? -30.0f : 0);
		make.size.mas_equalTo(CGSizeMake(kScreenWidth, 50));
	}];
	
	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
		
		make.edges.equalTo(selfWeak.view).insets(UIEdgeInsetsMake(0.0f, 0.0f, setIphoneXSize(85.0f, 55.0f), 0.0f));
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
