//
//  SignInViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/11/7.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "SignInViewController.h"

#import "NSDate+LYWCalendar_h.h"
#import "LYWCollectionViewCell.h"
#import "LYWCollectionReusableView.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define NumberMounthes 1

@interface SignInViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
	//自动布局
	UICollectionViewFlowLayout *_layout;
	//表格视图
	UICollectionView *_collectionView;
	//当月第一天星期几
	NSInteger firstDayInMounthInWeekly;
	NSMutableArray *_firstMounth;

	NSMutableArray *_dateArray;

}
@end

static NSString *cellID =@"cellID";
static NSString *headerID =@"headerID";
static NSString *footerID =@"footerID";
@implementation SignInViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.view.backgroundColor = [UIColor whiteColor];
	NSArray *weekTitleArray =@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
	for (int i =0; i < weekTitleArray.count; i++) {
		UILabel *weekTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(i * ((ScreenWidth/(weekTitleArray.count))),64,ScreenWidth/(weekTitleArray.count ),30)];
		if (i ==0 || i ==6) {

			weekTitleLable.textColor = [UIColor blackColor];

		}else{
			weekTitleLable.textColor = [UIColor blackColor];
		}
		weekTitleLable.text = [weekTitleArray objectAtIndex:i];
		weekTitleLable.textAlignment =NSTextAlignmentCenter;
		[self.view addSubview:weekTitleLable];
	}
	[self createData];
	[self createCollectionView];
}
-(void)createCollectionView{

	//设置collectionView及自动布局,代理方法尤为重要
	_layout = [[UICollectionViewFlowLayout alloc]init];
	_layout.sectionHeadersPinToVisibleBounds =YES;
	//头部视图高度
	_layout.headerReferenceSize =CGSizeMake(414,40);
	_layout.minimumLineSpacing = 10;
	_layout.minimumInteritemSpacing = 10;

	_collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, 30,
																		ScreenWidth - 30,
																		ScreenHeight -64 -30)
										collectionViewLayout:_layout];
	_collectionView.backgroundColor = [UIColor whiteColor];

	[_collectionView registerClass:[LYWCollectionViewCell class]forCellWithReuseIdentifier:cellID];
	[_collectionView registerClass:[LYWCollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
			   withReuseIdentifier:headerID];

	_collectionView.delegate =self;
	_collectionView.dataSource =self;
	//注册尾视图
	// [_collectionView registerClass:[UICollectionReusableView class] forCellWithReuseIdentifier:footerID];

	[self.view addSubview:_collectionView];
}
-(void)createData{


	_dateArray = [[NSMutableArray alloc]init];

	NSDate *currentDate = [[NSDate alloc]init];

	int daysInMounth =  (int)[currentDate totaldaysInMonth:currentDate];
	//获取月份
	int mounth = ((int)[currentDate month:currentDate])%12;
	NSDateComponents *components = [[NSDateComponents alloc]init];
	//获取下个月的年月日信息,并将其转为date
	components.month = mounth;
	components.year = [currentDate year:currentDate];
	components.day =1;
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDate *nextDate = [calendar dateFromComponents:components];
	//获取该月第一天星期几
	NSInteger firstDayInThisMounth = [nextDate firstWeekdayInThisMonth:nextDate];
	//该月的有多少天daysInThisMounth
	NSInteger daysInThisMounth = [nextDate totaldaysInMonth:nextDate];
	NSString *string = [[NSString alloc]init];



	for (int j =0; j < (daysInMounth >29 && (firstDayInThisMounth ==6 || firstDayInThisMounth ==5) ?42 :35) ; j++) {
		if (j < firstDayInThisMounth || j > daysInThisMounth + firstDayInThisMounth -1) {
			string = @"";
			[_dateArray addObject:string];
		}else{
			string = [NSString stringWithFormat:@"%ld",j - firstDayInThisMounth +1];
			[_dateArray addObject:string];


		}
	}
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

	return _dateArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

	return 1;
}

//这里是自定义cell,非常简单的自定义
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

	LYWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];

	UIView *blackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
	blackgroundView.layer.cornerRadius = blackgroundView.height/2;
	blackgroundView.backgroundColor = [UIColor redColor];

	NSDate *date = [[NSDate alloc]init];

	NSInteger day = [date day:date];

	cell.dateLable.text = [_dateArray objectAtIndex:indexPath.row];

	if ([cell.dateLable.text isEqualToString:@""]) {

		cell.dateView.backgroundColor = [UIColor clearColor];

		cell.dateLable.hidden = YES;

		cell.dateView.hidden = NO;

	}else if([cell.dateLable.text integerValue] !=0 && [cell.dateLable.text integerValue]<=day){

		cell.dateView.backgroundColor = [UIColor greenColor];

//		cell.dateLable.hidden =YES;

		cell.dateView.hidden = NO;

	}else{

		cell.dateLable.hidden = NO;

		cell.dateView.hidden = YES;
	}


	cell.selectedBackgroundView = blackgroundView;

	return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

	return CGSizeMake(30, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

	
	return UIEdgeInsetsMake(0,0,0,0);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
	if (kind ==UICollectionElementKindSectionHeader) {
		LYWCollectionReusableView *headerRV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
		//自定义蓝色
		headerRV.backgroundColor = [UIColor redColor];

		NSDate *currentDate = [[NSDate alloc]init];

		NSInteger year = [currentDate year:currentDate];

		NSInteger mounth = ([currentDate month:currentDate] + indexPath.section) %12 == 0 ?12 : ([currentDate month:currentDate] + indexPath.section)%12;

		headerRV.dateLable.text = [NSString stringWithFormat:@"%ld年%ld月",year,mounth];

		return headerRV;
	}else{
		return nil;
	}
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

	LYWCollectionViewCell *cell = [self collectionView:_collectionView cellForItemAtIndexPath:indexPath];

	NSDate *currentDate = [[NSDate alloc]init];

	//打印当前日期

	if (![cell.dateLable.text isEqualToString:@""]) {

		NSInteger year = ([currentDate month:currentDate] + indexPath.section)/12 +2016;

		NSInteger mounth = ([currentDate month:currentDate] + indexPath.section)%12;

		NSInteger day = [cell.dateLable.text intValue];

		NSLog(@"%ld年%02ld月%02ld日",year,mounth,day);

	}

	//排除空值cell

	//获取月份

	NSInteger mounth = ([currentDate month:currentDate] + indexPath.section) %12 == 0 ?12 : ([currentDate month:currentDate] + indexPath.section)%12;

	NSDateComponents *components = [[NSDateComponents alloc]init];

	components.month = mounth;

	components.year = [currentDate year:currentDate];

	components.day =1;

	NSCalendar *calendar = [NSCalendar currentCalendar];

	NSDate *nextDate = [calendar dateFromComponents:components];

	//获取该月第一天星期几

	NSInteger firstDayInThisMounth = [nextDate firstWeekdayInThisMonth:nextDate];
	//该月的有多少天daysInThisMounth

	NSInteger daysInThisMounth = [nextDate totaldaysInMonth:nextDate];

	if ((indexPath.row < firstDayInThisMounth || indexPath.row > daysInThisMounth + firstDayInThisMounth - 1)){

		//如果点击空表格则单击无效

		[collectionView cellForItemAtIndexPath:indexPath].userInteractionEnabled =NO;

		[collectionView reloadData];

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
