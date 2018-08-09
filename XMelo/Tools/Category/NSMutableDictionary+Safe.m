//
//  NSMutableDictionary+Safe.m
//  XMelo
//
//  Created by melo on 2018/1/11.
//  Copyright © 2018年 欣欣然. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"

@implementation NSMutableDictionary (Safe)

+ (void)load{
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		id obj = [[self alloc]init];
		[obj swizzeMethod:@selector(setObject:forKey:) withMethod:@selector(safe_setObject:forKey:)];
		[obj swizzeMethod:@selector(removeObjectForKey:) withMethod:@selector(safe_removeObjectForKey:)];
	});
}

- (void)swizzeMethod:(SEL)origSelector withMethod:(SEL)newSelector {
	
	Class class = [self class];
	
	Method originalMethod = class_getInstanceMethod(class, origSelector);
	Method swizzledMethod = class_getInstanceMethod(class, newSelector);
	BOOL didAddMethod = class_addMethod(class,
										origSelector,
										method_getImplementation(swizzledMethod),
										method_getTypeEncoding(swizzledMethod));
	if (didAddMethod) {
		
		class_replaceMethod(class,
							newSelector,
							method_getImplementation(originalMethod),
							method_getTypeEncoding(originalMethod));
	}else{
		
		method_exchangeImplementations(originalMethod, swizzledMethod);
	}
}

- (void)safe_setObject:(id)value forKey:(NSString* )key{
	
	if (value) {
		
		[self safe_setObject:value forKey:key];
	}else{
		
		NSLog(@"safe_setObject: %@ 对应值不能为空;",key);
	}
}

- (void)safe_removeObjectForKey:(NSString *)key{
	
	if ([self objectForKey:key]) {
		
		[self safe_removeObjectForKey:key];
	}else{
		
//		NSLog(@"safe_removeObjectForKey: %@对应值不能为空;",key);
	}
}


@end
