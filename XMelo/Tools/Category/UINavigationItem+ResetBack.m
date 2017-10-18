//
//  UINavigationItem+ResetBack.m
//  YiWeiZD
//
//  Created by X.Melody on 2017/5/10.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import "UINavigationItem+ResetBack.h"
#import <objc/runtime.h>

static char kCustomBackButtonKey;

@implementation UINavigationItem (ResetBack)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethodImp = class_getInstanceMethod(self, @selector(backBarButtonItem));
        Method destMethodImp = class_getInstanceMethod(self, @selector(myCustomBackButton_backBarbuttonItem));
        method_exchangeImplementations(originalMethodImp, destMethodImp);
    });
}

- (UIBarButtonItem *)myCustomBackButton_backBarbuttonItem {
    UIBarButtonItem *item = [self myCustomBackButton_backBarbuttonItem];
    if (item) {
        return item;
    }
    
    item = objc_getAssociatedObject(self, &kCustomBackButtonKey);
    if (!item) {

        item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        item.tintColor = [UIColor blackColor];
    }
    return item;
}

@end
