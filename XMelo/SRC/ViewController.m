//
//  ViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ViewController.h"
#import "XListViewController.h"




#import "DictModel.h"
#import <MJExtension/MJExtension.h>

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = kColorIceBlue1;//[UIColor randomColor];
	
	
	@kWeakSelf;
	
//	BOOL isGoList = YES;
	BOOL isGoList = NO;

	if (isGoList) {
		
		[self.view addTap:^(UIGestureRecognizer *tap) {
			
			[selfWeak goPresentViewController];
		}];
	} else {
		
		[selfWeak functionForTest];
	}
}

- (void)goPresentViewController {
	
	XListViewController *vcc 	= [[XListViewController alloc]init];
	vcc.type 					= XRCellAnimationTypeOverTurn;
	UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vcc];
	[self presentViewController:nav animated:YES completion:nil];
}

+ (BOOL)validateIDCardNumber:(NSString *)value {
	value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	NSUInteger length = 0;
	if (!value) {
		return NO;
	}else {
		length = value.length;
		
		if (length !=15 && length !=18) {
			return NO;
		}
	}
	// 省份代码
	NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
	
	NSString *valueStart2 = [value substringToIndex:2];
	BOOL areaFlag =NO;
	for (NSString *areaCode in areasArray) {
		if ([areaCode isEqualToString:valueStart2]) {
			areaFlag =YES;
			break;
		}
	}
	
	if (!areaFlag) {
		return YES;
	}
	
	
	NSRegularExpression *regularExpression;
	NSUInteger numberofMatch;
	
	int year =0;
	switch (length) {
		case 15:
			year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
			
			if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
				
				regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
																		options:NSRegularExpressionCaseInsensitive
																		  error:nil];//测试出生日期的合法性
			}else {
				regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
																		options:NSRegularExpressionCaseInsensitive
																		  error:nil];//测试出生日期的合法性
			}
			numberofMatch = [regularExpression numberOfMatchesInString:value
															   options:NSMatchingReportProgress
																 range:NSMakeRange(0, value.length)];
			
			if(numberofMatch >0) {
				return YES;
			}else {
				return NO;
			}
			//            break;
		case 18:
		{
			year = [value substringWithRange:NSMakeRange(6,4)].intValue;
			
			NSString *dateString;
			NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
			[formatter setDateFormat:@"yyyy-MM-dd"];
			dateString = [formatter stringFromDate:[NSDate date]];
			
			if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
				
				
				NSString *now = dateString;
				int nowYear = [[now substringWithRange:NSMakeRange(0, 4)] intValue];
				if (year < 1900 || year > nowYear) {
					return NO;
				}
				int month = [value substringWithRange:NSMakeRange(10,2)].intValue;
				int day = [value substringWithRange:NSMakeRange(12,2)].intValue;
				if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
					if (day > 31) {
						return NO;
					}
				} else if (month == 4 || month == 6 || month == 9 || month == 11) {
					if (day > 30) {
						return NO;
					}
				} else {
					if (day > 29) {
						return NO;
					}
				}
				
			}else {
				NSString *now = dateString;
				int nowYear = [[now substringWithRange:NSMakeRange(0, 4)] intValue];
				if (year < 1900 || year > nowYear) {
					return NO;
				}
				int month = [value substringWithRange:NSMakeRange(10,2)].intValue;
				int day = [value substringWithRange:NSMakeRange(12,2)].intValue;
				if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
					if (day > 31) {
						return NO;
					}
				} else if (month == 4 || month == 6 || month == 9 || month == 11) {
					if (day > 30) {
						return NO;
					}
				} else {
					if (day > 28) {
						return NO;
					}
				}
				
			}
			int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
			
			int Y = S %11;
			NSString *checkBit=@"";
			NSString *checkString=@"10X98765432";
			checkBit=[checkString substringWithRange:NSMakeRange(Y,1)];//判断校验位
			return[checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)]uppercaseString]];
		}
		default:
			return YES;
	}
}

#pragma mark- test

- (void)functionForTest {

	NSArray *numbers = @[@"520382198707052250",
						 @"220802199002013533",
						 @"370800199111217594",
						 @"6531422197802269263",
						 @"130700199311075172",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"410481198903178663",
						 @"513321198006254543",
						 @"610403198105161857",
						 @"533526197511287963",
						 @"420982197104309664",
						 @"452128197802232647",
						 ];
	NSLog(@"方法1开始");
	for (int index = 0; index < numbers.count; index ++) {
		
		NSString *number = numbers[index];
		BOOL oneBool = [number isIDCardNumber];
	}
	NSLog(@"方法1结束");

	NSLog(@"方法22开始");
	for (int index = 0; index < numbers.count; index ++) {
		
		NSString *number = numbers[index];
		BOOL twoBool = [ViewController validateIDCardNumber:number];
	}
	NSLog(@"方法22结束");

}
//2417  0.001009

//6006  0.006702

@end
