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

#import "CutOutViewController.h"

@interface XListViewController ()

@property (nonatomic, strong) NSArray           *datas;
@property (nonatomic, strong) NSArray           *controllers;
@end

@implementation XListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.datas = @[@"core data",
                   @"upload image cell",
                   @"block picker",
                   @"input",
                   @"system fonts",
                   @"image validation"
                   ];
    
    self.controllers = @[[[XCoreDataViewController alloc]init],
                         [[UploadImageViewController alloc]init],
                         [[XPickerViewController alloc]init],
                         [[XInputViewController alloc]init],
                         [[FontViewController alloc]init],
                         [[ImageValidationViewController alloc]init]
                         ];
    
    self.tableView.height = kScreenHeight - 64 - 50;
    self.tableView.rowHeight = kCellHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"XMelo";
    @kWeakSelf;
    
    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
       
        return selfWeak.datas.count;
    };

    self.heightForHeadrAtIndexPath = ^CGFloat(NSInteger section) {
      
        return 1;
    };
    
    self.creatCellView = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
        
        cell.textLabel.font = kFontTheme(15);
        cell.textLabel.text = selfWeak.datas[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    };
    
    self.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {

		[selfWeak.navigationController pushViewController:selfWeak.controllers[indexPath.row] animated:YES];
//        kPush(selfWeak, selfWeak.controllers[indexPath.row]);
    };

    
    
    [XManager addRightBarItemInViewController:self itemTitle:@"dismiss" andItemBlock:^(UIButton *aButton) {

        [selfWeak dismissViewControllerAnimated:YES completion:nil];
    }];


//    [self startWithAnimation:self.animation];
}

//- (void)startWithAnimation:(NSString *)string {
//
//    self.tableView.hidden = YES;
//    [XManager dispatchAfter:1 completion:^{
//
//        self.tableView.hidden = NO;
//        if ([string isEqualToString:@"move"])           [TableViewAnimationKit moveAnimationWithTableView:self.tableView];
//        if ([string isEqualToString:@"alpha"])          [TableViewAnimationKit alphaAnimationWithTableView:self.tableView];
//        if ([string isEqualToString:@"fall"])           [TableViewAnimationKit fallAnimationWithTableView:self.tableView];
//        if ([string isEqualToString:@"shake"])          [TableViewAnimationKit shakeAnimationWithTableView:self.tableView];
//        if ([string isEqualToString:@"over"])           [TableViewAnimationKit overTurnAnimationWithTableView:self.tableView];
//        if ([string isEqualToString:@"toTop"])          [TableViewAnimationKit toTopAnimationWithTableView:self.tableView];
//        if ([string isEqualToString:@"spring"])         [TableViewAnimationKit springListAnimationWithTableView:self.tableView];
//        if ([string isEqualToString:@"shrink"])         [TableViewAnimationKit shrinkToTopAnimationWithTableView:self.tableView];
//        if ([string isEqualToString:@"layDonw"])        [TableViewAnimationKit layDonwAnimationWithTableView:self.tableView];
//        if ([string isEqualToString:@"rote"])           [TableViewAnimationKit roteAnimationWithTableView:self.tableView];
//    }];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
