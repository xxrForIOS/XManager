//
//  XViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XViewController.h"
#import "NAVViewController.h"
#import "XStepper.h"
@interface XViewController ()

@end

@implementation XViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    @kWeakSelf;
    self.numberOfSections = 2;
    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
        return 3;
    };
    
    
    self.heightForRowAtIndexPath = ^CGFloat(NSIndexPath *indexPath) {
        return 50;
    };
    
    self.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {
      
//        NSString *ssss = kStringFormat(@"这里是%ld",indexPath.row);
//        [XManager showAlertWith:ssss];
        
        [selfWeak.navigationController pushViewController:[[NAVViewController alloc]init] animated:YES];
    };
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.cellForRowAtIndexPath = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
      
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        if (indexPath.row %2 == 0) {
            
            XStepper *sss = [[XStepper alloc]initWithFrame:CGRectMake(20, 10, 100, 30)];
            [cell.contentView addSubview:sss];
        }
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
