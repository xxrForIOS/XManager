//
//  ViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ViewController.h"
#import "XHead.h"
#import "NAVViewController.h"
#import "XViewController.h"




@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UIImage *sss = kImageName(@"xxx%@",@"dd");
    self.view.backgroundColor = kColor_yuebai;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        
        
        self.view.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[XViewController alloc]init]];
    }]];
}


- (void)forTest {
    
    NSLog(@"xxxx");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
