//
//  NSString+Check.h
//  YiWei
//
//  Created by X.Melody on 17/5/2.
//  Copyright © 2017年 X.Melody. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)
    


/**
 字符串是否为空
 
 @return return value description
 */
- (BOOL)isEmptyString;



/**
 字符串是否纯整数字符

 @return return value description
 */
- (BOOL)isIntegerString;



/**
 是否为纯数字 带小数点

 @return return value description
 */
- (BOOL)isNunmberString;


/**
 字符串是否为汉字

 @return return value description
 */
-(BOOL)isChineseStr;



/**
 字符串是否为银行卡号

 @return return value description
 */
- (BOOL)isValidBankCardNumberString;



/**
 字符串是否为手机号码

 @return return value description
 */
- (BOOL)isValidPhoneNumberString;



/**
 字符串是否为身份证号码

 @return return value description
 */
- (BOOL)isValidIDCardNumberString;

@end
