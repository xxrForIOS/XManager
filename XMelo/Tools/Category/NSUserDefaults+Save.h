//
//  NSUserDefaults+Save.h
//  XMelo
//
//  Created by melo on 2018/8/8.
//  Copyright © 2018年 欣欣然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Save)

/// 键值对保存
+ (void)saveValue:(id)object withKey:(NSString *)key;

/// key获取
+ (id)getObjectWithKey:(NSString *)key;

/// 清空
+ (void)removeAll;

/// 单个删除
+ (void)removeWithName:(NSString *)key;

@end
