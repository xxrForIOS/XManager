//
//  XViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XListViewController.h"
#import "TableViewAnimationKit.h"

#import "XRLayout.h"
#import "XRCCell.h"


@interface XListViewController ()

@property (nonatomic, strong) NSArray 			*images;
@property (nonatomic, strong) NSArray           *controllers;
@end

@implementation XListViewController

- (void)viewDidLoad {
    [super viewDidLoad];


	self.navigationItem.title = @"XMelo";
	[self setUpTableView];
//	[self configBottomTool];
	
	[XManager addRightBarItemInViewController:self itemTitle:@"dismiss" andItemBlock:^(UIButton *aButton) {
		
		[self dismissViewControllerAnimated:YES completion:nil];
	}];
	
	UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
	theButton.frame = CGRectMake(20, setIphoneXSize(44 + 44, 64), 100,
								 setIphoneXSize(kScreenSize.height - 64 - 34 - 24, kScreenSize.height - 64));
	theButton.backgroundColor = [UIColor randomColor];
	theButton.timeInterval = 0.001;
	[self.view addSubview:theButton];
	
	UIColor *theMeColor = [UIColor randomColor];
	UINavigationBar *navigation = self.navigationController.navigationBar;
	UIImage *colorImage = [UIImage imageWithColor:theMeColor size:CGSizeMake(kScreenSize.width, 64)];
	[navigation setBackgroundImage:colorImage forBarMetrics:UIBarMetricsCompact];
	[navigation setShadowImage:[UIImage new]];
	[navigation setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
										 }];
	[navigation setBarTintColor:theMeColor];
}

#pragma mark- tableView
- (void)setUpTableView {
	
	self.tableView.rowHeight 		= 50;
//	self.tableView.separatorStyle 	= UITableViewCellSeparatorStyleNone;
//	cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);

	@kWeakSelf;
	self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
		
		return selfWeak.controllers.count;
	};
	
	self.creatCellView = ^(UITableViewCell *cell, NSIndexPath *indexPath) {

		//分割线
		cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
		
//		cell.backgroundColor 		= kColorRandom;
		UILabel *theLabel 			= [[UILabel alloc]init];
		theLabel.text 				= selfWeak.controllers[indexPath.row];
		theLabel.font 				= kFontTheme(12);
		theLabel.backgroundColor 	= [UIColor whiteColor];
		[cell.contentView addSubview:theLabel];
		
		[theLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			
			make.left.offset(20);
			make.centerY.offset(0);
		}];
	};
	
	self.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {
		
		Class cls = NSClassFromString(selfWeak.controllers[indexPath.row]);
		kPush(selfWeak, [[cls alloc] init]);
	};
	
	self.tableView.hidden = YES;
	
	[XManager dispatchAfter:1 completion:^{
		
		self.tableView.hidden = NO;
		[TableViewAnimationKit cellAnimationWithTableView:self.tableView animationType:self.type];
	}];
}

#pragma mark- 自定义view
- (void)configBottomTool {
	
	@kWeakSelf;
	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {

		make.edges.equalTo(selfWeak.view).insets(UIEdgeInsetsMake(0.0f, 0.0f, setIphoneXSize(50 + 34, 50), 0.0f));
	}];
	
	CGSize safeSize = [[UIScreen mainScreen] safeArea];


	
	UIButton *button            = [UIButton buttonWithType:UIButtonTypeCustom];
	button.backgroundColor 		= [UIColor whiteColor];
	button.titleLabel.font 		= kFontTheme(15);
	[button setTitle:@"comment" 					forState:UIControlStateNormal];
	[button setImage:kImageName(@"sd_comment_s") 	forState:UIControlStateNormal];
	[button setTitleColor:kColorHex(0x999999) 		forState:UIControlStateNormal];
	[button changePosition:XRButtonDrawStyleLeft space:10];
	[self.view addSubview:button];
	UIButton *commentButton = button;
	[commentButton addClick:^(UIButton * _Nullable sender) {
		
		[XAlertController showAlertWith:kSFormat(@"--%@",sender.currentTitle)];
	}];
	
	[commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.centerX.equalTo(selfWeak.view);
		make.bottom.equalTo(selfWeak.view).offset(kIphoneXDevice ? -34.0f : 0);
		make.size.mas_equalTo(CGSizeMake(kScreenWidth, 50));
	}];
}

#pragma mark- delegate
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

	return YES;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"取消关注" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
		
		[XAlertController alertControllerWithTitle:@"xx"
										   message:@"点我干啥"
									 confirmButton:@"S"
									  cancelButton:@"B"
									  confirmBlock:^{
										  
									  } cancelBlock:^{
										  
									  }];
	}];
	
	return @[deleteRowAction];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
	
	UIContextualAction *action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"收藏" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {

		UIColor *aColor 			= [UIColor whiteColor];
		sourceView.backgroundColor 	= aColor;
		UITableViewCell *cell 		= [tableView cellForRowAtIndexPath:indexPath];
		cell.backgroundColor 		= aColor;
		completionHandler(YES);
	}];
	
	UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[action]];
	return config;
}


#pragma mark- lazyLoad
- (NSArray *)controllers {
	
	if (!_controllers) {
		
		_controllers = @[@"UploadImageViewController",
						 @"XPickerViewController",
						 @"XInputViewController",
						 @"FontViewController",
						 @"ImageValidationViewController",
						 @"ThirdSignViewController"];
	}
	return _controllers;
}


@end
