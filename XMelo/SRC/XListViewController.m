//
//  XViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XListViewController.h"
#import "TableViewAnimationKit.h"

#import "XRLayout.h"
#import "XRCCell.h"
#import "UINavigationBar+ThemeColor.h"


@interface XListViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
	
	CGFloat          startX;
	CGFloat          endX;
	NSInteger        currentIndex;
}

@property (nonatomic, strong) UICollectionView 	*collectionView;
@property (nonatomic, strong) NSArray 			*images;
@property (nonatomic, strong) NSArray           *controllers;
@end

@implementation XListViewController

- (void)viewDidLoad {
    [super viewDidLoad];


	self.navigationItem.title = @"XMelo";
	[self setUpcollection];
	[self setUpTableView];
	[self configBottomTool];
	
//	[self.navigationController.navigationBar configThemeColor];
	
	///购物车
	UIButton *cart = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 20, 20)];
	cart.backgroundColor = [UIColor randomColor];
	[cart setImage:kImageName(@"sd_like_s") forState:UIControlStateNormal];
	[cart setImage:kImageName(@"sd_like_s") forState:UIControlStateHighlighted];

//	[cart setBackgroundImage:kImageName(@"sd_like_s") forState:UIControlStateNormal];
//	[cart setBackgroundImage:kImageName(@"sd_like_s") forState:UIControlStateHighlighted];
	cart.userInteractionEnabled = YES;
	cart.clickScope = UIEdgeInsetsMake(-10, -10, -10, -10);
	cart.timeInterval = 0.0001;
	[cart addClick:^(UIButton * _Nullable sender) {
		
		YVLog(@"click %@",[NSString randomString:6]);
	}];
	
	UIBarButtonItem *carItem = [[UIBarButtonItem alloc] initWithCustomView:cart];
	UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	negativeSpacer.width = 20;

	self.navigationItem.rightBarButtonItems = @[negativeSpacer, carItem];
	
	self.navigationItem.leftBarButtonItems = @[carItem, negativeSpacer];
}

#pragma mark- tableView
- (void)setUpTableView {
	
	self.tableView.rowHeight 		= 50;
	self.tableView.separatorStyle 	= UITableViewCellSeparatorStyleNone;
	
	@kWeakSelf;
	self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
		
		return selfWeak.controllers.count;
	};
	
	self.creatCellView = ^(UITableViewCell *cell, NSIndexPath *indexPath) {

		//分割线
		//        cell.separatorInset = UIEdgeInsetsMake(0, self.nameTextField.left, 0, 0);

		
		cell.backgroundColor 		= kColorRandom;
		UILabel *theLabel 			= [[UILabel alloc]init];
		theLabel.text 				= selfWeak.controllers[indexPath.row];
		theLabel.font 				= kFontTheme(12);
		theLabel.backgroundColor 	= [UIColor whiteColor];
		[cell.contentView addSubview:theLabel];
		
		[theLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			
//			make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(padding, padding, padding, padding));

//			make.edges.mas_offset(UIEdgeInsetsMake(10, 20, 10, -20));
			make.left.offset(20);
			make.centerY.offset(0);
//			make.height.mas_lessThanOrEqualTo(cell.contentView);
		}];
	};
	
	self.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {
		
		Class cls = NSClassFromString(selfWeak.controllers[indexPath.row]);
		kPush(selfWeak, [[cls alloc] init]);
	};
	
//	[XManager addRightBarItemInViewController:self itemTitle:@"dismiss" andItemBlock:^(UIButton *aButton) {
//
////		[selfWeak dismissViewControllerAnimated:YES completion:nil];
////		[[NSNotificationCenter defaultCenter]postNotificationName:@"xxalert" object:nil userInfo:nil];;
//
//		Class class     = NSClassFromString(@"ShowViewController");
//		kPush(selfWeak, [[class alloc] init]);
//	}];
	
	self.tableView.hidden = YES;
	[XManager dispatchAfter:1 completion:^{
		
		self.tableView.hidden = NO;
		[TableViewAnimationKit cellAnimationWithTableView:self.tableView animationType:self.type];
	}];
}

