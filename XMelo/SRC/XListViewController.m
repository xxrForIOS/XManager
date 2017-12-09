//
//  XViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XListViewController.h"
#import "TableViewAnimationKit.h"

#import "ThirdSignViewController.h"
#import "ImageValidationViewController.h"
#import "FontViewController.h"
#import "XInputViewController.h"
#import "XPickerViewController.h"

@interface XListViewController ()

@property (nonatomic, strong) NSArray           *controllers;
@end

@implementation XListViewController

- (void)viewDidLoad {
    [super viewDidLoad];


	self.navigationItem.title 		= @"XMelo";
    self.tableView.rowHeight 		= 50;
//    self.tableView.separatorStyle 	= UITableViewCellSeparatorStyleNone;
	self.controllers 				= @[@"UploadImageViewController",
										@"XPickerViewController",
										@"XInputViewController",
										@"FontViewController",
										@"ImageValidationViewController",
										@"ThirdSignViewController"];
	
	@kWeakSelf;
    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
       
        return selfWeak.controllers.count;
    };
    
    self.creatCellView = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
		
		UILabel *theLabel = [[UILabel alloc]init];
		theLabel.text = selfWeak.controllers[indexPath.row];
		theLabel.font = kFontTheme(12);
		cell.backgroundColor = kColorRandom;
		[cell.contentView addSubview:theLabel];
		
		[theLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			
			make.right.offset(-20);
			make.centerY.offset(0);
			make.height.offset(10);
		}];
		
//        cell.textLabel.font = kFontTheme(15);
//        cell.textLabel.text = selfWeak.controllers[indexPath.row];
//        cell.accessoryType 	= UITableViewCellAccessoryDisclosureIndicator;
    };
    
    self.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {

		Class cls = NSClassFromString(selfWeak.controllers[indexPath.row]);
		kPush(selfWeak, [[cls alloc] init]);
    };

	[XManager addRightBarItemInViewController:self itemTitle:@"dismiss" andItemBlock:^(UIButton *aButton) {
		
		[selfWeak dismissViewControllerAnimated:YES completion:nil];
		[[NSNotificationCenter defaultCenter]postNotificationName:@"xxalert" object:nil userInfo:nil];;
	}];

	self.tableView.hidden = YES;
	[XManager dispatchAfter:1 completion:^{

		self.tableView.hidden = NO;
		[TableViewAnimationKit cellAnimationWithTableView:self.tableView animationType:self.type];
	}];
	
	[self configBottomTool];
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//
//	return indexPath.row % 2 == 0;
//}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	return UITableViewCellEditingStyleDelete;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	@kWeakSelf;
	UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"取消关注" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
		
		[XManager alertControllerWithTitle:@"提示" message:@"取消关注" confirmButton:@"确定" cancelButton:@"取消" confirmBlock:^{
			
//			[selfWeak.datas removeObjectAtIndex:indexPath.row];
//			[tableView beginUpdates];
//			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//			[tableView endUpdates];
		} cancelBlock:nil];
	}];
	
	return @[deleteRowAction];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
	UIContextualAction *favourRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"收藏" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {

		UITableViewCell *cell 	= [tableView cellForRowAtIndexPath:indexPath];
		CGFloat red 			= (arc4random() % 256) / 256.0;
		CGFloat green 			= (arc4random() % 256) / 256.0;
		CGFloat blue 			= (arc4random() % 256) / 256.0;
		cell.backgroundColor 	= [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
		completionHandler(YES);
	}];
	favourRowAction.backgroundColor = [UIColor orangeColor];

	UISwipeActionsConfiguration *favourRowConfiguration = [UISwipeActionsConfiguration configurationWithActions:@[favourRowAction]];
	return favourRowConfiguration;
}

//评论按钮
- (void)configBottomTool {
	
	@kWeakSelf;
	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
		
		make.edges.equalTo(selfWeak.view).insets(UIEdgeInsetsMake(0.0f, 0.0f, selectConstraint(85.0f, 55.0f), 0.0f));
	}];
	
	UIButton *commentButton = ({
		
		UIButton *button            = [UIButton buttonWithType:UIButtonTypeCustom];
		button.backgroundColor 		= [UIColor whiteColor];
//		button.titleLabel.font 		= kFont15;
		[button setTitle:@"评论" 						forState:UIControlStateNormal];
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
	

	
	[commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.centerX.equalTo(selfWeak.view);
		make.bottom.equalTo(selfWeak.view).offset(kIphoneXDevice ? -30.0f : 0);
		make.size.mas_equalTo(CGSizeMake(kScreenWidth, 50));
	}];
	
	[toTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.right.offset(-12);
		make.height.width.offset(29.0f);
		
//		make.size.mas_equalTo(CGSizeMake(29.0f, 29.0f));
		make.bottom.equalTo(commentButton.mas_top).with.offset(-46);
	}];
	
	[rewardButton mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.right.equalTo(toTopButton);
		make.size.equalTo(toTopButton);
		make.bottom.equalTo(toTopButton.mas_top).with.offset(-27);
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
