//
//  XAlertController.h
//  XMelo
//
//  Created by melo on 2018/1/11.
//  Copyright © 2018年 欣欣然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XAlertController : NSObject

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
