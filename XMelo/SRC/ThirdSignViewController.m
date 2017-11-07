//
//  ThirdSignViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/11/7.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ThirdSignViewController.h"
#import <JTCalendar/JTCalendar.h>
#import "<#header#>"
@interface ThirdSignViewController ()<JTCalendarDelegate>{
	NSMutableDictionary *_eventsByDate;

	NSDate *_dateSelected;
}

@property (strong, nonatomic) JTCalendarMenuView 			*calendarMenuView;
@property (strong, nonatomic) JTHorizontalCalendarView 		*calendarContentView;
@property (strong, nonatomic) JTCalendarManager  			*calendarManager;

@end

@implementation ThirdSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.view.backgroundColor = [UIColor whiteColor];

	self.calendarMenuView = [[JTCalendarMenuView alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth - 40, 40)];;
	[self.view addSubview:self.calendarMenuView];
	self.calendarMenuView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:<#(nullable id)#> action:<#(nullable SEL)#>]

	self.calendarContentView = [[JTHorizontalCalendarView alloc]initWithFrame:CGRectMake(20, self.calendarMenuView.maxY,
																						 kScreenWidth - 40, 300)];
	[self.view addSubview:self.calendarContentView];

	self.calendarManager = [JTCalendarManager new];
	self.calendarManager.delegate = self;
	self.calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
	self.calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
	[self.calendarManager setMenuView:self.calendarMenuView];
	[self.calendarManager setContentView:self.calendarContentView];
	[self.calendarManager setDate:[NSDate date]];




	// Generate random events sort by date using a dateformatter for the demonstration
	//	[self createRandomEvents];
}

//- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
//{
//	dayView.hidden = NO;
//
//	// Other month
//	if([dayView isFromAnotherMonth]){
//		dayView.hidden = YES;
//	}
//	// Today
//	else if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
//		dayView.circleView.hidden = NO;
//		dayView.circleView.backgroundColor = [UIColor blueColor];
//		dayView.dotView.backgroundColor = [UIColor whiteColor];
//		dayView.textLabel.textColor = [UIColor whiteColor];
//	}
//	// Selected date
//	else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
//		dayView.circleView.hidden = NO;
//		dayView.circleView.backgroundColor = [UIColor redColor];
//		dayView.dotView.backgroundColor = [UIColor whiteColor];
//		dayView.textLabel.textColor = [UIColor whiteColor];
//	}
//	// Another day of the current month
//	else{
//		dayView.circleView.hidden = YES;
//		dayView.dotView.backgroundColor = [UIColor redColor];
//		dayView.textLabel.textColor = [UIColor blackColor];
//	}
//
////	if([self haveEventForDay:dayView.date]){
////		dayView.dotView.hidden = NO;
////	}
////	else{
////		dayView.dotView.hidden = YES;
////	}
//}
//
////- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
////{
////	_dateSelected = dayView.date;
////
////	// Animation for the circleView
////	dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
////	[UIView transitionWithView:dayView
////					  duration:.3
////					   options:0
////					animations:^{
////						dayView.circleView.transform = CGAffineTransformIdentity;
////						[_calendarManager reload];
////					} completion:nil];
////
////
////	// Don't change page in week mode because block the selection of days in first and last weeks of the month
////	if(_calendarManager.settings.weekModeEnabled){
////		return;
////	}
////
////	// Load the previous or next page if touch a day from another month
////
////	if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
////		if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
////			[_calendarContentView loadNextPageWithAnimation];
////		}
////		else{
////			[_calendarContentView loadPreviousPageWithAnimation];
////		}
////	}
////}
//
//#pragma mark - Views customization
//
//- (UIView *)calendarBuildMenuItemView:(JTCalendarManager *)calendar
//{
//	UILabel *label = [UILabel new];
//
//	label.textAlignment = NSTextAlignmentCenter;
//	label.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
//
//	return label;
//}
//
//- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
//{
//	static NSDateFormatter *dateFormatter;
//	if(!dateFormatter){
//		dateFormatter = [NSDateFormatter new];
//		dateFormatter.dateFormat = @"MMMM yyyy";
//
//		dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
//		dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
//	}
//
//	menuItemView.text = [dateFormatter stringFromDate:date];
//}
//
//- (UIView<JTCalendarWeekDay> *)calendarBuildWeekDayView:(JTCalendarManager *)calendar
//{
//	JTCalendarWeekDayView *view = [JTCalendarWeekDayView new];
//
//	for(UILabel *label in view.dayViews){
//		label.textColor = [UIColor blackColor];
//		label.font = [UIFont fontWithName:@"Avenir-Light" size:14];
//	}
//
//	return view;
//}
//
//- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar
//{
//	JTCalendarDayView *view = [JTCalendarDayView new];
//
//	view.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:13];
//
//	view.circleRatio = .8;
//	view.dotRatio = 1. / .9;
//
//	return view;
//}

#pragma mark - Fake data

// Used only to have a key for _eventsByDate
//- (NSDateFormatter *)dateFormatter
//{
//	static NSDateFormatter *dateFormatter;
//	if(!dateFormatter){
//		dateFormatter = [NSDateFormatter new];
//		dateFormatter.dateFormat = @"dd-MM-yyyy";
//	}
//
//	return dateFormatter;
//}
//
//- (BOOL)haveEventForDay:(NSDate *)date
//{
//	NSString *key = [[self dateFormatter] stringFromDate:date];
//
//	if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
//		return YES;
//	}
//
//	return NO;
//
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
