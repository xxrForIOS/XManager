//
//  ViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ViewController.h"
#import "XHead.h"
#import "XViewController.h"
#import "JTNavigationController.h"
#import "JTBaseNavigationController.h"

#import "UploadImageViewController.h"
@interface ViewController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar       *searchBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.view.backgroundColor = kColor_yuebai;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        
         UploadImageViewController *firstVC = [[UploadImageViewController alloc] init];
        JTNavigationController *navvvvvvvv = [[JTNavigationController alloc]initWithRootViewController:firstVC];
        JTBaseNavigationController *firstNav = [[JTBaseNavigationController alloc] initWithRootViewController:navvvvvvvv];
        self.view.window.rootViewController = firstNav;
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
