//
//  UILabel+Frame.h
//  YiWeiZD
//
//  Created by X.Melody on 2017/5/6.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XRLabelSizeType) {
	
	///修改高度
	XRLabelSizeTypeHeight = 0,
	///修改宽度
	XRLabelSizeTypeWidth = 1,
};

typedef NS_ENUM(NSUInteger, XRLabelValueType) {
	
	///修改字体
	XRLabelValueTypeFont = 0,
	///修改字体颜色
	XRLabelValueTypeColor = 1,
};

@interface UILabel (Frame)

///改变大小
- (void)reSetSizeWithType:(XRLabelSizeType)type marginSpace:(CGFloat)space;

///改变指定位置属性
- (void)reSetValueWithType:(XRLabelValueType)type value:(id)value range:(NSRange)range;

///获取字符在label中的位置
- (NSRange)getRangeOf:(NSString *)str;
@end
