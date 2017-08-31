//
//  XManager.h
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHead.h"

///时间显示格式
typedef NS_ENUM(NSInteger, XRDateFormatType) {
    
    ///2017-05-26 21:49
    XRDateFormatTypeYMDHM,
    //05-26 21:49
    XRDateFormatTypeMDHM,
    //21:49
    XRDateFormatTypeHM,
};

@interface XManager : NSObject


///单例
+ (XManager *)sharedManager;

///颜色图片
+ (UIImage *)getImageFromColor:(UIColor *)color;
+ (UIImage *)getImageFromColor:(UIColor *)color withSize:(CGSize)size;



///gcd延时操作
+ (void)dispatchAfter:(int)time completion:(void(^)())timerOut;

///gcd开辟子线程
+ (void)dispatchAsynac:(void(^)())asyncBlock mainQueue:(void(^)())mainBlock;

///打电话
+ (void)callWithNumber:(NSString *)number;

+ (void)addRightBarItemInViewController:(UIViewController *)vcc itemTitle:(NSString *)str andItemBlock:(void(^)(UIButton *aButton))aBlock;

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

+ (void)showHUDWithString:(NSString *)str completion:(void(^)())completion;


///格式化时间 今天昨天
+ (NSString *)timeGetDateFormat:(NSString *)dateString;
///定制格式化时间
+ (NSString *)timeGetDateFormat:(NSString *)dateString format:(XRDateFormatType)type;

///获取当前时间戳
+ (NSString *)timeGetTimeStampSinceNow;

/** 获取距离时间戳*/
+ (NSString *)timeGetTimeStampSinceNow:(int)second;

@end
