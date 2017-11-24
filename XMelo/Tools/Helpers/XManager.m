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

+ (void)addRradualColorFor:(UIView *)theView colors:(NSArray *)colors showType:(YVRradualColorShowType)type {

	/*
	 layer.colors = @[(__bridge id)[UIColor redColor].CGColor,
	 (__bridge id)[UIColor yellowColor].CGColor,
	 (__bridge id)[UIColor blueColor].CGColor];
	 */
	CAGradientLayer *layer 	= [[CAGradientLayer alloc] init];
	layer.frame 			= theView.bounds;
	layer.colors 			= colors;
	
	if (type == YVRradualColorShowTypeLeftRight) {
		
		[layer setStartPoint:CGPointMake(0, 0.5)];
		[layer setEndPoint:CGPointMake(1, 0.5)];
	}
	
	if (type == YVRradualColorShowTypeTopBottom) {
		
		[layer setStartPoint:CGPointMake(0.5, 0)];
		[layer setEndPoint:CGPointMake(0.5, 1.0)];
	}
	
	if (type == YVRradualColorShowTypeLTopToRBottom) {
		
		[layer setStartPoint:CGPointMake(0, 0)];
		[layer setEndPoint:CGPointMake(1, 1)];
	}
	
	if (type == YVRradualColorShowTypeLBottomToRTop) {
		
		[layer setStartPoint:CGPointMake(0, 1)];
		[layer setEndPoint:CGPointMake(1, 0)];
	}
	[theView.layer addSublayer:layer];
}

#pragma mark- 纯色图片
+ (UIImage *)getImageFromColor:(UIColor *)color withSize:(CGSize)size{
    
    CGRect rect 			= CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context	= UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage		= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)getImageFromColor:(UIColor *)color{
	
	return [self getImageFromColor:color withSize:CGSizeMake(kScreenWidth, kScreenHeight)];
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

+ (void)showAlertWith:(NSString *)str confirm:(void(^)(void))aBlock{
    
    [self alertControllerWithTitle:@"提示" message:str confirmButton:@"确定" cancelButton:nil confirmBlock:aBlock cancelBlock:nil];
}

+ (void)showAlertWith:(NSString *)str confirm:(void(^)(void))afBlock cancel:(void(^)(void))ccBlock{
    
    [self alertControllerWithTitle:@"提示" message:str confirmButton:@"确定" cancelButton:@"取消" confirmBlock:afBlock cancelBlock:ccBlock];
}

//弹窗基础方法
+ (void)alertControllerWithTitle:(NSString *)title
                         message:(NSString *)message
                   confirmButton:(NSString *)confirmStr
                    cancelButton:(NSString *)cancelStr
                    confirmBlock:(void (^)(void))cfBlock
                     cancelBlock:(void (^)(void))ccBlock {
    
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


+ (void)showHUDWithString:(NSString *)str completion:(void(^)(void))completion{
    

}



#pragma mark- 调用打电话
+ (void)callWithNumber:(NSString *)number{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]];
	[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {

		if (!success) {
			NSLog(@"调用打电话出错");
		}
	}];
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
	[theButton addTouchUpInside:aBlock];
    vcc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:theButton];
}

//MARK:- gcd
+ (void)dispatchAfter:(int)time completion:(void(^)(void))completion {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        !completion ?: completion();
    });
}

+ (void)dispatchAsynac:(void(^)(void))asyncBlock mainQueue:(void(^)(void))mainBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        asyncBlock();
        dispatch_async(dispatch_get_main_queue(), ^{
            
            mainBlock();
        });
    });
}

//MARK:- 时间格式化
+ (NSString *)timeGetDateFormat:(NSString *)dateString{
    
    NSDate *currentDate 		= [NSDate date];
    NSDate *otherDate 			= [NSDate dateWithTimeIntervalSince1970:[dateString longLongValue]/1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    NSTimeInterval time 		= [currentDate timeIntervalSinceDate:otherDate];
	
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

+ (NSString*)weekDayStr{
    
    NSString *weekDayStr = nil;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSString *str = [self description];
    if (str.length >= 10) {
        NSString *nowString = [str substringToIndex:10];
        NSArray *array = [nowString componentsSeparatedByString:@"-"];
        if (array.count == 0) {
            array = [nowString componentsSeparatedByString:@"/"];
        }
        if (array.count >= 3) {
            
            [comps setYear:[[array objectAtIndex:0] integerValue]];
            [comps setMonth:[[array objectAtIndex:1] integerValue]];
            [comps setDay:[[array objectAtIndex:2] integerValue]];
        }
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *_date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger week = [weekdayComponents weekday];
	NSArray *weekStrs = @[@"星期日, 星期一, 星期二, 星期三, 星期四, 星期五, 星期六"];
	return weekStrs[week - 1];
}


+ (NSString *)weekdayString{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:[NSDate date]];
    NSString *currentString = [weekdays objectAtIndex:theComponents.weekday];
    return currentString;
}


@end
