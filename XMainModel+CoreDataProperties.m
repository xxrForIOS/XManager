//
//  XMainModel+CoreDataProperties.m
//  
//
//  Created by X.Melo on 2017/8/1.
//
//

#import "XMainModel+CoreDataProperties.h"

@implementation XMainModel (CoreDataProperties)

+ (NSFetchRequest<XMainModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"XMainModel"];
}

@dynamic name;
@dynamic content;
@dynamic mainId;
@dynamic title;
@dynamic time;
@dynamic son;

@end
