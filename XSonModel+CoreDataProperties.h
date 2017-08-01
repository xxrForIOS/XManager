//
//  XSonModel+CoreDataProperties.h
//  
//
//  Created by X.Melo on 2017/8/1.
//
//

#import "XSonModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface XSonModel (CoreDataProperties)

+ (NSFetchRequest<XSonModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sonId;
@property (nullable, nonatomic, copy) NSString *time;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
