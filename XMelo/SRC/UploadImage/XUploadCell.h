//
//  XUploadCell.h
//  XMelo
//
//  Created by X.Melo on 2017/9/5.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHead.h"

@interface XUploadCell : UITableViewCell


@property (nonatomic, copy)   void(^upImageBlock)   (NSArray *images);
@property (nonatomic, copy)   void(^cellOpenBlock)  (CGFloat cellHeight);

@property (nonatomic, strong) UITextField           *introTextfield;


- (void)configImagesWith:(NSArray<UIImage *> *)images;

@end
