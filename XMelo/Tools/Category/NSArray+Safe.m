//
//  NSArray+Safe.m
//  
//
//  Created by melo on 2018/1/10.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

//这个方法无论如何都会执行
+ (void)load {
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		
		SEL safeSel = @selector(safeObjectAtIndex:);
		SEL unsafeSel = @selector(objectAtIndex:);
		
		Class class = NSClassFromString(@"__NSArrayI");
		
		// 方法
		Method safeMethod = class_getInstanceMethod(class, safeSel);
		Method unsafeMethod = class_getInstanceMethod(class, unsafeSel);
		
		// 交换方法
		method_exchangeImplementations(unsafeMethod, safeMethod);
	});
}

- (id)safeObjectAtIndex:(NSUInteger)index {
	
	// 数组越界也不会崩，但是开发的时候并不知道数组越界
	if (index > (self.count - 1)) { // 数组越界
		
//		NSAssert(NO, @"数组越界了"); // 只有开发的时候才会造成程序崩了
		return nil;
	}else { // 没有越界
		
		return [self safeObjectAtIndex:index];
	}
}
@end
