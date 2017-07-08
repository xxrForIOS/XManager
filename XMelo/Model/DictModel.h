//
//  DictModel.h
//  XMelo
//
//  Created by X.Melo on 2017/7/8.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictModel : NSObject


@property (nonatomic,   copy) NSString      *name;
@property (nonatomic,   copy) NSString      *age;
@property (nonatomic,   copy) NSString      *sex;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
