//
//  NSDate+LYWCalendar_h.m
//  XMelo
//
//  Created by X.Melo on 2017/11/7.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "NSDate+LYWCalendar_h.h"

@implementation NSDate (LYWCalendar_h)



#pragma mark -- 获取日
- (NSInteger)day:(NSDate *)date{
	NSDateComponents *components = [[NSCalendar currentCalendar]components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)fromDate:date];
	return components.day;
}

#pragma mark -- 获取月
- (NSInteger)month:(NSDate *)date{
	NSDateComponents *components = [[NSCalendar currentCalendar]components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)fromDate:date];
	return components.month;
}

#pragma mark -- 获取年
- (NSInteger)year:(NSDate *)date{
	NSDateComponents *components = [[NSCalendar currentCalendar]components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)fromDate:date];
	return components.year;
}

#pragma mark -- 获得当前月份第一天星期几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	//设置每周的第一天从周几开始,默认为1,从周日开始
	[calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
	NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay) fromDate:date];
	[comp setDay:1];
	NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
	NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
	//若设置从周日开始算起则需要减一,若从周一开始算起则不需要减
	return firstWeekday -1;
}
#pragma mark -- 获取当前月共有多少天

- (NSInteger)totaldaysInMonth:(NSDate *)date{

	NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
	return daysInLastMonth.length;
}
@end
