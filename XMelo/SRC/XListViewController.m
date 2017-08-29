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

@interface XListViewController ()

@property (nonatomic, strong) NSArray           *datas;
@property (nonatomic, strong) NSArray           *controllers;
@property (nonatomic, strong) UIView            *bottomTool;
@end

@implementation XListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.datas = @[@"core data",
                   @"upload image cell",
                   @"picker",
                   @"input",
                   
                   ];
    self.controllers = @[[[XCoreDataViewController alloc]init],
                         [[UploadImageViewController alloc]init],
                         [[XPickerViewController alloc]init],
                         [[XInputViewController alloc]init]
                         ];
    
    self.tableView.height = kScreenHeight - 64 - 50;
    self.tableView.rowHeight = kCellHeight;
    @kWeakSelf;
    
    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
       
        return selfWeak.datas.count;
    };
    
    self.heightForHeadrAtIndexPath = ^CGFloat(NSInteger section) {
      
        return 5.0f;
    };
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.cellForRowAtIndexPath = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
      
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        if (cell) {
            for (UIView *theView in cell.contentView.subviews) {
                [theView removeFromSuperview];
            }
        }
        cell.textLabel.text = selfWeak.datas[indexPath.row];
        return cell;
    };
    
    self.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {
        
        UIViewController *vcc = selfWeak.controllers[indexPath.row];
        kPush(selfWeak, vcc);
    };
    
    selfWeak.bottomTool = ({
        
        UIView *theView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 45 - 64, kScreenWidth, 45)];
        theView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:theView];
        
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
