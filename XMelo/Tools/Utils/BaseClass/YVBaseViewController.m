//
//  YVBaseViewController.m
//  YiWeiZD
//
//  Created by X.Melo on 2017/7/27.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import "YVBaseViewController.h"

#define kCellIdentifier @"baseCell"

@interface YVBaseViewController () 

@end

@implementation YVBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor 	= [UIColor groupTableViewBackgroundColor];
    self.tableStyle 			= UITableViewStyleGrouped;
    self.cellStyle 				= UITableViewCellStyleDefault;

    UITableView *tableView 		= [[UITableView alloc]initWithFrame:CGRectZero style:self.tableStyle];
    tableView.delegate 			= self;
    tableView.dataSource 		= self;
	tableView.backgroundColor 	= [UIColor groupTableViewBackgroundColor];
//	tableView.separatorStyle	= UITableViewCellSeparatorStyleNone;
	tableView.estimatedSectionHeaderHeight = 0;
	tableView.estimatedSectionFooterHeight = 0;
	self.tableView 				= tableView;
    [self.view addSubview:tableView];
	
    @kWeakSelf;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak.view).insets(UIEdgeInsetsMake(0.0f, 0.0f, selectConstraint(30.0f, 0.0f), 0.0f));
    }];
	

    //iOS10 预估cell高度
    if (kIOSVersion == 10) {
        // 设置预估行高
        self.tableView.estimatedRowHeight = 200;
        // 设置行高自动计算
        self.tableView.rowHeight          = UITableViewAutomaticDimension;
    }
    

    //注册系统cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    
    //隐藏多余的cell
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //空值展位图代理设置
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    //cell左边距
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];

	[self showRightTool];
    //隐藏分割线
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//MARK:- 右上角首页按钮控制
- (void)showRightTool{

    @kWeakSelf;
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.frame     = CGRectMake(0, 0, 20, 20);
	[button setImage:kImageName(@"right_home") forState:UIControlStateNormal];
	
	[button addClick:^(UIButton *sender) {
		
		[selfWeak.navigationController popToRootViewControllerAnimated:NO];
//		[AppDelegate appDelegate].tabBarController.selectedIndex = 0;
	}];

	UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:button];
	UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
																		   target:nil
																		   action:nil];

	space.width = -5;
	//http://blog.csdn.net/spicyShrimp/article/details/78201042
	self.navigationItem.rightBarButtonItems = @[space, right];
}

- (void)hiddenRightTool {

	self.navigationItem.rightBarButtonItems = nil;
}

//MARK:- 空数据图
- (BOOL)emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView {
    
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{

	return YES;
}

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{
    
    [self.tableView.mj_header beginRefreshing];
}


- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIColor groupTableViewBackgroundColor];
}


- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    return kImageName(@"nodata");
}


//MARK:- footer
- (void)showNewFooterAgreementTitle:(NSString *)fullStr clickString:(NSString *)clickStr buttonWithTitle:(NSString *)buttonTitle clickBlock:(void(^)(UIButton *aButton, BOOL isRead))aBlock {
    
    @kWeakSelf;
    self.tableView.tableFooterView = ({
        
        UIView *bgView                  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        bgView.backgroundColor          = [UIColor groupTableViewBackgroundColor];
//        [YVAgreementView getCanClickViewWithTitle:fullStr clickString:clickStr addInView:bgView withFrame:CGRectMake(15, 15, bgView.width - 30, 30) handler:^{
//            YVWKWebViewController *vcc  = [[YVWKWebViewController alloc]init];
//            vcc.urlString               = clickStr;
//            [selfWeak.tableView.viewController.navigationController pushViewController:vcc animated:YES];
//        }];
		
        UIButton *theButton           = [UIButton buttonWithType:UIButtonTypeCustom];
        theButton.frame               = CGRectMake(40, 45 + 30, kScreenWidth - 80, 45);
        theButton.layer.cornerRadius  = theButton.height/2;
        theButton.layer.masksToBounds = YES;
        theButton.backgroundColor     = kColorThemeRed;
        [theButton setTitle:buttonTitle forState:UIControlStateNormal];
        [theButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bgView addSubview:theButton];
        
//        [theButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *button) {
//            if (![YVAgreementView sharedManager].isRead) {
//                kAlert(@"请阅读同意相关协议");
//                return;
//            }
//            !aBlock ?: aBlock(button,[YVAgreementView sharedManager].isRead);
//        }];
		
        bgView;
    });
}