#pragma mark- 自定义view
- (void)configBottomTool {
	
	@kWeakSelf;
	[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
		
		make.edges.equalTo(selfWeak.view).insets(UIEdgeInsetsMake(150.0f, 0.0f, selectConstraint(85.0f, 55.0f), 0.0f));
	}];
	
	UIButton *commentButton = ({
		
		UIButton *button            = [UIButton buttonWithType:UIButtonTypeCustom];
		button.backgroundColor 		= [UIColor whiteColor];
		button.titleLabel.font 		= kFontTheme(15);
		[button setTitle:@"comment" 					forState:UIControlStateNormal];
		[button setImage:kImageName(@"sd_comment_s") 	forState:UIControlStateNormal];
		[button setTitleColor:kColorHex(0x999999) 		forState:UIControlStateNormal];
		[button changePosition:XRButtonDrawStyleLeft space:10];
		[self.view addSubview:button];
		
		button;
	});
	
	UIButton *toTopButton = ({
		
		UIButton *button            = [UIButton buttonWithType:UIButtonTypeCustom];
		button.layer.cornerRadius 	= 29/2;
		button.layer.masksToBounds 	= YES;
		[button setImage:kImageName(@"sd_top") 	forState:UIControlStateNormal];
		[self.view addSubview:button];
		button;
	});
	
	UIButton *rewardButton = ({
		
		UIButton *button            = [UIButton buttonWithType:UIButtonTypeCustom];
		button.layer.cornerRadius 	= 29/2;
		button.layer.masksToBounds 	= YES;
		[button setImage:kImageName(@"sd_reward") 	forState:UIControlStateNormal];
		[self.view addSubview:button];
		button;
	});
	rewardButton.clickScope = UIEdgeInsetsMake(-20, -20, -20, -20);
	
	[commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.centerX.equalTo(selfWeak.view);
		make.bottom.equalTo(selfWeak.view).offset(kIphoneXDevice ? -30.0f : 0);
		make.size.mas_equalTo(CGSizeMake(kScreenWidth, 50));
	}];
	
	[toTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.right.offset(-12);
		make.height.width.offset(29.0f);
		make.bottom.equalTo(commentButton.mas_top).with.offset(-46);
	}];
	
	[rewardButton mas_makeConstraints:^(MASConstraintMaker *make) {
		
		make.right.equalTo(toTopButton);
		make.size.equalTo(toTopButton);
		make.bottom.equalTo(toTopButton.mas_top).with.offset(-27);
	}];
}


- (void)setUpcollection {
	
	CGRect frame = CGRectMake(0, 0, kScreenWidth, 150);
	self.collectionView = [[UICollectionView alloc]initWithFrame:frame
											collectionViewLayout:[[XRLayout alloc]init]];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
	self.collectionView.showsHorizontalScrollIndicator = NO;
	[self.collectionView registerClass:[XRCCell class] forCellWithReuseIdentifier:@"cell"];
	[self.view addSubview:self.collectionView];
}

#pragma mark- delegate
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

	return YES;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"取消关注" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
		
		[XAlertController alertControllerWithTitle:@"xx"
										   message:@"点我干啥"
									 confirmButton:@"S"
									  cancelButton:@"B"
									  confirmBlock:^{
										  
									  } cancelBlock:^{
										  
									  }];
	}];
	
	return @[deleteRowAction];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
	UIContextualAction *action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"收藏" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {

		UIColor *aColor = [UIColor randomColor];
		sourceView.backgroundColor = aColor;
		UITableViewCell *cell 	= [tableView cellForRowAtIndexPath:indexPath];
		cell.backgroundColor 	= aColor;
		completionHandler(YES);
	}];
	
	UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[action]];
	return config;
}


//MARK: collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	
	return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	
	XRCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	cell.imageIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.images[indexPath.row]]];
	//	cell.imageIV.image = kImageName(@"%ld",(long)indexPath.row + 1);
	return cell;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	
	startX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	endX = scrollView.contentOffset.x;
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[self cellToCenter];
	});
}
- (void)cellToCenter{
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
#pragma mark- lazyLoad
- (NSArray *)controllers {
	
	if (!_controllers) {
		
		_controllers = @[@"UploadImageViewController",
						 @"XPickerViewController",
						 @"XInputViewController",
						 @"FontViewController",
						 @"ImageValidationViewController",
						 @"ThirdSignViewController"];
	}
	return _controllers;
}

- (NSArray *)images {
	
	if (!_images) {
		
		_images = @[@"wish_top", @"wish_top", @"wish_top", @"wish_top"];
	}
	return _images;
}


@end
