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

#endif /* XHead_h */
