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
    
//    NSArray *modes = [UITextInputMode activeInputModes];
//    
//    for (UITextInputMode *inputMode in modes) {
//        
//        NSString *language = [inputMode primaryLanguage];
//        
//        NSLog(@"xxx %@",language);
//    }
//    
//    UITextInputMode *inputMode = [UITextInputMode activeInputModes][1];
//    
//    NSString *xxx = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
//    UIView *theView = [[UIView alloc]initWithFrame:CGRectMake(30, 200, kScreenWidth - 60, 50)];
//    theView.backgroundColor = [UIColor redColor];
//    [theView changeCorner:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:theView.height/2];
//    theView.layer.masksToBounds = YES;
//    [self.view addSubview:theView];
//    
//    
//    theView.userInteractionEnabled = YES;
//    [theView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
//        
//        [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            
//            if (theView.width == 50) {
//                
//                theView.frame = CGRectMake(30, 200, kScreenWidth - 60, 50);
//            } else {
//                
//                theView.frame = CGRectMake(kScreenWidth/2 - 25, 200, 50, 50);
//            }
//        } completion:nil];
//    }]];
/*
 
 + (void)moveAnimationWithTableView:(UITableView *)tableView;
 + (void)alphaAnimationWithTableView:(UITableView *)tableView;
 + (void)fallAnimationWithTableView:(UITableView *)tableView;
 + (void)shakeAnimationWithTableView:(UITableView *)tableView;
 + (void)overTurnAnimationWithTableView:(UITableView *)tableView;
 + (void)toTopAnimationWithTableView:(UITableView *)tableView;
 + (void)springListAnimationWithTableView:(UITableView *)tableView;
 + (void)shrinkToTopAnimationWithTableView:(UITableView *)tableView;
 + (void)layDonwAnimationWithTableView:(UITableView *)tableView;
 + (void)roteAnimationWithTableView:(UITableView *)tableView;
 */

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
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
        
        [self configRootViewController];
    }]];
}



- (void)configRootViewController {
    
    XListViewController *firstVC = [[XListViewController alloc] init];
    JTNavigationController *navvvvvvvv = [[JTNavigationController alloc]initWithRootViewController:firstVC];
    JTBaseNavigationController *firstNav = [[JTBaseNavigationController alloc] initWithRootViewController:navvvvvvvv];
    [self presentViewController:firstNav animated:YES completion:nil];
//    self.view.window.rootViewController = firstNav;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
