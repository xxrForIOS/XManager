//
//  NSString+Add.h
//  YiWeiZD
//
//  Created by X.Melody on 17/5/3.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Add)

///转化data
-(NSData *)toData;

///aes加密
- (NSString *)toAESEncrypt;

///aes解密
- (NSString *)toAESDecrypt;


///获取指定字符串处于自身位置
- (NSRange)getRangeWithString:(NSString *)str;

///获取指定长度随机字符串
+ (NSString *)randomString:(int)length;

- (NSString *)idNumberHidden;

@end
