//
//  XRCCell.m
//  XMelo
//
//  Created by melo on 2017/12/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XRCCell.h"

@implementation XRCCell

-(instancetype)initWithFrame:(CGRect)frame{
	
	self = [super initWithFrame:frame];
	if (self) {
		
		self.backgroundColor = [UIColor whiteColor];
		self.layer.cornerRadius = 8;
		self.layer.masksToBounds = YES;
		self.imageIV = [[UIImageView alloc]initWithFrame:self.bounds];
		[self.contentView addSubview:self.imageIV];
	}
	return self;
}
@end
