//
//  ViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ViewController.h"
#import "XListViewController.h"
#import "XRHttpHelper.h"
#import "YVWishAlertView.h"
#import "DictModel.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <MJExtension/MJExtension.h>

@interface ViewController () {
	
	NSMutableArray			*tempArray;
	NSString 				*tempStr;
	
}

@property (nonatomic, strong) UIImage 			*oneImage;
@property (nonatomic, strong) NSMutableArray 	*oneArray;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor randomColor];
	
	tempArray = [NSMutableArray arrayWithCapacity:0];
	

//	[self animationToPresent];
	
//	[self forTest];
	
//	[self arrayNumber];
	
	[self changeValueeeeee];
}

NSString * Float(double sum) {
	return [NSString stringWithFormat:@"%f",sum];
}

UIColor * kkkRandomColor(void) {
	
	return [UIColor randomColor];
}

UIColor * kAssetsLightRed(void) {
	
	return [UIColor colorWithHexString:@"#FC4C4C"];
}

- (void)changeValueeeeee {

	double something = 12.09;
	
	UILabel *xx = [[UILabel alloc]init];
	xx.text = @" build    passing ";
	xx.font = kFontBold(16);
	xx.numberOfLines = 0;
	xx.backgroundColor = kkkRandomColor();
	xx.textColor = [UIColor blackColor];
//	xx.backgroundColor = [UIColor lightGrayColor];
	xx.layer.cornerRadius = 3;
	xx.layer.masksToBounds = YES;
	[self.view addSubview:xx];

	[xx mas_makeConstraints:^(MASConstraintMaker *make) {

		make.center.equalTo(self.view);
	}];
	
//	NSShadow *shadow = [[NSShadow alloc]init];
//	shadow.shadowBlurRadius = 5;//模糊度
//	shadow.shadowColor = [UIColor whiteColor];//阴影颜色
//	shadow.shadowOffset = CGSizeMake(2, 2);//阴影的大小
//
//	[xx changeAttributedText:NSShadowAttributeName value:shadow range:[xx.text rangeOfString:@"passing"]];
	
//	[xx changeAttributedText:NSBackgroundColorAttributeName
//					   value:[UIColor grayColor]
//					   range:[xx.text rangeOfString:@" build  "]];
//
//	[xx changeAttributedText:NSBackgroundColorAttributeName
//					   value:[UIColor greenColor]
//					   range:[xx.text rangeOfString:@"  passing "]];
}

- (void)attributeDict {
	
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
	[dict setObject:@"字体" forKey:NSFontAttributeName];
	[dict setObject:@"背景颜色" forKey:NSBackgroundColorAttributeName];
	[dict setObject:@"字间距" forKey:NSKernAttributeName];
	[dict setObject:@"font" forKey:NSFontAttributeName];
	[dict setObject:@"font" forKey:NSFontAttributeName];
	[dict setObject:@"font" forKey:NSFontAttributeName];
	[dict setObject:@"font" forKey:NSFontAttributeName];
	[dict setObject:@"font" forKey:NSFontAttributeName];

}



#pragma mark- test

