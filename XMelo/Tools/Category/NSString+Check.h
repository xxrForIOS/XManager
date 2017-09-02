//
//  NSString+Check.h
//  YiWei
//
//  Created by X.Melody on 17/5/2.
//  Copyright © 2017年 X.Melody. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)
    


///字符串是否为空
- (BOOL)isEmptyString;

///字符串是否纯整数字符
- (BOOL)isIntegerString;

///是否为纯数字 带小数点
- (BOOL)isNunmberString;

///字符串是否为汉字
-(BOOL)isChineseStr;

///字符串是否为银行卡号
- (BOOL)isValidBankCardNumberString;

///字符串是否为手机号码
- (BOOL)isValidPhoneNumberString;

///字符串是否为身份证号码
- (BOOL)isValidIDCardNumberString;


///不区分大小写对比
- (BOOL)isSameCompareNoCaseWith:(NSString *)string;
@end
