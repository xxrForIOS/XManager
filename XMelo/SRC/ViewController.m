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

#import "JTNavigationController.h"
#import "JTBaseNavigationController.h"
#import "RTRootNavigationController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    self.view.backgroundColor = kColor_yuebai;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        
        
        XViewController *rootVC = [[XViewController alloc]init];
        
        JTBaseNavigationController *navv = [[JTBaseNavigationController alloc] initWithRootViewController:rootVC];
        navv.fullScreenPopGestureEnable = YES;
        
        RTRootNavigationController *newVV = [[RTRootNavigationController alloc] initWithRootViewController:rootVC];
        
        navv.backButtonImage = kImageName(@"ZWRPL6I1)WPIVE`QOT})_O0.gif");
        self.view.window.rootViewController = navv;
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
