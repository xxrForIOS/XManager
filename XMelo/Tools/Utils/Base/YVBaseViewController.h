//
//  YVBaseViewController.h
//  YiWeiZD
//
//  Created by X.Melo on 2017/7/27.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"
#import "TableViewAnimationKit.h"

@interface YVBaseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

NS_ASSUME_NONNULL_BEGIN


@property (nonatomic, weak)     UITableView     *tableView;
@property (nonatomic, assign)   UITableViewStyle        tableStyle;
@property (nonatomic, assign)   UITableViewCellStyle    cellStyle;

@property (nonatomic,assign)    NSInteger  numberOfSections;
@property (nonatomic,copy)      NSInteger(^numberOfRowsInSection)(NSInteger section);
@property (nonatomic,copy)      NSInteger(^numberOfSectionsInTableView)(void);
@property (nonatomic,copy)      CGFloat(^heightForRowAtIndexPath)(NSIndexPath *indexPath);
@property (nonatomic,copy)      CGFloat(^heightForFooterAtIndexPath)(NSInteger section);
@property (nonatomic,copy)      CGFloat(^heightForHeadrAtIndexPath)(NSInteger section);
@property (nonatomic,copy)      UIView*(^viewForHeadrAtSection)(NSInteger section);
@property (nonatomic,copy)      UIView*(^viewForFooterAtSection)(NSInteger section);

@property (nonatomic,copy)      void(^didSelectRowAtIndexPath)(NSIndexPath *indexPath);
@property (nonatomic,copy)      void(^creatCellView)(UITableViewCell *cell, NSIndexPath *indexPath);
@property (nonatomic,strong)    UITableViewCell *(^cellForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic,strong)    NSArray*(^sectionIndexTitlesForTableView)(void);


//隐藏界面右上角按钮
- (void)hiddenRightTool;

///单个footer按钮
- (void)showFooerButtonWithTitle:(NSString *)title clickBlock:(void(^)(UIButton *aButton))aBlock;

///基于系统cell 自定义cell内容
- (void)creatCellView:(UITableViewCell *)cell With:(NSIndexPath *)indexPath;

///下拉head刷新
- (void)updateDataFromHeadWith:(void(^)(void))block beginRefresh:(BOOL)justNow;

///上拉footer加载
- (void) updateDataFromFootWith:(void(^)(void))block beginRefresh:(BOOL)justNow;

///添加左边返回按钮
- (void) addBackButtonItemWithTarget:(id)target action:(SEL)sel;

NS_ASSUME_NONNULL_END

@end
