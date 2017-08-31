//
//  UIControl+Block.h
//  YiWei
//
//  Created by X.Melody on 17/5/2.
//  Copyright © 2017年 X.Melody. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIControl (Block)

///移除所有响应
- (void)removeAllTargets;

///添加带有block的响应
- (void)addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

///button添加block
- (void)addBlockWithblock:(void (^)(UIButton *theBlockButton))block;

///移除带有block的响应
- (void)removeAllBlocksForControlEvents:(UIControlEvents)controlEvents;

@end
