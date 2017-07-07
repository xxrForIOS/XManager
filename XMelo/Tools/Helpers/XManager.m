//
//  XManager.m
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XManager.h"

@implementation XManager


#pragma mark- Singleton 单例
+ (XManager *)sharedManager{
    
    static XManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedManager = [[XManager alloc]init];
    });
    return _sharedManager;
}


#pragma mark- 纯色图片
+ (UIImage *)getImageFromColor:(UIColor *)color withSize:(CGSize)size{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


+ (UIImage *)getImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}

#pragma mark- 时间格式化
+ (NSString *)timeGetDateFormat:(NSString *)dateString{
    
    NSDate *currentDate = [NSDate date];
    NSDate *otherDate = [NSDate dateWithTimeIntervalSince1970:[dateString longLongValue]/1000];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    
    NSTimeInterval time = [currentDate timeIntervalSinceDate:otherDate];
    
    
    NSString *dateStr = @"";
    
    if (time <= 60) {
        
        dateStr = @"刚刚";
    }else if(time <= 60 * 60){
        
        dateStr = [NSString stringWithFormat:@"%d分钟前",(int)time/60];
    }else if(time <= 60 * 60 * 24){
        
        [dateFormat setDateFormat:@"YYYY/MM/dd"];
        NSString *otherDay = [dateFormat stringFromDate:otherDate];
        NSString *currentDay = [dateFormat stringFromDate:currentDate];
        [dateFormat setDateFormat:@"HH:mm"];
        
        if ([otherDay isEqualToString:currentDay]) {
            
            dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormat stringFromDate:otherDate]];
        }else{
            
            dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormat stringFromDate:otherDate]];
        }
    }else {
        
        [dateFormat setDateFormat:@"yyyy"];
        NSString    *otherYear = [dateFormat stringFromDate:otherDate];
        NSString    *currentYear = [dateFormat stringFromDate:currentDate];
        
        if ([otherYear isEqualToString:currentYear]) {
            
            [dateFormat setDateFormat:@"MM-dd HH:mm"];
            dateStr = [dateFormat stringFromDate:otherDate];
        }else{
            
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
            dateStr = [dateFormat stringFromDate:otherDate];
        }
    }
    
    return dateStr;
}


#pragma makr- 弹窗
+ (void)alertControllerWithTitle:(NSString *)title
                         message:(NSString *)message
                   confirmButton:(NSString *)confirmStr
                    cancelButton:(NSString *)cancelStr
                          showIn:(UIViewController *)vcc
                    confirmBlock:(void (^)())cfBlock
                     cancelBlock:(void (^)())ccBlock {
    static UIAlertController  *alert = nil;
    if (alert) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }
    alert = [UIAlertController alertControllerWithTitle:title
                                                message:message
                                         preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelStr) {
        [alert addAction:[UIAlertAction actionWithTitle:cancelStr
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull    action)  {
                                                    if (ccBlock)  {
                                                        ccBlock();
                                                    }
                                                }]];
    }
    
    
    [alert addAction:[UIAlertAction actionWithTitle:confirmStr
                                              style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                if (cfBlock)  {
                                                    cfBlock();
                                                }
                                            }]];
    
    [vcc presentViewController:alert animated:YES completion:nil];
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


+ (void)showAlertWith:(NSString *)str confirm:(void(^)())aBlock{
    
    //    NSArray *array = [[UIApplication sharedApplication] windows];
    UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if (rootController == nil) {
        rootController = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
    }
    
    [self   alertControllerWithTitle:@"提示"
                             message:str
                       confirmButton:@"知道了"
                        cancelButton:nil
                              showIn:rootController
                        confirmBlock:aBlock
                         cancelBlock:nil];
    
    
}

+ (void)showAlertWith:(NSString *)str{
    
    [self showAlertWith:str  confirm:nil];
}

#pragma mark- 调用打电话
+ (void)callWithWithNumber:(NSString *)number{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]];
    if (kIOSVersion < 10.0) {
        [[UIApplication sharedApplication] openURL:url];
    }else{
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            
            if (!success) {
                kLog(@"调用打电话出错");
            }
        }];
    }
}

#pragma mark- gcd
+ (void)dispatchAfter:(int)interval timeout:(void(^)())timerOut {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        timerOut();
    });
}

+ (void)dispatchAsynac:(void(^)())asyncBlock mainQueue:(void(^)())mainBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        asyncBlock();
        dispatch_async(dispatch_get_main_queue(), ^{
            
            mainBlock();
        });
    });
}

@end
