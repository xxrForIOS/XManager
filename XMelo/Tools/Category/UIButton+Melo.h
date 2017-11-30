//
//  UIButton+Melo.h
//  XMelo
//
//  Created by melo on 2017/11/24.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (Melo)

//DEPRECATED_MSG_ATTRIBUTE("替换")
//__attribute__((deprecated("用addClick:替换")))

///rac添加点击block
- (void)addClick:(void(^)(UIButton *sender))clickBlock;
@end
