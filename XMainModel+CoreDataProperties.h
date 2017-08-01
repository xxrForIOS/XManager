//
//  XMainModel+CoreDataProperties.h
//  
//
//  Created by X.Melo on 2017/8/1.
//
//

#import "XMainModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface XMainModel (CoreDataProperties)

+ (NSFetchRequest<XMainModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSString *mainId;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *time;
@property (nullable, nonatomic, retain) XSonModel *son;

@end

NS_ASSUME_NONNULL_END
