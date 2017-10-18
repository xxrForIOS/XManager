//
//  FontViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/9/1.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "FontViewController.h"

@interface FontViewController ()

@property (nonatomic, strong) NSArray       *fonts;

@end

@implementation FontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fonts = [[UIFont familyNames] copy];
    self.navigationItem.title = @"系统字体一览";

    @kWeakSelf;
    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
        
        return selfWeak.fonts.count;
    };
    
    self.heightForRowAtIndexPath = ^CGFloat(NSIndexPath *indexPath) {
        
        return 30;
    };
    
    self.creatCellView = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
      
        cell.textLabel.font = [UIFont fontWithName:selfWeak.fonts[indexPath.row] size:15];
        cell.textLabel.text = selfWeak.fonts[indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
    };
    
//    self.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {
//
//        [XManager showAlertWith:selfWeak.fonts[indexPath.row]];
//        kLog(@"font: %@",selfWeak.fonts[indexPath.row]);
//    };
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
