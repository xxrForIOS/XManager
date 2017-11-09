//
//  NSString+Add.h
//  YiWeiZD
//
//  Created by X.Melody on 17/5/3.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Add)


/**
 转化data

 @return 转化后的data对象
 */
-(NSData *)toData;

/**
 aes加密

 @return 加密字符串
 */
- (NSString *)toAESEncrypt;


/**
 aes解密

 @return 加密字符串
 */
- (NSString *)toAESDecrypt;

+ (BOOL) empty:(id)obj;
@end
