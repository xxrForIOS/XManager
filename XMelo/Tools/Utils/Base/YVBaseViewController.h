//
//  YVBaseViewController.h
//  YiWeiZD
//
//  Created by X.Melo on 2017/7/27.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

@interface YVBaseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

NS_ASSUME_NONNULL_BEGIN


@property (nonatomic, weak,nullable) UITableView     *tableView;
@property (nonatomic, assign)   UITableViewStyle        tableStyle;
@property (nonatomic, assign)   UITableViewCellStyle    cellStyle;

///请使用 hiddenRightTool
@property (nonatomic, assign)   BOOL                    isShowRight __attribute__((deprecated("hiddenRightTool 替换掉")));


///包含多少个区 默认为1
@property (nonatomic,assign)    NSInteger  numberOfSections;
///返回每个区多少行
@property (nonatomic,copy)      NSInteger(^numberOfRowsInSection)(NSInteger section);
/// 返回tableview多少个区
@property (nonatomic,copy)      NSInteger(^numberOfSectionsInTableView)(void);

///设置cell高度
@property (nonatomic,copy)      CGFloat(^heightForRowAtIndexPath)(NSIndexPath *indexPath);
///设置尾部高度
@property (nonatomic,copy)      CGFloat(^heightForFooterAtIndexPath)(NSInteger section);
///设置头部高度
@property (nonatomic,copy)      CGFloat(^heightForHeadrAtIndexPath)(NSInteger section);
///设置区头部视图
@property (nonatomic,copy)      UIView*(^viewForHeadrAtSection)(NSInteger section);
///设置区尾部视图
@property (nonatomic,copy)      UIView*(^viewForFooterAtSection)(NSInteger section);

///设置点击事件
@property (nonatomic,copy)      void(^didSelectRowAtIndexPath)(NSIndexPath *indexPath);
///基于系统cell 自定义cell内容
@property (nonatomic,copy)      void(^creatCellView)(UITableViewCell *cell, NSIndexPath *indexPath);
///创建cell
@property (nonatomic,strong)    UITableViewCell *(^cellForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);

/// 每个区的索引数组 A B C .. Z
@property (nonatomic,strong,nullable)  NSArray*(^sectionIndexTitlesForTableView)(void);


//隐藏界面右上角按钮
- (void)hiddenRightTool;


///带有协议的单按钮
- (void)showNewFooterAgreementTitle:(NSString *)fullStr clickString:(NSString *)clickStr buttonWithTitle:(NSString *)title clickBlock:(void(^)(UIButton *aButton, BOOL isRead))aBlock;
///单个footer按钮
- (void)showFooerButtonWithTitle:(NSString *)title clickBlock:(void(^)(UIButton *aButton))aBlock;
///两个footer按钮 右侧 kColorRGB(13, 192, 241);
- (void)showFooerButtonWithleft:(NSString *)lTitle lBlock:(void(^)(UIButton *aButton))lBlock right:(NSString *)rTitle rBlock:(void(^)(UIButton *aButton))rBlock;

///基于系统cell 自定义cell内容
- (void)creatCellView:(UITableViewCell *)cell With:(NSIndexPath *)indexPath;

///下拉head刷新
- (void)updateDataFromHeadWith:(void(^)(void))block;
- (void)updateDataFromHeadWith:(void(^)(void))block beginRefresh:(BOOL)justNow;

///上拉footer加载
- (void) updateDataFromFootWith:(void(^)(void))block;
- (void) updateDataFromFootWith:(void(^)(void))block beginRefresh:(BOOL)justNow;
///添加左边返回按钮
- (void) addBackButtonItemWithTarget:(id)target action:(SEL)sel;

NS_ASSUME_NONNULL_END

@end
