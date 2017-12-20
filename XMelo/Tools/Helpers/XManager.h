//
//  XManager.h
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <Foundation/Foundation.h>




///渐变颜色显示方式
typedef NS_ENUM(NSInteger, YVRradualColorShowType) {

	///从左到右
	YVRradualColorShowTypeLeftRight = 0,
	///从上到下
	YVRradualColorShowTypeTopBottom = 1,
	///左上到右下
	YVRradualColorShowTypeLTopToRBottom = 2,
	///左下到右上
	YVRradualColorShowTypeLBottomToRTop = 3,
};

@interface XManager : NSObject


///单例
+ (XManager *)sharedManager;

+ (void)addRradualColorFor:(UIView *)theView colors:(NSArray *)colors showType:(YVRradualColorShowType)type;

///颜色图片
+ (UIImage *)getImageFromColor:(UIColor *)color;
+ (UIImage *)getImageFromColor:(UIColor *)color withSize:(CGSize)size;

///MARK:- gcd延时操作
+ (void)dispatchAfter:(int)time completion:(void(^)(void))timerOut;

///MARK: gcd开辟子线程
+ (void)dispatchAsynac:(void(^)(void))asyncBlock mainQueue:(void(^)(void))mainBlock;


///MARK:- 打电话
+ (void)callWithNumber:(NSString *)number;


///MARK:- 导航条右上角添加文字按钮
+ (void)addRightBarItemInViewController:(UIViewController *)vcc itemTitle:(NSString *)str andItemBlock:(void(^)(UIButton *aButton))aBlock;


///MARK:- 弹窗
+ (void)showAlertWith:(NSString *)str;
+ (void)showAlertWith:(NSString *)str confirm:(void(^)(void))aBlock;
+ (void)showAlertWith:(NSString *)str confirm:(void(^)(void))afBlock cancel:(void(^)(void))ccBlock;

///MARK: 会消失的弹窗
+ (void)showHUDWithString:(NSString *)str completion:(void(^)(void))completion;

///弹窗主体方法
+ (void)alertControllerWithTitle:(NSString *)title
                         message:(NSString *)message
                   confirmButton:(NSString *)confirmStr
                    cancelButton:(NSString *)cancelStr
                    confirmBlock:(void (^)(void))cfBlock
                     cancelBlock:(void (^)(void))ccBlock;

+ (void)alertTextFiledWithTitle:(NSString *)title
                        message:(NSString *)message
                  confirmButton:(NSString *)confirmStr
                   cancelButton:(NSString *)cancelStr
                         showIn:(UIViewController *)vcc
                 inputTextfield:(void (^)(UITextField *inputTF))inputBlock
                   confirmBlock:(void (^)(UITextField *inputTF))cfBlock
                    cancelBlock:(void (^)(UITextField *inputTF))ccBlock;


@end
