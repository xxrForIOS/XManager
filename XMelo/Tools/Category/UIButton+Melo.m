//
//  UIButton+Melo.m
//  XMelo
//
//  Created by melo on 2017/11/24.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "UIButton+Melo.h"

@implementation UIButton (Melo)


//集成rac点击block
- (void)addClick:(void(^)(UIButton *sender))clickBlock {
	
	[[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:clickBlock];
}

@end
