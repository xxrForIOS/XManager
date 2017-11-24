//
//  UIButton+Melo.h
//  XMelo
//
//  Created by melo on 2017/11/24.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Melo)


///rac添加点击block
- (void)addTouchUpInside:(void(^)(UIButton *sender))nextBlock;

@end
