//
//  XCell.h
//  XMelo
//
//  Created by X.Melo on 2017/7/31.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHead.h"
#import "DictModel.h"


@interface XCell : UITableViewCell


@property (nonatomic, strong) UIImageView   *headView;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UILabel       *introLabel;

@property (nonatomic, strong) DictModel     *model;

@end
