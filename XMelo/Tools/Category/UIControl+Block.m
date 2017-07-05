//
//  UIControl+Block.m
//  YiWei
//
//  Created by X.Melody on 17/5/2.
//  Copyright © 2017年 X.Melody. All rights reserved.
//

#import "UIControl+Block.h"
#import <objc/runtime.h>

static const int block_key;

@interface _XControlBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);
@property (nonatomic, assign) UIControlEvents events;

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events;
- (void)invoke:(id)sender;

@end

@implementation _XControlBlockTarget

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events {
    self = [super init];
    if (self) {
        _block = [block copy];
        _events = events;
    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) _block(sender);
}

@end


@implementation UIControl (Block)

- (void)removeAllTargets {
    [[self allTargets] enumerateObjectsUsingBlock: ^(id object, BOOL *stop) {
        [self removeTarget:object action:NULL forControlEvents:UIControlEventAllEvents];
    }];
    [[self p_allUIControlBlockTargets] removeAllObjects];
}

- (void)addBlockForControlEvents:(UIControlEvents)controlEvents
                           block:(void (^)(id sender))block {
    if (!controlEvents) return;
    _XControlBlockTarget *target = [[_XControlBlockTarget alloc]
                                    initWithBlock:block events:controlEvents];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
    NSMutableArray *targets = [self p_allUIControlBlockTargets];
    [targets addObject:target];
}

- (void)addBlockWithblock:(void (^)(id sender))block {
    _XControlBlockTarget *target = [[_XControlBlockTarget alloc]
                                    initWithBlock:block events:UIControlEventTouchUpInside];
    [self addTarget:target action:@selector(invoke:) forControlEvents:UIControlEventTouchUpInside];
    NSMutableArray *targets = [self p_allUIControlBlockTargets];
    [targets addObject:target];
}


- (void)removeAllBlocksForControlEvents:(UIControlEvents)controlEvents {
    if (!controlEvents) return;
    
    NSMutableArray *targets = [self p_allUIControlBlockTargets];
    NSMutableArray *removes = [NSMutableArray array];
    for (_XControlBlockTarget *target in targets) {
        if (target.events & controlEvents) {
            UIControlEvents newEvent = target.events & (~controlEvents);
            if (newEvent) {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                target.events = newEvent;
                [self addTarget:target action:@selector(invoke:) forControlEvents:target.events];
            } else {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                [removes addObject:target];
            }
        }
    }
    [targets removeObjectsInArray:removes];
}

- (NSMutableArray *)p_allUIControlBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
