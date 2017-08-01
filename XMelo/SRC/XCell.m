//
//  XCell.m
//  XMelo
//
//  Created by X.Melo on 2017/7/31.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XCell.h"

@implementation XCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.headView = ({
        
        UIImageView *theView = [[UIImageView alloc]init];
        theView.backgroundColor = kColorRandom;
        [self.contentView addSubview:theView];
        theView;
    });
    
    self.nameLabel = ({
        
        UILabel *theLabel = [[UILabel alloc]init];
        theLabel.font = kFontTheme(15);
        theLabel.textColor = kColorIceBlue1;
        theLabel.text = @"some";
        [self.contentView addSubview:theLabel];
        theLabel;
    });
    
    self.introLabel = ({
        
        UILabel *theLabel = [[UILabel alloc]init];
        theLabel.font = kFontTheme(13);
        theLabel.textColor = kColor_yan;
        theLabel.text = @"some";
        [self.contentView addSubview:theLabel];
        theLabel;
    });
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.headView.frame = CGRectMake(20, 10, 50, 50);
    self.headView.layer.cornerRadius = self.headView.height/2;
    self.headView.layer.masksToBounds = YES;
    
    self.nameLabel.frame = CGRectMake(self.headView.x + self.headView.width + 10, 10, (kScreenWidth - self.headView.width - 60)/2, 20);
    self.introLabel.frame = CGRectMake(self.nameLabel.x, self.nameLabel.y + 25, self.nameLabel.width, 20);
}


@end
