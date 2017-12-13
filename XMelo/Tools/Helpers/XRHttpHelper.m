//
//  XRHttpHelper.m
//  XMelo
//
//  Created by melo on 2017/12/12.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XRHttpHelper.h"

@implementation XRHttpHelper

///MARK:- 主业务manager单例
+ (AFURLSessionManager *)sharedMainManager {
	
	static AFURLSessionManager *_sharedManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		NSURLSessionConfiguration *config 	= [NSURLSessionConfiguration defaultSessionConfiguration];
//		config.timeoutIntervalForRequest    = kNetTimeOutInterval;
//		config.timeoutIntervalForResource   = kNetTimeOutInterval;
		
		_sharedManager 						= [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
		
		NSString *cerPath 					= [[NSBundle mainBundle] pathForResource:@"https12" ofType:@"cer"];
		NSData *certData 					= [NSData dataWithContentsOfFile:cerPath];
		
		AFSecurityPolicy *policy 			= [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
		policy.allowInvalidCertificates 	= YES;
		policy.validatesDomainName 			= NO;
		policy.pinnedCertificates 			= [NSSet setWithArray:@[certData]];
		[_sharedManager setSecurityPolicy:policy];
		
	});
	return _sharedManager;
}

+ (AFHTTPSessionManager *)sharedManager {
	
	static AFHTTPSessionManager *manager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		manager = [[AFHTTPSessionManager alloc]init];
		manager.requestSerializer.timeoutInterval = 10;
	});
	return manager;
}

+ (void)postttt {
	

}

@end
