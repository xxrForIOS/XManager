//
//  NSString+Check.h
//  YiWei
//
//  Created by X.Melody on 17/5/2.
//  Copyright © 2017年 X.Melody. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)
    


///判断非空
+ (BOOL)isEmpty:(id)obj;

///字符串是否纯整数字符
- (BOOL)isInteger;

///是否为纯数字 带小数点
- (BOOL)isNunmber;

///字符串是否为汉字
-(BOOL)isChinese;

///字符串是否为银行卡号
- (BOOL)isBankCardNumber;

///字符串是否为手机号码
- (BOOL)isPhoneNumber;

///字符串是否为身份证号码
- (BOOL)isIDCardNumber;

///不区分大小写对比
- (BOOL)isSameCompareNoCaseWith:(NSString *)string;
@end
