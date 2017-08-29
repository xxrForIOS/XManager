//
//  XHead.h
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#ifndef XHead_h
#define XHead_h

#import "XImport.h"


///Log
#ifdef DEBUG
#define kLog(s, ...)        NSLog(@"%@",[NSString stringWithFormat:(s), ##__VA_ARGS__])
#define kLogError(s, ...)   NSLog(@"%s %@", __func__,[NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#endif

///value

#define kCellHeight         50






#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height

#define kIOSVersion         [[[UIDevice currentDevice] systemVersion] floatValue]
#define kIOS10              (kIOSVersion >= 10.0 && kIOSVersion < 11.0)
#define kIOS9               (kIOSVersion >= 9.0 && kIOSVersion < 10.0)
#define kIOS8               (kIOSVersion >= 8.0 && kIOSVersion < 9.0)
#define kAPPVersion         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kAPPBuild           [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


#define kFontTheme(f)       [UIFont fontWithName:@"Menlo" size:f]
#define kFontBold(f)        [UIFont boldSystemFontOfSize:f]



///image
#define kImageName(f,...)   [UIImage imageNamed:[NSString stringWithFormat:f,##__VA_ARGS__]]
#define kImageUrl(f,...)    [NSURL URLWithString:[NSString stringWithFormat:f,##__VA_ARGS__]]

///block
#define kWeakSelf           autoreleasepool{} __weak typeof(self) selfWeak = self;
#define kWeakObj(o)         autoreleasepool{} __weak typeof(o) o##Weak = o;

///userDefault
#define kUserDefault_set(__object, __key)\
({\
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];\
@synchronized([NSUserDefaults standardUserDefaults]){\
[defaults setObject:__object forKey:__key];\
[defaults synchronize];\
}\
})
#define kUserDefault_get(k)     [[NSUserDefaults standardUserDefaults] objectForKey:k]
#define kUserDefault_removeAll      [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]]
#define kUserDefault_remove(n) [[NSUserDefaults standardUserDefaults]removeObjectForKey:n]

///hud
#define kCurrentController      [UIApplication sharedApplication].keyWindow.rootViewController
#define kActivityHUDShowStr(s)  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:(kCurrentController).view  animated:YES];hud.label.text = s;[UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define kActivityHUDShow        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:(kCurrentController).view  animated:YES];hud.label.text = @"加载数据";[UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define kActivityHUDHidden      [MBProgressHUD hideHUDForView:(kCurrentController).view animated:YES];[UIApplication sharedApplication].networkActivityIndicatorVisible = NO

///simulator
#if TARGET_IPHONE_SIMULATOR
#define kSimulator 1
#elif TARGET_OS_IPHONE
#define kSimulator 0
#endif

#define kPush(pushFrom,pushTo)  [pushFrom.navigationController pushViewController:pushTo animated:YES]
//#define kOpenAliPay(code)       [[AlipaySDK defaultService] payOrder:code fromScheme:YVAliPaySchemeUrl callback:nil]

#define kStringFormat(f,...)    [NSString stringWithFormat:f,##__VA_ARGS__]


#define kContext            ((AppDelegate *)[UIApplication sharedApplication].delegate).persistentContainer.viewContext

#define kDelegate           (AppDelegate *)[[UIApplication sharedApplication] delegate]




#endif /* XHead_h */
