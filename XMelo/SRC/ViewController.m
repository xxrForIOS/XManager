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
#import <CoreText/CoreText.h>
#import "NNValidationView.h"


@interface ViewController () 

@property (nonatomic, strong) UISearchBar       *searchBar;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    


    
    NSArray *animations = @[@"move",
                            @"alpha",
                            @"fall",
                            @"shake",
                            @"over",
                            @"toTop",
                            @"spring",
                            @"shrink",
                            @"layDonw",
                            @"rote"];
   
    CGFloat theWidth = (kScreenWidth - 40 - 10 * 3)/4;
    for (int index = 0; index < animations.count; index ++) {
        
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
        theButton.frame = CGRectMake(20 + (theWidth + 10) * (index%4), 200 + (35 + 20) * (index/4), theWidth, 35);
        theButton.layer.cornerRadius = theButton.height/2;
        theButton.layer.borderColor = [UIColor redColor].CGColor;
        [theButton changeCorner:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:5];
        [theButton setTitle:animations[index] forState:UIControlStateNormal];
        [theButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        theButton.backgroundColor = [UIColor whiteColor];
        theButton.layer.borderWidth = 1;
        theButton.layer.masksToBounds = YES;
        theButton.titleLabel.font = kFontTheme(12);
        [self.view addSubview:theButton];
        [theButton addBlockWithblock:^(UIButton *theBlockButton) {
           
            XListViewController *vcc = [[XListViewController alloc]init];
            vcc.animation = theBlockButton.currentTitle;
            JTNavigationController *navvvvvvvv = [[JTNavigationController alloc]initWithRootViewController:vcc];
            JTBaseNavigationController *firstNav = [[JTBaseNavigationController alloc] initWithRootViewController:navvvvvvvv];
            [self presentViewController:firstNav animated:YES completion:nil];
        }];
    }
    
    NSInteger count = 4;
    CGFloat imageWidth = kScreenWidth - 12 * 2;
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 210, kScreenWidth, 200)];
    scrollView.backgroundColor = [UIColor brownColor];
    scrollView.contentSize = CGSizeMake(12 + kScreenWidth * count, 200);
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    for (int index = 0; index < count; index ++) {
        
        UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(12 + kScreenWidth * index, 5, imageWidth, 200)];
        imageView.backgroundColor = kColorRandom;
        [scrollView addSubview:imageView];
    }
    
//    [UIView animateWithDuration:2 animations:^{
//        
//        self.view.backgroundColor = kColor_yuebai;
//    } completion:^(BOOL finished) {
//        
//        [XManager showHUDWithString:@"Oops I Dit It Again" completion:^{
//            
//            [self configRootViewController];
//        }];
//    }];
//    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
        
        [self configRootViewController];
    }]];
}

- (void)configRootViewController {
    
    XListViewController *firstVC = [[XListViewController alloc] init];
    JTNavigationController *navvvvvvvv = [[JTNavigationController alloc]initWithRootViewController:firstVC];
    JTBaseNavigationController *firstNav = [[JTBaseNavigationController alloc] initWithRootViewController:navvvvvvvv];
    [self presentViewController:firstNav animated:YES completion:nil];
    self.view.window.rootViewController = firstNav;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
