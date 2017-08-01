//
//  XSonModel+CoreDataProperties.m
//  
//
//  Created by X.Melo on 2017/8/1.
//
//

#import "XSonModel+CoreDataProperties.h"

@implementation XSonModel (CoreDataProperties)

+ (NSFetchRequest<XSonModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"XSonModel"];
}

@dynamic name;
@dynamic sonId;
@dynamic time;
@dynamic title;
@dynamic content;

@end
