//
//  UploadImageCell.h
//  XMelo
//
//  Created by X.Melo on 2017/8/23.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHead.h"

@interface UploadImageCell : UITableViewCell

@property (nonatomic, copy)     void(^uploadImage)(NSArray *images, CGFloat cellHeight);
@property (nonatomic, strong)   UILabel         *remarkLabel;
@property (nonatomic, assign)   NSInteger       maxImages;

- (void)configImagesWith:(NSArray<UIImage *> *)images;
@end
