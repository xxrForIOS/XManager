//
//  XSonModel+CoreDataProperties.h
//  
//
//  Created by X.Melo on 2017/8/29.
//
//

#import "XSonModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface XSonModel (CoreDataProperties)

+ (NSFetchRequest<XSonModel *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) float height;
@property (nonatomic) int16_t sonId;
@property (nonatomic) int16_t createTime;

@end

NS_ASSUME_NONNULL_END
