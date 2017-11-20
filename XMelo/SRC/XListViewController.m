//
//  XViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XListViewController.h"
#import "UploadImageViewController.h"
#import "XPickerViewController.h"
#import "XInputViewController.h"
#import "FontViewController.h"
#import "ImageValidationViewController.h"
#import "TableViewAnimationKit.h"

@interface XListViewController ()

@property (nonatomic, strong) NSArray           *controllers;
@end

@implementation XListViewController

- (void)viewDidLoad {
    [super viewDidLoad];


	self.navigationItem.title 		= @"XMelo";
    self.tableView.rowHeight 		= 50;
    self.tableView.separatorStyle 	= UITableViewCellSeparatorStyleNone;
	self.controllers 				= @[@"UploadImageViewController",
										@"XPickerViewController",
										@"XInputViewController",
										@"FontViewController",
										@"ImageValidationViewController"];
	
	@kWeakSelf;
    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
       
        return selfWeak.controllers.count;
    };
    
    self.creatCellView = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
        
        cell.textLabel.font = kFontTheme(15);
        cell.textLabel.text = selfWeak.controllers[indexPath.row];
        cell.accessoryType 	= UITableViewCellAccessoryDisclosureIndicator;
    };
    
    self.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {

		Class cls = NSClassFromString(selfWeak.controllers[indexPath.row]);
		kPush(selfWeak, [[cls alloc] init]);
    };

	[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"xxalert" object:nil] subscribeNext:^(NSNotification * _Nullable x) {

		YVLog(@"addobserver list");
	}];


	[XManager addRightBarItemInViewController:self itemTitle:@"dismiss" andItemBlock:^(UIButton *aButton) {

//		XListViewController *vcc = [[XListViewController alloc]init];
//		vcc.type = XRCellAnimationTypeLayDown;
//		kPush(selfWeak, vcc);
		[selfWeak dismissViewControllerAnimated:YES completion:nil];
		[[NSNotificationCenter defaultCenter]postNotificationName:@"xxalert" object:nil userInfo:nil];;
	}];

	self.tableView.hidden = YES;
	[XManager dispatchAfter:1 completion:^{

		self.tableView.hidden = NO;
		[TableViewAnimationKit cellAnimationWithTableView:self.tableView animationType:self.type];
	}];
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//	cell.hidden = YES;
//	[XManager dispatchAfter:1 completion:^{
//
//		cell.hidden = YES;
//		[TableViewAnimationKit cellAnimationWithTableView:tableView animationType:self.type];
//	}];
//}

//- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
//	UIContextualAction *favourRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"收藏" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//
//		UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//		CGFloat red   = (arc4random() % 256) / 256.0;
//		CGFloat green = (arc4random() % 256) / 256.0;
//		CGFloat blue  = (arc4random() % 256) / 256.0;
//
//		cell.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//
//		completionHandler(YES);
//	}];
//	favourRowAction.backgroundColor = [UIColor orangeColor];
//
//	UISwipeActionsConfiguration *favourRowConfiguration = [UISwipeActionsConfiguration configurationWithActions:@[favourRowAction]];
//	return favourRowConfiguration;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
