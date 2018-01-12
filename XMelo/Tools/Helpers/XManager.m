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
	[theButton addClick:aBlock];
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
