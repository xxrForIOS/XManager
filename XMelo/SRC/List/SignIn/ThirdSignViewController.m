//
//  ThirdSignViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/11/7.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ThirdSignViewController.h"
#import <JTCalendar/JTCalendar.h>

@interface ThirdSignViewController ()<JTCalendarDelegate>{
	NSMutableDictionary *_eventsByDate;

	NSDate *_dateSelected;
}

@property (strong, nonatomic) NSDate *Recordtime;


@property (strong, nonatomic) JTCalendarMenuView 			*calendarMenuView;
@property (strong, nonatomic) JTHorizontalCalendarView 		*calendarContentView;
@property (strong, nonatomic) JTCalendarManager  			*calendarManager;

@end

@implementation ThirdSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.view.backgroundColor = [UIColor whiteColor];

	self.Recordtime = [NSDate date];

	self.calendarMenuView = [[JTCalendarMenuView alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth - 40, 40)];;
	[self.view addSubview:self.calendarMenuView];
	[self.calendarMenuView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeContentPage)]];


	self.calendarContentView = [[JTHorizontalCalendarView alloc]initWithFrame:CGRectMake(20, self.calendarMenuView.bottom,
																						 kScreenWidth - 40, 300)];
	[self.view addSubview:self.calendarContentView];

	[self createRandomEvents];


	self.calendarManager = [JTCalendarManager new];
	self.calendarManager.delegate = self;
	self.calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
	self.calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
	[self.calendarManager setMenuView:self.calendarMenuView];
	[self.calendarManager setContentView:self.calendarContentView];
	[self.calendarManager setDate:self.Recordtime];



	// Generate random events sort by date using a dateformatter for the demonstration
}

- (void)changeContentPage {

	//通过系统的日历类来计算时间
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *comps = nil;
	//设置需要变更的时间，年，月，日，
	comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self.Recordtime];
	NSDateComponents *adcomps = [[NSDateComponents alloc] init];
	//因为我们只需要切换月份，所有直接把月数+1就可，其他为0
//	[adcomps setYear:0];
	[adcomps setMonth:+1];
//	[adcomps setDay:0];
	//获得增加后的时间并记录起来
	self.Recordtime = [calendar dateByAddingComponents:adcomps toDate:_Recordtime options:0];
	//设置日历当前显示的时间
	[self.calendarManager setDate:self.Recordtime];
	//刷新日历
//	[self.calendarContentView ];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar//下个月
{
	//    NSLog(@"Next page loaded");

	//[self loadData:[calendar date] andChangePage:YES];//从服务器请求下个月的事件

	//[self refreshCalendar:[calendar date]];

	self.Recordtime = calendar.date;
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar//上个月
{

	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"yyyy-MM"];
	NSDate *newDate = [NSDate date];
	double interval = 0;
	NSDate *beginDate = nil;
	NSDate *endDate = nil;
	NSCalendar *calendar1 = [NSCalendar currentCalendar];
	[calendar1 setFirstWeekday:2];//设定周一为周首日
	if ([calendar1 rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate]) {
		endDate = [beginDate dateByAddingTimeInterval:interval-1];
	}

	self.Recordtime = calendar.date;
}

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
	dayView.hidden = NO;

	// Other month
	if([dayView isFromAnotherMonth]){
		dayView.hidden = YES;
	}
	// Today
	else if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
		dayView.circleView.hidden = NO;
		dayView.circleView.backgroundColor = [UIColor blueColor];
		dayView.dotView.backgroundColor = [UIColor whiteColor];
		dayView.textLabel.textColor = [UIColor whiteColor];
	}
	// Selected date
	else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
		dayView.circleView.hidden = NO;
		dayView.circleView.backgroundColor = [UIColor redColor];
		dayView.dotView.backgroundColor = [UIColor whiteColor];
		dayView.textLabel.textColor = [UIColor whiteColor];
	}
	// Another day of the current month
	else{
		dayView.circleView.hidden = YES;
		dayView.dotView.backgroundColor = [UIColor redColor];
		dayView.textLabel.textColor = [UIColor blackColor];
	}

	if([self haveEventForDay:dayView.date]){
//		dayView.dotView.hidden = NO;

		dayView.circleView.hidden = NO;
		dayView.circleView.backgroundColor = [UIColor redColor];
		dayView.dotView.backgroundColor = [UIColor whiteColor];
		dayView.textLabel.textColor = [UIColor whiteColor];
	}
	else{
		dayView.dotView.hidden = YES;
	}


	if ([self isSameDay:[self currentMouthEndDay] date2:dayView.date]) {

		dayView.circleView.hidden = NO;
		dayView.circleView.backgroundColor = [UIColor yellowColor];
		dayView.dotView.backgroundColor = [UIColor whiteColor];
		dayView.textLabel.textColor = [UIColor whiteColor];
	}
}

- (NSDate *)currentMouthEndDay{

	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"yyyy-MM"];
	NSDate *newDate = [NSDate date];
	double interval = 0;
	NSDate *beginDate = nil;
	NSDate *endDate = nil;
	NSCalendar *calendar1 = [NSCalendar currentCalendar];
	[calendar1 setFirstWeekday:2];//设定周一为周首日
	if ([calendar1 rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate]) {

		endDate = [beginDate dateByAddingTimeInterval:interval-1];
	}
	return endDate;
}




- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
	_dateSelected = dayView.date;

	if(![_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]) {

		return;
	}

	// Animation for the circleView
	dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
	[UIView transitionWithView:dayView
					  duration:.3
					   options:0
					animations:^{
						dayView.circleView.transform = CGAffineTransformIdentity;
						[_calendarManager reload];
					} completion:nil];


	// Don't change page in week mode because block the selection of days in first and last weeks of the month
	if(_calendarManager.settings.weekModeEnabled){
		return;
	}

	// Load the previous or next page if touch a day from another month

	if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
		if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
			[_calendarContentView loadNextPageWithAnimation];
		}
		else{
			[_calendarContentView loadPreviousPageWithAnimation];
		}
	}
}
//
//#pragma mark - Views customization
- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
	static NSDateFormatter *dateFormatter;
	if(!dateFormatter){
		dateFormatter = [NSDateFormatter new];
		dateFormatter.dateFormat = @"yyyy MMMM";

		dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
		dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
	}

	menuItemView.text = [dateFormatter stringFromDate:date];
}



#pragma mark - Fake data

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
	static NSDateFormatter *dateFormatter;
	if(!dateFormatter){
		dateFormatter = [NSDateFormatter new];
		dateFormatter.dateFormat = @"dd-MM-yyyy";
	}

	return dateFormatter;
}

//两个日期是不是同一天
- (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
	NSCalendar* calendar = [NSCalendar currentCalendar];

	unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
	NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
	NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];

	return [comp1 day]   == [comp2 day] &&
	[comp1 month] == [comp2 month] &&
	[comp1 year]  == [comp2 year];
}

- (BOOL)haveEventForDay:(NSDate *)date
{
	NSString *key = [[self dateFormatter] stringFromDate:date];


	if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
		return YES;
	}

	return NO;

}

- (void)createRandomEvents
{
	_eventsByDate = [NSMutableDictionary new];

	for(int i = 0; i < 30; ++i){
		// Generate 30 random dates between now and 60 days later
		NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];

		// Use the date as key for eventsByDate
		NSString *key = [[self dateFormatter] stringFromDate:randomDate];

		if(!_eventsByDate[key]){
			_eventsByDate[key] = [NSMutableArray new];
		}

		[_eventsByDate[key] addObject:randomDate];
	}
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
