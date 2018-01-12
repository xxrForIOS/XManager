//
//  XManager.h
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface XManager : NSObject


///单例
+ (XManager *)sharedManager;

+ (UIViewController *)currentViewController;

///MARK:- gcd延时操作
+ (void)dispatchAfter:(int)time completion:(void(^)(void))timerOut;

///MARK: gcd开辟子线程
+ (void)dispatchAsynac:(void(^)(void))asyncBlock mainQueue:(void(^)(void))mainBlock;


///MARK:- 打电话
+ (void)callWithNumber:(NSString *)number;


///MARK:- 导航条右上角添加文字按钮
+ (void)addRightBarItemInViewController:(UIViewController *)vcc itemTitle:(NSString *)str andItemBlock:(void(^)(UIButton *aButton))aBlock;


@end
