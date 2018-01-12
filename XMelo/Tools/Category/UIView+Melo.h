//
//  UIView+Frame.h
//  XMelo
//
//  Created by melo on 2017/11/24.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>


///渐变颜色显示方式
typedef NS_ENUM(NSInteger, YVRradualColorShowType) {
	
	///从左到右
	YVRradualColorShowTypeLeftRight = 0,
	///从上到下
	YVRradualColorShowTypeTopBottom = 1,
	///左上到右下
	YVRradualColorShowTypeLTopToRBottom = 2,
	///左下到右上
	YVRradualColorShowTypeLBottomToRTop = 3,
};
@interface UIView (Melo)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;

///移除子控件
- (void)removeAllSubviews;

///获取view所在controller
- (UIViewController *)viewController;

///切任意圆角
- (void)changeCorner:(UIRectCorner)corners cornerRadii:(CGFloat)radii;

+ (void)addRradualColorFor:(UIView *)theView colors:(NSArray *)colors showType:(YVRradualColorShowType)type;

///左右抖动
- (void)shake;

- (void)addLine;


///rac添加tap手势
- (void)addTap:(void (^)(UIGestureRecognizer * tap))tapBlock;

@end
