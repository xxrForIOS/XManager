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

@interface XListViewController ()

@property (nonatomic, strong) NSArray           *datas;
@property (nonatomic, strong) NSArray           *controllers;
@property (nonatomic, strong) UIView            *bottomTool;

@property (nonatomic, strong) NSTimer            *timerrr;
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
        
        kPush(selfWeak, selfWeak.controllers[indexPath.row]);
    };
    
    
    selfWeak.bottomTool = ({
        
        UIView *theView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 45 - 64, kScreenWidth, 45)];
        theView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:theView];
        
        UILabel *toolLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, theView.width - 130, 45)];
        toolLabel.textAlignment = NSTextAlignmentRight;
        toolLabel.textColor = kColor_yan;
        toolLabel.font = kFontTheme(14);
        toolLabel.text = @"敢问世间爱恨情仇有几重";
        [theView addSubview:toolLabel];
        
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
        theButton.frame = CGRectMake(kScreenWidth - 100, 0, 100, 45);
        theButton.backgroundColor = [UIColor redColor];
        [theButton setTitle:@"确定" forState:UIControlStateNormal];
        [theButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        theButton.titleLabel.font = kFontTheme(15);
        [theView addSubview:theButton];
        
        [theButton addBlockWithblock:^(id sender) {

            [XManager showAlertWith:@"逗你玩"];
        }];
        theView;
    });
    
    
    
    [XManager addRightBarItemInViewController:self itemTitle:@"show" andItemBlock:^(UIButton *aButton) {
       
        
    }];
}




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