- (void)showFooerButtonWithTitle:(NSString *)title clickBlock:(void(^)(UIButton *aButton))aBlock {
    
    self.tableView.tableFooterView = ({
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
        bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(40, 40, bgView.width - 80, 40);
        leftButton.layer.cornerRadius = leftButton.height/2;
        leftButton.backgroundColor = kColorThemeRed;
        [leftButton setTitle:title forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [leftButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *button) {
//            if (aBlock) {
//                aBlock(button);
//            }
//        }];
		
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
//        [leftButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *button) {
//            if (lBlock) {
//                lBlock(button);
//            }
//        }];
		
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(15 + width + 10, 25, width * 2, 45);
        rightButton.layer.cornerRadius = 5;
        rightButton.layer.masksToBounds = YES;
//        rightButton.backgroundColor = kColorRGB(13, 192, 241);
        [rightButton setTitle:rTitle forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [rightButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *button) {
//            if (rBlock) {
//                rBlock(button);
//            }
//        }];
		
        [bgView addSubview:leftButton];
        [bgView addSubview:rightButton];
        bgView;
    });
}

//MARK:- 刷新
- (void)updateDataFromHeadWith:(void(^)(void))block {

	//[self.tableView reloadData];
	//[self.tableView.mj_header endRefreshing];
	MJRefreshNormalHeader *headerrrr = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
	[headerrrr setTitle:@"一喂一下,服务到家..." forState:MJRefreshStateRefreshing];
	headerrrr.lastUpdatedTimeLabel.hidden = YES;
	headerrrr.automaticallyChangeAlpha = YES;
	self.tableView.mj_header = headerrrr;
	[self.tableView.mj_header beginRefreshing];
}

- (void)updateDataFromHeadWith:(void(^)(void))block beginRefresh:(BOOL)justNow{

	MJRefreshNormalHeader *headerrrr = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
	[headerrrr setTitle:@"一喂一下,服务到家..." forState:MJRefreshStateRefreshing];
	headerrrr.lastUpdatedTimeLabel.hidden = YES;
	headerrrr.automaticallyChangeAlpha = YES;
	self.tableView.mj_header = headerrrr;
	if (justNow) {

		[self.tableView.mj_header beginRefreshing];
	}
}

- (void)updateDataFromFootWith:(void(^)(void))block{
    
//    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:block];
//    [footer setTitle:@"一喂一下,服务到家..." forState:MJRefreshStateRefreshing];
//    self.tableView.mj_footer = footer;
//
    [self updateDataFromFootWith:block beginRefresh:NO];
    
}

- (void)updateDataFromFootWith:(void(^)(void))block beginRefresh:(BOOL)justNow {

    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:block];
    [footer setTitle:@"一喂一下,服务到家..." forState:MJRefreshStateRefreshing];
	if (justNow) {
		[footer beginRefreshing];
	}
    self.tableView.mj_footer = footer;

}


//MARK:- tablview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (self.numberOfSections) {
        return self.numberOfSections;
    } else if (self.numberOfSectionsInTableView) {
        return self.numberOfSectionsInTableView();
    } else {
        return 1;
    }
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.viewForHeadrAtSection ? self.viewForHeadrAtSection(section) : nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.viewForFooterAtSection ? self.viewForFooterAtSection(section) : nil;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexTitlesForTableView ? self.sectionIndexTitlesForTableView() : nil;
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
    
//    for (UIView *theView in cell.contentView.subviews) {
//        [theView removeFromSuperview];
//    }
    [cell.contentView removeAllSubviews];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    !self.creatCellView ?: self.creatCellView(cell, indexPath);
}

///添加左边返回按钮
- (void) addBackButtonItemWithTarget:(id)target action:(SEL)sel {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStyleDone target:self action:sel];
}

@end
