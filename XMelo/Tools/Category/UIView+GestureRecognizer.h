//
//  UIView+GestureRecognizer.h
//  XMelo
//
//  Created by X.Melo on 2017/11/9.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GestureRecognizer)

///RAC添加tap手势
- (void)addGestureRecognizerTap:(void (^)(UIGestureRecognizer *tap))tapBlock;

///RAC添加手势
- (void)addGestureRecognizer:(UIGestureRecognizer *)gesture gestureRecognizer:(void (^)(UIGestureRecognizer *tap))grBlock;
@end
