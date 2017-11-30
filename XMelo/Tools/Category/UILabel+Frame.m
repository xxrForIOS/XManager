//
//  UILabel+Frame.m
//  YiWeiZD
//
//  Created by X.Melody on 2017/5/6.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "UILabel+Frame.h"

@implementation UILabel (Frame)


//MARK:- 改变大小
- (void)reSetSizeWithType:(XRLabelSizeType)type marginSpace:(CGFloat)space {
	
	NSMutableParagraphStyle *style 	= [[NSMutableParagraphStyle alloc]init];
//	style.lineBreakMode 			= NSLineBreakByCharWrapping;
	style.lineBreakMode 			= self.lineBreakMode;
	style.alignment 				= self.textAlignment;
	NSDictionary *attributes 		= @{NSFontAttributeName:self.font,
										NSParagraphStyleAttributeName:style.copy};
	
	CGRect tmpRect 		= self.frame;
	if (type == XRLabelSizeTypeHeight) {
		
		CGSize theDefault 	= CGSizeMake(self.frame.size.width, [UIScreen mainScreen].bounds.size.width);
		CGSize size 		= [self.text boundingRectWithSize:theDefault
												options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
											 attributes:attributes
												context:nil].size;
		tmpRect.size.height = size.height + space * 2;
		tmpRect.size.width 	= self.frame.size.width;
	} else {
		
		CGSize theDefault 	= CGSizeMake([UIScreen mainScreen].bounds.size.height, self.frame.size.height);
		CGSize size 		= [self.text boundingRectWithSize:theDefault
												options:NSStringDrawingUsesLineFragmentOrigin
											 attributes:attributes
												context:nil].size;
		tmpRect.size.width 	= size.width + space * 2;
		tmpRect.size.height = self.frame.size.height;
		self.textAlignment 	= NSTextAlignmentCenter;
	}

	self.numberOfLines 	= 0;
	self.frame 			= tmpRect;
}

//MARK:- changeProperty
- (void)reSetValueWithType:(XRLabelValueType)type value:(id)value range:(NSRange)range {
	
	NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];

	if (type == XRLabelValueTypeFont) {
		
		if ([value isKindOfClass:[UIFont class]]) {
			
			[attribute addAttribute:NSFontAttributeName value:(UIFont *)value range:range];
		}
	} else if (type == XRLabelValueTypeColor) {
		
		if ([value isKindOfClass:[UIColor class]]) {
			
			[attribute addAttribute:NSForegroundColorAttributeName value:(UIColor *)value range:range];
		}
	}
	
	self.attributedText = attribute;
}

//MARK:- 获取指定字符在label中的位置
- (NSRange)getRangeOf:(NSString *)str{
	
	return [self.text rangeOfString:str];
}



//MARK:- 备用 获取字符里所有指定元素的range
- (void)changeColor:(UIColor *)color string:(NSString *)string repetition:(BOOL)isRepetition{
	
	
	
	NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
	if (isRepetition) {
		
		NSRange range = [self.text rangeOfString:string options:NSBackwardsSearch range:NSMakeRange(0, self.text.length)];
		while(range.location != NSNotFound){
			
			[str addAttribute:NSForegroundColorAttributeName value:color range:range];
			NSUInteger start = 0;
			NSUInteger end = range.location;
			NSRange temp = NSMakeRange(start,end);
			range = [self.text rangeOfString:string options:NSBackwardsSearch range:temp];
		}
	}else{
		
		[str addAttribute:NSForegroundColorAttributeName value:color range:[self.text rangeOfString:string]];
	}
	self.attributedText = str;
}

@end
