//
//  XRButtonCell.m
//  XMelo
//
//  Created by melo on 2017/12/13.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XRButtonCell.h"

@implementation XRButtonCell

-(instancetype)initWithFrame:(CGRect)frame{
	
	self = [super initWithFrame:frame];
	if (self) {
		
		//		self.backgroundColor = [UIColor whiteColor];
		self.layer.cornerRadius = 8;
		self.layer.masksToBounds = YES;
		self.button = [UIButton buttonWithType:UIButtonTypeCustom];
		self.button.frame = CGRectMake(20, 15, 45, 45 + 37 - 15);
		self.button.backgroundColor = kColorRandom;
		self.button.titleLabel.font = kFontTheme(13);
		[self.button setTitleColor:kColorHex(0x2a2e36) forState:UIControlStateNormal];
		[self.button changePosition:XRButtonDrawStyleTop space:9];
		[self.contentView addSubview:self.button];
	}
	return self;
}
@end