- (void)forTest {

	
	
	NSMutableString *aStr1 = [NSMutableString stringWithString:@"aassdd"];

	//[self.text rangeOfString:string]
	[aStr1 replaceCharactersInRange:[aStr1 rangeOfString:@"ss"] withString:@"eeeeeee"];

	YVLog(@"xx %@",aStr1);
	
	
	NSMutableArray *temp1 = [@[[NSMutableString stringWithString:@"qqq"],
							   [NSMutableString stringWithString:@"aassdd"],
							   [NSMutableString stringWithString:@"www"]] mutableCopy];
	
//	NSMutableArray * temp1=[NSMutableArray arrayWithObjects:
//								 [NSMutableString stringWithString:@"1"],
//								 [NSMutableString stringWithString:@"2"],
//								 [NSMutableString stringWithString:@"3"],
//								 [NSMutableString stringWithString:@"4"],
//								 nil
//								 ];
	NSMutableArray *array1 = [temp1 mutableCopy];
	
	NSMutableString *str = array1[1];
	[str replaceCharactersInRange:NSRangeFromString(@"ss") withString:@"eeeeeee"];
	
	NSLog(@"dataArray2：%@",temp1);

//	UIImage *aImage = [self.oneImage copy];
//
//	self.oneImage = nil;
//
//	YVLog(@"-- %p %p %p",self.oneImage, aImage, [self.oneImage copy]);
	
//	NSString *str1 = [self getCopyStr];
//	YVLog(@"get %p--%p",str1, [str1 copy]);

//	NSArray *copy = [self getReturnArray];
	
//	UIImage *aImage = [self getReturnArray];
//
//
//	self.oneImage = nil;

//	for (UIImage *aImage in copy) {
//
//		YVLog(@"array %p;;%p",aImage, [aImage copy]);
//	}
//	YVLog(@"retun %p -- %p",copy,[copy copy]);

	UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
	theButton.frame = CGRectMake(20, 200, 100, 100);
	theButton.backgroundColor = [UIColor randomColor];
	[theButton setBackgroundImage:kImageName(@"custom_image") forState:UIControlStateNormal];
	[self.view addSubview:theButton];
	[theButton addClick:^(UIButton * _Nullable sender) {
		
		[sender setImage:nil forState:UIControlStateNormal];
	}];
	
	UIButton *xx = [UIButton buttonWithType:UIButtonTypeCustom];
	xx.frame = CGRectMake(kScreenWidth - 120, 200, 100, 100);
	xx.backgroundColor = [UIColor randomColor];
	[self.view addSubview:xx];
	[xx addClick:^(UIButton * _Nullable sender) {
		
		YVLog(@"-- %p",theButton.currentImage);
	}];
	
	[self.view addTap:^(UIGestureRecognizer *tap) {
		
		[XImagePicker showImagePickerViewIn:self handler:^(UIImage *pickerImagePic) {
			
			[theButton setImage:pickerImagePic forState:UIControlStateNormal];
		}];
//		[theButton setImage:kImageName(@"sd_publish") forState:UIControlStateNormal];
//		tap.view.backgroundColor = [UIColor randomColor];
	}];
	
	
//	tempStr = @"";
//	while ([tempArray containsObject:tempStr]) {
//
//		tempStr = [self getRandomString];
//		[tempArray addObject:tempStr];
//	}
//	YVLog(@"I Got One :%@",tempArray);
}

- (void)arrayNumber {
	

	
	
	NSDictionary *aData = @{@"name":@"tom",
							@"age":@50,
							@"son":@{@"name":@"jack",
									 @"age":@30,
									 @"son":@{@"name":@"john",
											  @"age":@6}}};
	
	for (int index = 0; index < 21; index ++) {
		
		int sellNumber = index % 5;
		int imageNumber = index / 5;
		if (sellNumber == 0) {
			
			if (index == 0) {
				
				sellNumber = 0;
			} else {
				
				sellNumber = 5;
				imageNumber = imageNumber - 1;
			}
		}
		YVLog(@"  %d--  %d   %d",index, sellNumber, imageNumber + 1);
	}
}













- (void)animationToPresent {

//	for (NSInteger i = 0; i < selfWeak.datas.count; i++) {
//		for (NSInteger j = i+1;j < selfWeak.datas.count; j++) {
//
//			YVSDCUserModel *tempModel = selfWeak.datas[i];
//			YVSDCUserModel *model = selfWeak.datas[j];
//			if ([tempModel.createTime isEqualToString:model.createTime]) {
//
//				[selfWeak.datas removeObject:model];
//			}
//		}
//	}
	
	@kWeakSelf;
	[UIView animateWithDuration:1 animations:^{
		
		selfWeak.view.backgroundColor = kColorRandom;
	} completion:^(BOOL finished) {
		
		[selfWeak goPresentViewController];
	}];
	
	[self.view addTap:^(UIGestureRecognizer *tap) {
		
		[selfWeak goPresentViewController];
	}];
}

- (void)goPresentViewController {
	
	XListViewController *vcc 	= [[XListViewController alloc]init];
	vcc.type 					= XRCellAnimationTypeOverTurn;
	UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vcc];
	[self presentViewController:nav animated:YES completion:nil];
}

@end
