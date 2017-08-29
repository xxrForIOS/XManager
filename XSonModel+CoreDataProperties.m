//
//  XSonModel+CoreDataProperties.m
//  
//
//  Created by X.Melo on 2017/8/29.
//
//

#import "XSonModel+CoreDataProperties.h"

@implementation XSonModel (CoreDataProperties)

+ (NSFetchRequest<XSonModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"XSonModel"];
}

@dynamic age;
@dynamic name;
@dynamic height;
@dynamic sonId;
@dynamic createTime;

@end
