//
//  LYWCollectionViewCell.m
//  XMelo
//
//  Created by X.Melo on 2017/11/7.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "LYWCollectionViewCell.h"

@implementation LYWCollectionViewCell



- (id)initWithFrame:(CGRect)frame{
	if (self == [super initWithFrame:frame]) {
		_dateLable = [[UILabel alloc]initWithFrame:self.bounds];
		[_dateLable setTextAlignment:NSTextAlignmentCenter];
		[_dateLable setFont:[UIFont systemFontOfSize:17]];
		_dateLable.textColor = [UIColor blackColor];
		[self addSubview:_dateLable];

		self.dateView = [[UIImageView alloc]initWithFrame:self.bounds];

		CGFloat red =arc4random()%255/256.0f;
		CGFloat green =arc4random()%255/256.0f;
		CGFloat blue =arc4random()%255/256.0f;

		self.dateView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];

		[self.contentView addSubview:_dateView];
	}
	return self;
}
@end
