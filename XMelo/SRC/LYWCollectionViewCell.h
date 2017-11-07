//
//  LYWCollectionViewCell.h
//  XMelo
//
//  Created by X.Melo on 2017/11/7.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYWCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *dateLable;
@property (nonatomic,strong) UIImageView *dateView;

- (id)initWithFrame:(CGRect)frame;

@end
