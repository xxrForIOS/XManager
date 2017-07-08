//
//  DictModel.m
//  XMelo
//
//  Created by X.Melo on 2017/7/8.
//  Copyright © 2017年 欣欣然. All rights reserved.
//


@implementation DictModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dic] ;
    }
    return self;
}

//保持处理key的一致性
- (void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"namee"]) {
        key = @"name";
    }
    [super setValue:value forKey:key];
}

//model中找不到对应的key时会走该方法，若删除该方法，将导致程序崩溃 实现即可，为了保持程序健壮，建议添加此方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSLog(@"%@--%@",value,key);
}

@end
