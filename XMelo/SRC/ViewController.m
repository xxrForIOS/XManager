//
//  ViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ViewController.h"
#import "XHead.h"
#import "XListViewController.h"
#import "JTNavigationController.h"
#import "JTBaseNavigationController.h"

@interface ViewController () 

@property (nonatomic, strong) UISearchBar       *searchBar;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    [UIView animateWithDuration:2 animations:^{
        
        self.view.backgroundColor = kColor_yuebai;
    } completion:^(BOOL finished) {
        
        [XManager showHUDWithString:@"I Did It My Way" confirm:^{
            
            XListViewController *firstVC = [[XListViewController alloc] init];
            JTNavigationController *navvvvvvvv = [[JTNavigationController alloc]initWithRootViewController:firstVC];
            JTBaseNavigationController *firstNav = [[JTBaseNavigationController alloc] initWithRootViewController:navvvvvvvv];
            self.view.window.rootViewController = firstNav;
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
