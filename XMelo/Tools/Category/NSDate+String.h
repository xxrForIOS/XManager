//
//  NSDate+String.h
//  XMelo
//
//  Created by melo on 2017/12/19.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <Foundation/Foundation.h>

///时间显示格式
typedef NS_ENUM(NSInteger, XRDateFormatType) {
	
	///2017-12-20 15:54:10
	XRDateFormatTypeYMDHMS = 0,
	///2017-12-20 15:54
	XRDateFormatTypeYMDHM = 1,
	///12-20 15:54
	XRDateFormatTypeMDHM = 2,
	//15:54
	XRDateFormatTypeHM = 3,
};
@interface NSDate (String)

///转换毫秒单位时间戳 13位
- (NSString *)toTimestampString;

///获取距今时间段的时间戳
- (NSString *)getTimeStampStringSineNow:(NSTimeInterval)time;

///获取周几
- (NSString *)getWeekdayString;

///获取年月日model
- (NSDateComponents *)getComponent;

///获取时间距今表达
- (NSString *)getFormatStringBeforeNow;

///获取时间表达字符串
- (NSString *)getFormatStringWithType:(XRDateFormatType)type;

///指定格式获取时间表达字符串
- (NSString *)getFormatStringWithCustomFormat:(NSString *)type;


@end






@interface NSString (Date)

///时间戳转化date对象
- (NSDate *)toDate;

@end
