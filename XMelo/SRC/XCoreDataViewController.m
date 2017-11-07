//
//  XCoreDataViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/8/1.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XCoreDataViewController.h"
#import "XSonModel+CoreDataClass.h"
#import "XSonModel+CoreDataProperties.h"
#import "UIScrollView+SpringHeadView.h"


@interface XCoreDataViewController ()

@end

@implementation XCoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"coreData";
    @kWeakSelf;

//	[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"xxalert" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//
//		[XManager showHUDWithString:@"alert in list" completion:^{
//
//			NSLog(@"do do subscribeNext");
//		}];
//	}];

//	[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"xxalert" object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
//
//		[XManager showHUDWithString:@"alert in list" completion:^{
//
//			NSLog(@"do do rac_willDeallocSignal");
//		}];
//	}];

	[XManager addRightBarItemInViewController:self itemTitle:@"dismiss" andItemBlock:^(UIButton *aButton) {

//		[selfWeak dismissViewControllerAnimated:YES completion:nil];

		kPop(selfWeak);
		[XManager dispatchAfter:5 completion:^{

			[[NSNotificationCenter defaultCenter]postNotificationName:@"xxalert" object:nil userInfo:nil];;
		}];
	}];
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
