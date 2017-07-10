//
//  XHead.h
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#ifndef XHead_h
#define XHead_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "XColorHead.h"
#import "XConst.h"
#import "XManager.h"

#import "UIGestureRecognizer+Block.h"
#import "UIControl+Block.h"
#import "UIView+Add.h"
#import "UITextView+Rich.h"
#import "UILabel+Frame.h"
#import "UIImage+Scale.h"
#import "NSString+Add.h"
#import "NSString+Check.h"
#import "NSData+Add.h"
#import "UITextView+ZWPlaceHolder.h"

#pragma mark- LOG
#ifdef DEBUG

#else
#endif

#define kLog(s, ...)        NSLog(@"%@",[NSString stringWithFormat:(s), ##__VA_ARGS__])
#define kLogError(s, ...)   NSLog(@"%s %@", __func__,[NSString stringWithFormat:(s), ##__VA_ARGS__])

#pragma mark- SCREEN
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height
#define kFont(f)            [UIFont systemFontOfSize:f]
#define kFontBold(f)        [UIFont boldSystemFontOfSize:f]
#define kImageName(n)       [UIImage imageNamed:n]
#define kWeakSelf           autoreleasepool{} __weak typeof(self) selfWeak = self;


#pragma mark- VALUE
#define kIOSVersion         [[[UIDevice currentDevice] systemVersion] floatValue]
#define kIOSVersion10       (kIOSVersion >= 10.0 && kIOSVersion < 11.0)
#define kAPPVersion         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kAPPBuild           [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height
#define kIsNil(o)           (((o) == nil) || ([(o) isEqual:[NSNull null]]))
#define kStringFormat(f,...)[NSString stringWithFormat:f,##__VA_ARGS__]


#pragma mark- USERDEFAULT
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

#pragma mark- 判断是否模拟器
#if TARGET_IPHONE_SIMULATOR
#define kSimulator 1
#elif TARGET_OS_IPHONE
#define kSimulator 0
#endif



#endif /* XHead_h */
