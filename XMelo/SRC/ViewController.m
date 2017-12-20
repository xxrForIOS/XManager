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
#import "XRLayout.h"
#import "XRCCell.h"
#import <RongIMKit/RongIMKit.h>

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
	CGFloat          startX;
	CGFloat          endX;
	NSInteger        currentIndex;
}

@property (nonatomic, strong) UICollectionView 	*collectionView;
@property (nonatomic, strong) NSArray 			*images;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor whiteColor];
	
	self.images = @[@"wish_top", @"wish_top", @"wish_top", @"wish_top"];
//	[self collection];
	[self justTesttt];
	[self rongCloud];
}

- (void)collection {
	
	CGRect frame = CGRectMake(0, 64, kScreenWidth, 150);
	self.collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:[[XRLayout alloc]init]];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	self.collectionView.showsHorizontalScrollIndicator = NO;
	[self.collectionView registerClass:[XRCCell class] forCellWithReuseIdentifier:@"cell"];
	[self.view addSubview:self.collectionView];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	
	return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	
	return self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	
	XRCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	cell.imageIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.images[indexPath.row]]];
//	cell.imageIV.image = kImageName(@"%ld",(long)indexPath.row + 1);
	return cell;
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	
	startX = scrollView.contentOffset.x;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	endX = scrollView.contentOffset.x;
	
	YVLog(@" %.f",scrollView.contentOffset.x);

	dispatch_async(dispatch_get_main_queue(), ^{
		[self cellToCenter];
	});
}
-(void)cellToCenter{
	//最小滚动距离
	float  dragMinDistance = self.collectionView.bounds.size.width/5;
	if (startX - endX >= dragMinDistance) {
		currentIndex -= 1; //向右
	}else if (endX - startX >= dragMinDistance){
		currentIndex += 1 ;//向左
	}
	NSInteger maxIndex  = [self.collectionView numberOfItemsInSection:0] - 1;
	currentIndex = currentIndex <= 0 ? 0 :currentIndex;
	currentIndex = currentIndex >= maxIndex ? maxIndex : currentIndex;

	[self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

}

- (void)rongCloud {
	
	NSString *str = @"1514652145000";
	
	
	
	UIColor *color1 = [UIColor colorWithHexString:@"#6cabdf"];
	UIColor *color2 = [UIColor colorWithHexString:@"0x6cabdf"];
	UIColor *color4 = kColorHex(0x6cabdf);

	NSString *xx = [[NSDate date] toTimestampString];
	
	NSString *timeStr1 = [[str toDate] getFormatStringWithCustomFormat:@"yyyy-MMMM-dd HH:mm:ss"];
	NSString *timeStr2 = [[str toDate] getFormatStringWithCustomFormat:@"YYYY-MM-dd HH:mm:ss"];

	YVLog(@"xx %@ %@",timeStr1, timeStr2);
//	NSString *nowStr = [[NSDate date] getTimestampMillisecondString];
//
//	NSDateComponents *com = [[NSDate date] getComponent];
//
//
//	NSString *xx = @"1513750701473";
//	NSString *shortStr = @"1513700989";
//
//	NSDate *date1 = [xx toDate];
//	NSDate *date2 = [shortStr toDate];
//
//	NSString *dateNum1 = [date1 getTimestampMillisecondString];
//	NSString *dateNum2 = [date2 getTimestampMillisecondString];

	
//	NSString *dateStr1 = [NSString timeGetDateFormat:dateNum1 format:XRDateFormatTypeMDHM];
//	NSString *dateStr2 = [NSString timeGetDateFormat:dateNum2 format:XRDateFormatTypeMDHM];

	for (int index = 0; index < 20; index ++) {

		NSDate *datee = [NSDate dateWithTimeIntervalSinceNow:-60 * 60 * 24 * index];
		
		NSDateComponents *com = [datee getComponent];
		
		YVLog(@"%ld年%ld月%ld日 %ld:%ld:%ld 周%ld",com.year, com.month, com.day, com.hour, com.minute, com.second, com.weekday - 1);
	}
}









- (void)justTesttt {
	
	NSArray *animations = @[@"move", @"alpha", @"fall", @"shake", @"over", @"toTop", @"spring", @"shrink", @"layDonw", @"rote"];
	
	CGFloat width = (kScreenWidth - 20 * 2 - 15 * 4)/5;
	for (int index = 0; index < animations.count; index ++) {
		
		UIButton *theButton 		= [UIButton buttonWithType:UIButtonTypeCustom];
		//        theButton.frame 			= CGRectMake(20 + (theWidth + 10) * (index%4), 200 + (35 + 20) * (index/4), theWidth, 35);
		theButton.layer.borderColor = [UIColor redColor].CGColor;
		theButton.backgroundColor 	= kColorRandom;
		theButton.titleLabel.font 	= kFontTheme(12);
		theButton.tag 				= 100 + index;
		[theButton setTitle:animations[index] 			forState:UIControlStateNormal];
		[theButton setTitleColor:[UIColor blackColor] 	forState:UIControlStateNormal];
		//		[theButton changeCorner:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:width/2];
		[self.view addSubview:theButton];
		
		[theButton setBackgroundColor:[UIColor randomColor] forState:UIControlStateNormal];
//		[theButton setBackgroundImage:[[UIColor redColor] toImage] forState:UIControlStateNormal];
		//tintAdjustmentMode
		
		//		CGFloat theX = 20 + (theWidth + 10) * (index%4);
		//		CGFloat theY = 200 + (35 + 20) * (index/4);
		
		CGFloat theWidth = 20 + (width + 15) * (index % 5);
		CGFloat theHeigh = 300 + (width + 15) * (index / 5);
		[theButton mas_makeConstraints:^(MASConstraintMaker *make) {
			
			make.height.mas_equalTo(width);
			make.width.mas_equalTo(width);
			make.left.mas_equalTo(theWidth);
			make.top.mas_equalTo(theHeigh);
			
		}];
		
		
		[theButton addClick:^(UIButton * _Nullable sender) {
			
			
		}];
		theButton.clickScope = UIEdgeInsetsMake(0, 10, -20, -20);
		[theButton addClick:^(UIButton *sender) {
			
			YVLog(@"xxxxx");
//			//			[self shake:sender];
//			XListViewController *vcc 	= [[XListViewController alloc]init];
//			vcc.type 					= sender.tag - 100 + 1;
//			UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vcc];
//			[self presentViewController:nav animated:YES completion:nil];
		}];
	}
}

- (void)shake:(UIView *)view {
	
	CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
	shake.duration = 0.13;
	shake.autoreverses = YES;
	shake.repeatCount = MAXFLOAT;
	shake.removedOnCompletion = NO;
	CGFloat rotation = 0.05;
	shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
	shake.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
	
	[view.layer addAnimation:shake forKey:@"shakeAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
