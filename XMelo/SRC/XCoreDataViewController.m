//
//  XCoreDataViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/8/1.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XCoreDataViewController.h"

@interface XCoreDataViewController ()

@end

@implementation XCoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.numberOfSections = 2;
    
    self.tableView.rowHeight = kCellHeight;
    
    self.heightForHeadrAtIndexPath = ^CGFloat(NSInteger section) {
        
        return 5.0f;
    };
    
    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
        return ({
            
            NSArray *rows = @[@1, @3];
            NSInteger theRows = [rows[section] integerValue];
            theRows;
        });
    };
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.cellForRowAtIndexPath = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
      
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        for (UIView *theView in cell.contentView.subviews) {
            
            [theView removeFromSuperview];
        }
        
        kLog(@"xxx %p",cell);
        cell.textLabel.text = [XManager timeGetTimeStampSinceNow];
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
