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

//MARK:- 获取当前界面所在vc
+ (UIViewController *)currentViewController{
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

//MARK:- 弹窗
+ (void)showAlertWith:(NSString *)str{
        
    [self alertControllerWithTitle:@"提示" message:str confirmButton:@"确定" cancelButton:nil confirmBlock:nil cancelBlock:nil];
}

+ (void)showAlertWith:(NSString *)str confirm:(void(^)())aBlock{
    
    [self alertControllerWithTitle:@"提示" message:str confirmButton:@"确定" cancelButton:nil confirmBlock:aBlock cancelBlock:nil];
}

+ (void)showAlertWith:(NSString *)str confirm:(void(^)())afBlock cancel:(void(^)())ccBlock{
    
    [self alertControllerWithTitle:@"提示" message:str confirmButton:@"确定" cancelButton:@"取消" confirmBlock:afBlock cancelBlock:ccBlock];
}

//弹窗基础方法
+ (void)alertControllerWithTitle:(NSString *)title
                         message:(NSString *)message
                   confirmButton:(NSString *)confirmStr
                    cancelButton:(NSString *)cancelStr
                    confirmBlock:(void (^)())cfBlock
                     cancelBlock:(void (^)())ccBlock {
    
    UIViewController *controller = [self currentViewController];
    
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
                
                if (cfBlock)  {
                    
                    cfBlock();
                }
            }]];
            
            ///重新获取当前界面
            [[self currentViewController] presentViewController:alert animated:YES completion:nil];
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


+ (void)showHUDWithString:(NSString *)str completion:(void(^)())completion{
    
    UIView *theView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:theView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = str;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (completion) {
            
            [MBProgressHUD hideHUDForView:theView animated:YES];
            completion();
        }
    });
}



#pragma mark- 调用打电话
+ (void)callWithNumber:(NSString *)number{
    
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

//MARK:- 导航条右上角添加文字按钮
+ (void)addRightBarItemInViewController:(UIViewController *)vcc itemTitle:(NSString *)str andItemBlock:(void(^)(UIButton *aButton))aBlock{
    CGFloat width = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 60)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName : kFontTheme(17)}
                                      context:nil].size.width;
    
    UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
    theButton.frame = CGRectMake(0, 2, width, 60);
    [theButton setTitle:str forState:UIControlStateNormal];
    [theButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    theButton.titleLabel.font = kFontTheme(17);
    [theButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        if (aBlock) {
            UIButton *button = (UIButton *)sender;
            aBlock(button);
        }
    }];
    vcc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:theButton];
}

//MARK:- gcd
+ (void)dispatchAfter:(int)time completion:(void(^)())completion {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        !completion ?: completion();
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

//MARK:- 时间格式化
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

+ (NSString *)timeGetDateFormat:(NSString *)dateString format:(XRDateFormatType)type {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    switch (type) {
        case XRDateFormatTypeYMDHM:
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case XRDateFormatTypeMDHM:
            [dateFormat setDateFormat:@"MM-dd HH:mm"];
            break;
            
        case XRDateFormatTypeHM:
            [dateFormat setDateFormat:@"HH分mm秒"];
            break;
            
        default:
            break;
    }
    
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]]; //Asia/shanghai +8:00
    int64_t timestamp = [dateString longLongValue]/1000 ;//毫秒级别除以1000
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *str = [dateFormat stringFromDate:date];
    return str;
}

+ (NSString *)timeGetTimeStampSinceNow{
    
    return [self timeGetTimeStampSinceNow:0];
}

+ (NSString *)timeGetTimeStampSinceNow:(int)second{
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:second];
    NSTimeInterval time = [date timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
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
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

@end
