//
//  XViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XViewController.h"
#import "XCell.h"
#import "XCoreDataViewController.h"
#import "MJRefresh.h"

@interface XViewController ()

@property (nonatomic, strong) NSArray           *datas;
@property (nonatomic, strong) UIView            *bottomTool;
@end

@implementation XViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.datas = @[@"core data",
                   @"custom cell",
                   @"ssss",
                   @"something"];
    @kWeakSelf;
    
    self.tableView.height = kScreenHeight - 64 - 50;
    
    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
       
        return selfWeak.datas.count;
    };

    self.tableView.rowHeight = kCellHeight;
    
    
    self.heightForHeadrAtIndexPath = ^CGFloat(NSInteger section) {
      
        return 5.0f;
    };
    
    self.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {
        
        NSArray *pushVC = @[[[XCoreDataViewController alloc]init]];
        
        if (indexPath.row == 0) {
            kPush(selfWeak, pushVC[indexPath.row]);
        }
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
