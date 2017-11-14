//
//  XViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XListViewController.h"
#import "XCoreDataViewController.h"
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

	self.controllers = @[@"XCoreDataViewController",
						 @"UploadImageViewController",
						 @"XPickerViewController",
						 @"XInputViewController",
						 @"FontViewController",
						 @"ImageValidationViewController"];
    
    self.tableView.height 			= kScreenHeight - 64 - 50;
    self.tableView.rowHeight 		= 50;
    self.tableView.separatorStyle 	= UITableViewCellSeparatorStyleNone;
    self.navigationItem.title 		= @"XMelo";
    @kWeakSelf;

    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
       
        return selfWeak.controllers.count;
    };

    self.heightForHeadrAtIndexPath = ^CGFloat(NSInteger section) {
      
        return 1;
    };
    
    self.creatCellView = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
        
        cell.textLabel.font = kFontTheme(15);
        cell.textLabel.text = selfWeak.controllers[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    };
    
    self.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {

		Class cls = NSClassFromString(selfWeak.controllers[indexPath.row]);
		kPush(selfWeak, [[cls alloc] init]);
    };

	[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"xxalert" object:nil] subscribeNext:^(NSNotification * _Nullable x) {

		YVLog(@"addobserver list");
	}];


	[XManager addRightBarItemInViewController:self itemTitle:@"dismiss" andItemBlock:^(UIButton *aButton) {

		[selfWeak dismissViewControllerAnimated:YES completion:nil];
//		[[NSNotificationCenter defaultCenter]postNotificationName:@"xxalert" object:nil userInfo:nil];;
	}];

    [self startWithAnimation:self.animation];
}

- (void)startWithAnimation:(NSString *)string {

    self.tableView.hidden = YES;
    [XManager dispatchAfter:1 completion:^{

        self.tableView.hidden = NO;
        if ([string isEqualToString:@"move"])           [TableViewAnimationKit moveAnimationWithTableView:self.tableView];
        if ([string isEqualToString:@"alpha"])          [TableViewAnimationKit alphaAnimationWithTableView:self.tableView];
        if ([string isEqualToString:@"fall"])           [TableViewAnimationKit fallAnimationWithTableView:self.tableView];
        if ([string isEqualToString:@"shake"])          [TableViewAnimationKit shakeAnimationWithTableView:self.tableView];
        if ([string isEqualToString:@"over"])           [TableViewAnimationKit overTurnAnimationWithTableView:self.tableView];
        if ([string isEqualToString:@"toTop"])          [TableViewAnimationKit toTopAnimationWithTableView:self.tableView];
        if ([string isEqualToString:@"spring"])         [TableViewAnimationKit springListAnimationWithTableView:self.tableView];
        if ([string isEqualToString:@"shrink"])         [TableViewAnimationKit shrinkToTopAnimationWithTableView:self.tableView];
        if ([string isEqualToString:@"layDonw"])        [TableViewAnimationKit layDonwAnimationWithTableView:self.tableView];
        if ([string isEqualToString:@"rote"])           [TableViewAnimationKit roteAnimationWithTableView:self.tableView];
    }];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
	UIContextualAction *favourRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"收藏" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {

		UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
		CGFloat red   = (arc4random() % 256) / 256.0;
		CGFloat green = (arc4random() % 256) / 256.0;
		CGFloat blue  = (arc4random() % 256) / 256.0;

		cell.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];

		completionHandler(YES);
	}];
	favourRowAction.backgroundColor = [UIColor orangeColor];

	UISwipeActionsConfiguration *favourRowConfiguration = [UISwipeActionsConfiguration configurationWithActions:@[favourRowAction]];
	return favourRowConfiguration;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
