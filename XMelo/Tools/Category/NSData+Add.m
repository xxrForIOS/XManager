//
//  NSData+Add.m
//  YiWeiZD
//
//  Created by X.Melody on 17/5/3.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import "NSData+Add.h"
#import <CommonCrypto/CommonDigest.h>//md5需要
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (Add)

#pragma mark- 转化string
- (NSString *) toString {
    NSAssert(self != nil, @"不能为空");
    NSString *aStr = [[NSString alloc] initWithData:self
                                           encoding:NSUTF8StringEncoding];
    if (![aStr isKindOfClass:[NSString class]]) {

        NSLogError(@"解析不成功");
        return nil;
    }
    return aStr;
}

@end
