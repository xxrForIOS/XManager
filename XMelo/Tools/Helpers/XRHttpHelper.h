//
//  XRHttpHelper.h
//  XMelo
//
//  Created by melo on 2017/12/12.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void(^XHttpResultFull) 		(BOOL successed, id 		responseObj, NSError *error);
typedef void(^XHttpResultBool) 		(BOOL successed, BOOL 		isAlright);
typedef void(^XHttpResultString) 	(BOOL successed, NSString 	*string);
typedef void(^XHttpResultModel) 	(BOOL successed, id 		model);
typedef void(^XHttpResultArray) 	(BOOL successed, NSArray 	*models);
@interface XRHttpHelper : NSObject

///POST请求
+ (void)postPortUrl:(NSString *)url
		 parameters:(NSDictionary *)parm
			success:(void(^)(id responseObj))success
			failure:(void(^)(NSError *error))failure;

///GET请求
+ (void)getPortUrl:(NSString *)url
		parameters:(NSDictionary *)parm
		   success:(void(^)(id responseObj))success
		   failure:(void(^)(NSError *error))failure;


+ (void)uploadImage:(NSArray *)images
		 parameters:(NSDictionary *)parm;
@end
