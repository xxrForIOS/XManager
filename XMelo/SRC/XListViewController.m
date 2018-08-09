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
	[self configBottomTool];
	
	[XManager addRightBarItemInViewController:self itemTitle:@"dismiss" andItemBlock:^(UIButton *aButton) {
		
		[self dismissViewControllerAnimated:YES completion:nil];
	}];
}

#pragma mark- tableView
- (void)setUpTableView {
	
	self.tableView.rowHeight 		= 50;
	self.tableView.separatorStyle 	= UITableViewCellSeparatorStyleNone;
	
	@kWeakSelf;
	self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
		
		return selfWeak.controllers.count;
	};
	
	self.creatCellView = ^(UITableViewCell *cell, NSIndexPath *indexPath) {

		//分割线
		//        cell.separatorInset = UIEdgeInsetsMake(0, self.nameTextField.left, 0, 0);

		
		cell.backgroundColor 		= kColorRandom;
		UILabel *theLabel 			= [[UILabel alloc]init];
		theLabel.text 				= selfWeak.controllers[indexPath.row];
		theLabel.font 				= kFontTheme(12);
		theLabel.backgroundColor 	= [UIColor whiteColor];
		[cell.contentView addSubview:theLabel];
		
		[theLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			
//			make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(padding, padding, padding, padding));

//			make.edges.mas_offset(UIEdgeInsetsMake(10, 20, 10, -20));
			make.left.offset(20);
			make.centerY.offset(0);
//			make.height.mas_lessThanOrEqualTo(cell.contentView);
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
//	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//
//		make.edges.equalTo(selfWeak.view).insets(UIEdgeInsetsMake(150.0f, 0.0f, setIphoneXSize(85.0f, 55.0f), 0.0f));
//	}];
	
	UIButton *commentButton = ({
		
		UIButton *button            = [UIButton buttonWithType:UIButtonTypeCustom];
		button.backgroundColor 		= [UIColor whiteColor];
		button.titleLabel.font 		= kFontTheme(15);
		[button setTitle:@"comment" 					forState:UIControlStateNormal];
		[button setImage:kImageName(@"sd_comment_s") 	forState:UIControlStateNormal];
		[button setTitleColor:kColorHex(0x999999) 		forState:UIControlStateNormal];
		[button changePosition:XRButtonDrawStyleLeft space:10];
		[self.view addSubview:button];
		
		button;
	});
	
	UIButton *toTopButton = ({
		
		UIButton *button            = [UIButton buttonWithType:UIButtonTypeCustom];
		button.layer.cornerRadius 	= 29/2;
		button.layer.masksToBounds 	= YES;
		[button setImage:kImageName(@"sd_top") 	forState:UIControlStateNormal];
		[self.view addSubview:button];
		button;
	});
	
	UIButton *rewardButton = ({
		
		UIButton *button            = [UIButton buttonWithType:UIButtonTypeCustom];
		button.layer.cornerRadius 	= 29/2;
		button.layer.masksToBounds 	= YES;
		[button setImage:kImageName(@"sd_reward") 	forState:UIControlStateNormal];
		[self.view addSubview:button];
		button;
	});
	rewardButton.clickScope = UIEdgeInsetsMake(-20, -20, -20, -20);
	
	[commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.centerX.equalTo(selfWeak.view);
		make.bottom.equalTo(selfWeak.view).offset(kIphoneXDevice ? -30.0f : 0);
		make.size.mas_equalTo(CGSizeMake(kScreenWidth, 50));
	}];
	
	[toTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.right.offset(-12);
		make.height.width.offset(29.0f);
		make.bottom.equalTo(commentButton.mas_top).with.offset(-46);
	}];
	
	[rewardButton mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.right.equalTo(toTopButton);
		make.size.equalTo(toTopButton);
		make.bottom.equalTo(toTopButton.mas_top).with.offset(-27);
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

		UIColor *aColor 			= [UIColor randomColor];
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
