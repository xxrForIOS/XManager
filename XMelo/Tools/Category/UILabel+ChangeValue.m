//
//  UILabel+ChangeValue.m
//  XMelo
//
//  Created by melo on 2018/1/12.
//  Copyright © 2018年 欣欣然. All rights reserved.
//

#import "UILabel+ChangeValue.h"

@implementation UILabel (ChangeValue)



- (void)changeTextColor:(UIColor *)aColor range:(NSRange)aRange {

	[self changeAttributedText:NSForegroundColorAttributeName value:aColor range:aRange];
}

- (void)changeTextFont:(NSFont *)aFont range:(NSRange)aRange {
	
	[self changeAttributedText:NSFontAttributeName value:aFont range:aRange];
}

- (void)changeTextBackGroundColor:(UIColor *)aColor range:(NSRange)aRange {
	
	[self changeAttributedText:NSBackgroundColorAttributeName value:aColor range:aRange];
}

- (void)changeAttributedText:(NSAttributedStringKey)key value:(id)value range:(NSRange)aRange {
	
	NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
	[attribute addAttribute:key value:value range:aRange];
	self.attributedText = attribute;
}




//- (void)reSetValueWithType:(XRLabelValueType)type value:(id)value range:(NSRange)range {
//	
//	NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
//	
//	if (type == XRLabelValueTypeFont) {
//		
//		if ([value isKindOfClass:[UIFont class]]) {
//			
//			[attribute addAttribute:NSFontAttributeName value:(UIFont *)value range:range];
//		}
//	} else if (type == XRLabelValueTypeColor) {
//		
//		if ([value isKindOfClass:[UIColor class]]) {
//			
//			[attribute addAttribute:NSForegroundColorAttributeName value:(UIColor *)value range:range];
//		}
//	}
//	
//	self.attributedText = attribute;
//}
@end
