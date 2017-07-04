//
//  XManager.m
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XManager.h"

@implementation XManager


#pragma mark-
#pragma mark- Singleton 单例
+ (XManager *)sharedManager{
    
    static XManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedManager = [[XManager alloc]init];
    });
    return _sharedManager;
}



@end
