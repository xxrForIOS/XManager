//
//  LYWCollectionReusableView.m
//  XMelo
//
//  Created by X.Melo on 2017/11/7.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "LYWCollectionReusableView.h"

@implementation LYWCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
	if (self == [super initWithFrame:frame]) {
		_dateLable = [[UILabel alloc]initWithFrame:self.bounds];
		[_dateLable setTextAlignment:NSTextAlignmentCenter];
		[_dateLable setFont:[UIFont systemFontOfSize:20]];
		_dateLable.textColor = [UIColor blackColor];
		[self addSubview:_dateLable];

	}
	return self;
}
@end
