//
//  XViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XViewController.h"
#import "NAVViewController.h"
#import "XCell.h"
@interface XViewController ()

@end

@implementation XViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    @kWeakSelf;
    
    self.tableView.height = kScreenHeight - 100;
    
    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
        return 10;
    };

    self.tableView.rowHeight = 70;
    
    self.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {
        
        kPush(selfWeak, [[NAVViewController alloc]init]);
    };
    
    [self.tableView registerClass:[XCell class] forCellReuseIdentifier:@"cell"];
    self.cellForRowAtIndexPath = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
      
        XCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
    

        return cell;
    };
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
