//
//  XBaseViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XBaseTableController.h"
#import "MJRefresh.h"
#import "UIScrollView+EmptyDataSet.h"
#import "YVAgreementView.h"

#define kCellIdentifier @"baseCell"

@interface XBaseTableController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation XBaseTableController

- (void)viewDidLoad {
	
    [super viewDidLoad];

	self.tableStyle 			= UITableViewStyleGrouped;
	self.cellStyle 				= UITableViewCellStyleDefault;
	self.view.backgroundColor 	= [UIColor groupTableViewBackgroundColor];

	self.tableView = ({
		
		UITableView *tableView 		= [[UITableView alloc]initWithFrame:CGRectZero style:self.tableStyle];
		tableView.delegate 			= self;
		tableView.dataSource 		= self;
		tableView.backgroundColor 	= [UIColor groupTableViewBackgroundColor];
		tableView.separatorStyle 	= UITableViewCellSeparatorStyleNone;
		tableView.tableFooterView 	= [[UIView alloc]init];
		tableView.estimatedSectionHeaderHeight 	= 0;
		tableView.estimatedSectionFooterHeight 	= 0;
		tableView.estimatedRowHeight 			= 0;

		[self.view addSubview:tableView];
		
		[tableView mas_makeConstraints:^(MASConstraintMaker *make) {
			
			make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0.0f, 0.0f, selectConstraint(30.0f, 0.0f), 0.0f));
		}];
		
		if (@available(iOS 11.0, *)) {
			
			tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
		}
		tableView;
	});
	

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
}

//MARK:- empty
- (BOOL)emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView {
    
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    
    return YES;
}

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{
    
    [_tableView.mj_header beginRefreshing];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIColor groupTableViewBackgroundColor];
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
   
    return kImageName(@"placeholder_image");
}


//MARK:- footer
- (void)showFooerButtonWithTitle:(NSString *)title clickBlock:(void(^)(UIButton *aButton))aBlock {
    
    self.tableView.tableFooterView = ({
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
        bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(40, 40, bgView.width - 80, 40);
        leftButton.layer.cornerRadius = leftButton.height/2;
        leftButton.layer.masksToBounds = YES;
        leftButton.backgroundColor = [UIColor redColor];
        [leftButton setTitle:title forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[leftButton addClick:aBlock];
        [bgView addSubview:leftButton];
        bgView;
    });
}

- (void)showFooerButtonWithleft:(NSString *)lTitle
                         lBlock:(void(^)(UIButton *aButton))lBlock
                          right:(NSString *)rTitle
                         rBlock:(void(^)(UIButton *aButton))rBlock {
    
    self.tableView.tableFooterView = ({
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 95)];
        bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        CGFloat width = (bgView.width - 30 - 10)/3;
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(15, 25, width, 45);
        leftButton.layer.cornerRadius = 5;
        leftButton.layer.masksToBounds = YES;
        leftButton.backgroundColor = [UIColor orangeColor];
        [leftButton setTitle:lTitle forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[leftButton addClick:lBlock];

        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(15 + width + 10, 25, width * 2, 45);
        rightButton.layer.cornerRadius = 5;
        rightButton.layer.masksToBounds = YES;
        rightButton.backgroundColor = kColorRGB(13, 192, 241,1);
        [rightButton setTitle:rTitle forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[rightButton addClick:rBlock];

        [bgView addSubview:leftButton];
        [bgView addSubview:rightButton];
        bgView;
    });
}

//MARK:- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

	return self.numberOfSections ?: 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

	return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

	return [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	return self.numberOfRowsInSection ? self.numberOfRowsInSection(section) : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

	return self.heightForRowAtIndexPath ? self.heightForRowAtIndexPath(indexPath) : tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {

	return self.heightForHeadrAtIndexPath ? self.heightForHeadrAtIndexPath(section) : CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {

	return self.heightForFooterAtIndexPath ? self.heightForFooterAtIndexPath(section) : CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	!self.didSelectRowAtIndexPath ?: self.didSelectRowAtIndexPath(indexPath);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	if (self.cellForRowAtIndexPath) {

		return self.cellForRowAtIndexPath(tableView,indexPath);
	}else {

		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
		[self creatCellView:cell With:indexPath];
		return cell;
	}

	//cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
}

//MARK:- 自定义方法
- (void)creatCellView:(UITableViewCell *)cell With:(NSIndexPath *)indexPath {

	for (UIView *theView in cell.contentView.subviews) {

		[theView removeFromSuperview];
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	!self.creatCellView ?: self.creatCellView(cell, indexPath);
}

#pragma mark- 刷新
- (void)updateDataFromHeadWith:(void(^)(void))block{
    MJRefreshNormalHeader *headerrrr = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (block) {
            block();

            //[self.tableView reloadData];
            //[self.tableView.mj_header endRefreshing];
        }
    }];

    [headerrrr setTitle:@"一喂一下,服务到家..." forState:MJRefreshStateRefreshing];
    headerrrr.lastUpdatedTimeLabel.hidden = YES;
    headerrrr.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = headerrrr;
    [self.tableView.mj_header beginRefreshing];
}

- (void)updateDataFromFootWith:(void(^)(void))block{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (block) {
            block();

            //[self.tableView reloadData];
            //[self.tableView.mj_footer endRefreshing];
            //[self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];

    [footer setTitle:@"一喂一下,服务到家..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer = footer;
    [self.tableView.mj_footer beginRefreshing];
}

- (BOOL)willDealloc
{
	__weak id weakSelf = self;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

//		[weakSelf assertNotDealloc];
		if (weakSelf) {

			NSLog(@"getMemoryLeak %@",weakSelf);
		}
	});
	return YES;
}

@end
