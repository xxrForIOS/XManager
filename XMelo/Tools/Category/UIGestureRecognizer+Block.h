//
//  UIGestureRecognizer+Block.h
//  YiWei
//
//  Created by X.Melody on 17/5/2.
//  Copyright © 2017年 X.Melody. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (Block)


/**
 创建带有block的手势实例

 */
- (instancetype)initWithActionBlock:(void (^)(id sender))block;



/**
 添加block回调
 
 */
- (void)addActionBlock:(void (^)(id sender))block;



/**
 移除所有block回调
 */
- (void)removeAllActionBlocks;
@end
