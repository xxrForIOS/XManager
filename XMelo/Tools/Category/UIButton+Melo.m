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
- (void)addTouchUpInside:(void(^)(UIButton *sender))nextBlock {
	
	[[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:nextBlock];
}
@end
