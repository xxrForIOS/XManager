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

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"这里是标题";
    
    self.tableStyle = UITableViewStyleGrouped;
    self.cellStyle = UITableViewCellStyleDefault;
    
    self.tableView = ({
        UITableView *theTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:self.tableStyle];
        theTable.delegate = self;
        theTable.dataSource = self;
        [self.view addSubview:theTable];
        theTable;
    });
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];

    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    //隐藏多余的cell
    self.tableView.tableFooterView = [[UIView alloc]init];
}

- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView {
    return YES;
}

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView
{
    [_tableView.mj_header beginRefreshing];
    
    NSLog(@"emptyDataSetDidTapButton");
    // Do something
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor groupTableViewBackgroundColor];
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return kImageName(@"placeholder_image");
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}


- (void)showNewFooterAgreementTitle:(NSString *)fullStr clickString:(NSString *)clickStr buttonWithTitle:(NSString *)buttonTitle clickBlock:(void(^)(UIButton *aButton, BOOL isRead))aBlock {
    
    self.tableView.tableFooterView = ({
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [YVAgreementView getCanClickViewWithTitle:fullStr clickString:clickStr addInView:bgView withFrame:CGRectMake(15, 15, bgView.width - 30, 30) handler:^{
            
//            YVWebViewController *vcc = [[YVWebViewController alloc]init];
//            vcc.urlString = clickStr;
//            [self.tableView.viewController cyl_pushViewController:vcc animated:YES];
        }];
        
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
        theButton.frame = CGRectMake(40, 45 + 30, kScreenWidth - 80, 45);
        theButton.layer.cornerRadius = theButton.height/2;
        theButton.layer.masksToBounds = YES;
        theButton.backgroundColor = [UIColor redColor];
        [theButton setTitle:buttonTitle forState:UIControlStateNormal];
        [theButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bgView addSubview:theButton];
        
        [theButton addBlockWithblock:^(UIButton *button) {
            
            if (aBlock) {
                aBlock(button,[YVAgreementView sharedManager].isRead);
            }
        }];
        
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
        leftButton.layer.masksToBounds = YES;
        leftButton.backgroundColor = [UIColor redColor];
        [leftButton setTitle:title forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [leftButton addBlockWithblock:^(UIButton *button) {
            
            if (aBlock) {
                aBlock(button);
            }
        }];
        
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
        [leftButton addBlockWithblock:^(UIButton *button) {
            
            if (lBlock) {
                lBlock(button);
            }
        }];
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(15 + width + 10, 25, width * 2, 45);
        rightButton.layer.cornerRadius = 5;
        rightButton.layer.masksToBounds = YES;
        rightButton.backgroundColor = kColorRGB(13, 192, 241);
        [rightButton setTitle:rTitle forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton addBlockWithblock:^(UIButton *button) {
            
            if (rBlock) {
                rBlock(button);
            }
        }];
        
        [bgView addSubview:leftButton];
        [bgView addSubview:rightButton];
        bgView;
    });
}












#pragma mark- delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return ({
        NSInteger rows = 1;
        if (self.numberOfSections) {
            
            rows = self.numberOfSections;
        }
        rows;
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ({
        NSInteger rows = 1;
        if (self.numberOfRowsInSection) {
            
            rows = self.numberOfRowsInSection(section);
        }
        rows;
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return ({
        
        CGFloat height = self.tableView.rowHeight;
        if (self.heightForRowAtIndexPath) {
            
            height = self.heightForRowAtIndexPath(indexPath);
        }
        height;
    });
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    
    return ({
        
        CGFloat height = CGFLOAT_MIN;
        if (self.heightForHeadrAtIndexPath) {
            
            height = self.heightForHeadrAtIndexPath(section);
        }
        height;
    });
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    
    return ({
        
        CGFloat height = CGFLOAT_MIN;
        if (self.heightForFooterAtIndexPath) {
            
            height = self.heightForFooterAtIndexPath(section);
        }
        height;
    });
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

- (void)creatCellView:(UITableViewCell *)cell With:(NSIndexPath *)indexPath {
    
    for (UIView *theView in cell.contentView.subviews) {
        
        [theView removeFromSuperview];
    }
    
    !self.creatCellView ?: self.creatCellView(cell, indexPath);
}


#pragma mark- 刷新
- (void)updateDataFromHeadWith:(void(^)())block{
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

- (void)updateDataFromFootWith:(void(^)())block{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
