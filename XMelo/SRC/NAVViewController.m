//
//  NAVViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/5.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "NAVViewController.h"

@interface NAVViewController ()

@end

@implementation NAVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"标题";
    
    self.view.backgroundColor = kColorIceBlue;
    


    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        
        

        [self.navigationController pushViewController:[[NAVViewController alloc]init] animated:YES];
    }]];
    
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
