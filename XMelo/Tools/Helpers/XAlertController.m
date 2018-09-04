//
//  XAlertController.m
//  XMelo
//
//  Created by melo on 2018/1/11.
//  Copyright © 2018年 欣欣然. All rights reserved.
//

#import "XAlertController.h"

@implementation XAlertController

//MARK:- 弹窗
+ (void)showAlertWith:(NSString *)str{
	
	dispatch_async(dispatch_get_main_queue(), ^{
		
		[self alertControllerWithTitle:@"提示" message:str confirmButton:@"确定" cancelButton:nil confirmBlock:nil cancelBlock:nil];
	});
}

+ (void)showAlertWith:(NSString *)str confirm:(void(^)(void))aBlock{
	
	dispatch_async(dispatch_get_main_queue(), ^{
		
		[self alertControllerWithTitle:@"提示" message:str confirmButton:@"确定" cancelButton:nil confirmBlock:aBlock cancelBlock:nil];
	});
}

+ (void)showAlertWith:(NSString *)str confirm:(void(^)(void))afBlock cancel:(void(^)(void))ccBlock{
	
	dispatch_async(dispatch_get_main_queue(), ^{
		
		[self alertControllerWithTitle:@"提示" message:str confirmButton:@"确定" cancelButton:@"取消" confirmBlock:afBlock cancelBlock:ccBlock];
	});
}

//弹窗基础方法
+ (void)alertControllerWithTitle:(NSString *)title
						 message:(NSString *)message
				   confirmButton:(NSString *)confirmStr
					cancelButton:(NSString *)cancelStr
					confirmBlock:(void (^)(void))cfBlock
					 cancelBlock:(void (^)(void))ccBlock {
	
	UIViewController *controller = [XManager currentViewController];
	
	///判断当前界面是否为alertcontroller
	if ([controller isKindOfClass:[UIAlertController class]]) {
		
		UIAlertController *currAl = (UIAlertController *)controller;
		[currAl dismissViewControllerAnimated:YES completion:^{
			
			///上一个弹窗dismiss之后再弹出心的
			UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
																		   message:message
																	preferredStyle:UIAlertControllerStyleAlert];
			
			if (cancelStr) {
				
				[alert addAction:[UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)  {
					
					!ccBlock ?: ccBlock();
				}]];
			}
			
			[alert addAction:[UIAlertAction actionWithTitle:confirmStr style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
				
				!cfBlock ?: cfBlock();
			}]];
			
			///重新获取当前界面
			[[XManager currentViewController] presentViewController:alert animated:YES completion:nil];
		}];
	} else {
		
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
																	   message:message
																preferredStyle:UIAlertControllerStyleAlert];
		if (cancelStr) {
			
			[alert addAction:[UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)  {
				
				!ccBlock ?: ccBlock();
			}]];
		}
		
		[alert addAction:[UIAlertAction actionWithTitle:confirmStr style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
			
			if (cfBlock)  {
				
				cfBlock();
			}
		}]];
		[controller presentViewController:alert animated:YES completion:nil];
	}
}

+ (void)alertTextFiledWithTitle:(NSString *)title
						message:(NSString *)message
				  confirmButton:(NSString *)confirmStr
				   cancelButton:(NSString *)cancelStr
						 showIn:(UIViewController *)vcc
				 inputTextfield:(void (^)(UITextField *inputTF))inputBlock
				   confirmBlock:(void (^)(UITextField *inputTF))cfBlock
					cancelBlock:(void (^)(UITextField *inputTF))ccBlock{
	
	static UIAlertController  *alert = nil;
	if (alert) {
		[alert dismissViewControllerAnimated:YES completion:nil];
	}
	
	
	alert = [UIAlertController alertControllerWithTitle:title
												message:message
										 preferredStyle:UIAlertControllerStyleAlert];
	__weak typeof(alert)weakAlert = alert;
	
	[alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
		if (inputBlock) {
			inputBlock(textField);
		}
	}];
	[alert addAction:[UIAlertAction actionWithTitle:confirmStr
											  style:UIAlertActionStyleDestructive
											handler:^(UIAlertAction * _Nonnull action) {
												if (cfBlock)  {
													cfBlock((UITextField *)weakAlert.textFields.firstObject);
												}
											}]];
	
	if (cancelStr) {
		[alert addAction:[UIAlertAction actionWithTitle:cancelStr
												  style:UIAlertActionStyleDefault
												handler:^(UIAlertAction * _Nonnull    action)  {
													if (ccBlock)  {
														ccBlock((UITextField *)weakAlert.textFields.firstObject);
													}
												}]];
	}
	
	
	[vcc presentViewController:alert animated:YES completion:nil];
}


+ (void)showHUDWithString:(NSString *)str completion:(void(^)(void))completion{
	
	
}
@end
