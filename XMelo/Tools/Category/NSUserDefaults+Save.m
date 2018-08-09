//
//  NSUserDefaults+Save.m
//  XMelo
//
//  Created by melo on 2018/8/8.
//  Copyright © 2018年 欣欣然. All rights reserved.
//

#import "NSUserDefaults+Save.h"

@implementation NSUserDefaults (Save)

+ (void)saveValue:(id)object withKey:(NSString *)key {
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	@synchronized ([NSUserDefaults standardUserDefaults]) {
		
		[defaults setObject:object forKey:key];
		[defaults synchronize];
	}
}

+ (id)getObjectWithKey:(NSString *)key {
	
	return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)removeAll {
	
	NSString *name = [[NSBundle mainBundle] bundleIdentifier];
	[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:name];
}

+ (void)removeWithName:(NSString *)key {

	[[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
}

@end
