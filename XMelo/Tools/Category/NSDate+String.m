//
//  NSDate+String.m
//  XMelo
//
//  Created by melo on 2017/12/19.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "NSDate+String.h"

@implementation NSDate (String)

#pragma mark- 时间戳
- (NSString *)toTimestampString {

	NSTimeInterval time = [self timeIntervalSince1970] * 1000.0;
	NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
	return timeString;
}

- (NSString *)getTimeStampStringSineNow:(NSTimeInterval)time{
	
	NSDate *date = [NSDate dateWithTimeIntervalSinceNow:time];
	return [date toTimestampString];
}

#pragma mark- 获取周几
- (NSString *)getWeekdayString{
	
	NSArray *weekdays 		= @[@"",@"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
	NSCalendar *calendar 	= [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSTimeZone *timeZone 	= [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
	[calendar setTimeZone:timeZone];
	NSCalendarUnit calendarUnit 	= NSCalendarUnitWeekday;
	NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
	NSString *weekDayString 		= [weekdays objectAtIndex:theComponents.weekday];
	return weekDayString;
}

- (NSDateComponents *)getComponent {
	
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
	NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
	return comps;
}

#pragma mark- 时间格式
- (NSString *)getFormatStringBeforeNow{
	
	NSDate *currentDate 		= [NSDate date];
	NSDate *otherDate 			= self;
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	NSTimeInterval time 		= [currentDate timeIntervalSinceDate:otherDate];
	
	[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
	[dateFormat setTimeZone:[NSTimeZone localTimeZone]];
	
	NSString *dateStr = @"";
	if (time <= 60) {
		
		dateStr = @"刚刚";
	}else if(time <= 60 * 60){
		
		dateStr = [NSString stringWithFormat:@"%d分钟前",(int)time/60];
	}else if(time <= 60 * 60 * 24){
		
		[dateFormat setDateFormat:@"YYYY/MM/dd"];
		NSString *otherDay = [dateFormat stringFromDate:otherDate];
		NSString *currentDay = [dateFormat stringFromDate:currentDate];
		[dateFormat setDateFormat:@"HH:mm"];
		
		if ([otherDay isEqualToString:currentDay]) {
			
			dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormat stringFromDate:otherDate]];
		}else{
			
			dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormat stringFromDate:otherDate]];
		}
	}else {
		
		[dateFormat setDateFormat:@"yyyy"];
		NSString    *otherYear = [dateFormat stringFromDate:otherDate];
		NSString    *currentYear = [dateFormat stringFromDate:currentDate];
		
		if ([otherYear isEqualToString:currentYear]) {
			
			[dateFormat setDateFormat:@"MM-dd HH:mm"];
			dateStr = [dateFormat stringFromDate:otherDate];
		}else{
			
			[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
			dateStr = [dateFormat stringFromDate:otherDate];
		}
	}
	return dateStr;
}

- (NSString *)getFormatStringWithType:(XRDateFormatType)type {
	
	NSDate *date = self;

	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	switch (type) {
			
		case XRDateFormatTypeYMDHMS: 	[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; break;
		case XRDateFormatTypeYMDHM: 	[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"]; break;
		case XRDateFormatTypeMDHM: 		[dateFormat setDateFormat:@"MM-dd HH:mm"]; break;
		case XRDateFormatTypeHM: 		[dateFormat setDateFormat:@"HH分mm秒"]; break;
			
		default:
			break;
	}
	
//	[dateFormat setTimeZone:[NSTimeZone localTimeZone]];
	[dateFormat setTimeZone:[[NSTimeZone alloc] initWithName:@"Asia/Shanghai"]];
	NSString *str = [dateFormat stringFromDate:date];
	return str;
}

- (NSString *)getFormatStringWithCustomFormat:(NSString *)type {
	
	NSDate *date = self;
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:type];
	[dateFormat setTimeZone:[[NSTimeZone alloc] initWithName:@"Asia/Shanghai"]];
	NSString *str = [dateFormat stringFromDate:date];
	return str;
}

@end





@implementation NSString (Date)

- (NSDate *)toDate {
	
	if (self.length == 13) {
		
		return [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000.0];
	} else if (self.length == 10) {
		
		return [NSDate dateWithTimeIntervalSince1970:[self longLongValue]];
	} else {
		
		YVLog(@"date格式不对啊");
		return nil;
	}
}

@end
