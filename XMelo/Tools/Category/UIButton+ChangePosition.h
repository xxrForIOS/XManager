//
//  UIButton+ChangePosition.h
//  XMelo
//
//  Created by X.Melo on 2017/7/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>

///图片文字显示位置
typedef NS_ENUM(NSInteger, XRButtonDrawStyle) {

    ///图片左 文字右
    XRButtonDrawStyleLeft    = 0,
    ///图片右 文字左
    XRButtonDrawStyleRight   = 1,
    ///图片上 文字下
    XRButtonDrawStyleTop     = 2,
    ///图片下 文字上
    XRButtonDrawStyleBottom  = 3
};

@interface UIButton (ChangePosition)


///改变图片和文字的位置
- (void)changePosition:(XRButtonDrawStyle)style space:(CGFloat)space;

@end
