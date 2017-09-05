//
//  WebViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/9/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>


@interface WebViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView             *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.webView = ({
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@""]];
        [webView loadRequest:request];
        webView.UIDelegate = self;
        webView.navigationDelegate = self;
        [self.view addSubview:webView];
        webView;
    });
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];

    manager.enableAutoToolbar = NO;
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
