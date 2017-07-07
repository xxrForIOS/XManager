//
//  XManager.h
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHead.h"

@interface XManager : NSObject


///单例
+ (XManager *)sharedManager;

///颜色图片
+ (UIImage *)getImageFromColor:(UIColor *)color;
+ (UIImage *)getImageFromColor:(UIColor *)color withSize:(CGSize)size;

///格式化时间
+ (NSString *)timeGetDateFormat:(NSString *)dateString;

///gcd延时操作
+ (void)dispatchAfter:(int)interval timeout:(void(^)())timerOut;

///gcd开辟子线程
+ (void)dispatchAsynac:(void(^)())asyncBlock mainQueue:(void(^)())mainBlock;

///打电话
+ (void)callWithWithNumber:(NSString *)number;


/** 弹窗*/
+ (void)alertControllerWithTitle:(NSString *)title
                         message:(NSString *)message
                   confirmButton:(NSString *)confirmStr
                    cancelButton:(NSString *)cancelStr
                          showIn:(UIViewController *)vcc
                    confirmBlock:(void (^)())cfBlock
                     cancelBlock:(void (^)())ccBlock;

+ (void)alertTextFiledWithTitle:(NSString *)title
                        message:(NSString *)message
                  confirmButton:(NSString *)confirmStr
                   cancelButton:(NSString *)cancelStr
                         showIn:(UIViewController *)vcc
                 inputTextfield:(void (^)(UITextField *inputTF))inputBlock
                   confirmBlock:(void (^)(UITextField *inputTF))cfBlock
                    cancelBlock:(void (^)(UITextField *inputTF))ccBlock;


+ (void)showAlertWith:(NSString *)str;

/** block单弹窗*/
+ (void)showAlertWith:(NSString *)str confirm:(void(^)())aBlock;

@end
