//
//  UIScrollView+SpringHeadView.h
//  Sample
//
//  Created by 陈光临 on 15/12/2.
//  Copyright © 2015年 cn.chenguanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

//添加可拉伸的头部视图
@interface UIScrollView (SpringHeadView)<UIScrollViewDelegate>

@property (nonatomic, weak) UIView *topView;

- (void)addSpringHeadView:(UIView *)view;

@end


