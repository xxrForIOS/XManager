//
//  UIView+Add.h
//  YiWeiZD
//
//  Created by X.Melo on 2017/5/16.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Add)


@property (nonatomic,   assign) CGFloat x;
@property (nonatomic,   assign) CGFloat y;
@property (nonatomic,   assign) CGFloat centerX;
@property (nonatomic,   assign) CGFloat centerY;
@property (nonatomic,   assign) CGFloat width;
@property (nonatomic,   assign) CGFloat height;
@property (nonatomic,   assign) CGSize  size;
@property (nonatomic,   assign) CGPoint orign;

@property (nonatomic,   assign, readonly) CGFloat maxX;
@property (nonatomic,   assign, readonly) CGFloat maxY;

/**
 获取当前所在的viewController

 @return viewController
 */
- (UIViewController *)viewController;


- (void)changeCorner:(UIRectCorner)corners cornerRadii:(CGFloat)radii;

@end
