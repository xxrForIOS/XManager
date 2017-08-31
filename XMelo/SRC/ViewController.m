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

    
    UILabel *theLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 300, kScreenWidth - 80, 30)];
    theLabel.font = kFontTheme(15);
    theLabel.textColor = [UIColor blackColor];
    theLabel.text = @"UIViewAnimationOptionCurveEaseInOut";
    [self.view addSubview:theLabel];
    [theLabel changeColor:[UIColor redColor] string:@"e" repetition:YES];
    [theLabel changeFont:kFontTheme(10) string:@"e"];
    
    
    UIView *theView = [[UIView alloc]initWithFrame:CGRectMake(30, 200, kScreenWidth - 60, 50)];
    theView.layer.cornerRadius = theView.height/2;
    theView.backgroundColor = [UIColor redColor];
    [self.view addSubview:theView];
    
    theView.userInteractionEnabled = YES;
    [theView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
        
        [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            if (theView.width == 50) {
                
                theView.frame = CGRectMake(30, 200, kScreenWidth - 60, 50);
            } else {
                
                theView.frame = CGRectMake(kScreenWidth/2 - 25, 200, 50, 50);
            }
        } completion:nil];
    }]];
    
    [UIView animateWithDuration:2 animations:^{
        
        self.view.backgroundColor = kColor_yuebai;
    } completion:^(BOOL finished) {
        
        [XManager showHUDWithString:@"Oops I Dit It Again" completion:^{
            
//            [self configRootViewController];
        }];
    }];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
        
        [self configRootViewController];
    }]];
}

- (void)configRootViewController {
    
    XListViewController *firstVC = [[XListViewController alloc] init];
    JTNavigationController *navvvvvvvv = [[JTNavigationController alloc]initWithRootViewController:firstVC];
    JTBaseNavigationController *firstNav = [[JTBaseNavigationController alloc] initWithRootViewController:navvvvvvvv];
    self.view.window.rootViewController = firstNav;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
