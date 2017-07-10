//
//  XManager.m
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XManager.h"
#import "sys/utsname.h"

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



#pragma mark- 获取设备名
+ (NSString *)getDeviceName
{
    // 需要#import "sys/utsname.h"
    //http://www.jianshu.com/p/b23016bb97af
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

@end
