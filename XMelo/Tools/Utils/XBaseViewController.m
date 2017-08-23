//
//  XBaseViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XBaseViewController.h"
#import "MJRefresh.h"
#import "UIScrollView+EmptyDataSet.h"


@interface XBaseViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation XBaseViewController

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
    
    if (self.didSelectRowAtIndexPath) {
        
        self.didSelectRowAtIndexPath(indexPath);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.cellForRowAtIndexPath(tableView,indexPath);
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
