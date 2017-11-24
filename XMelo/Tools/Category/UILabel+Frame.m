//
//  UILabel+Frame.m
//  YiWeiZD
//
//  Created by X.Melody on 2017/5/6.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import "UILabel+Frame.h"

@implementation UILabel (Frame)

/*
 
 //富文本计算高度
 NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
 style.lineBreakMode = self.lineBreakMode;
 style.alignment = self.textAlignment;
 
 NSAttributedString *string = [[NSAttributedString alloc]initWithString:self.text
 attributes:@{NSFontAttributeName:self.font,
 NSParagraphStyleAttributeName:style}];
 
 
 CGSize size =  [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0)
 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
 context:nil].size;
 */

//MARK:- update frame
- (void)updateHeight{

	[self updateHeightMargin:0];
}

- (void)updateHeightMargin:(CGFloat)margin {
	
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName : self.font}
                                          context:nil].size;
    
    CGRect tmpRect 		= self.frame;
    tmpRect.size.height = size.height + margin * 2;
    tmpRect.size.width 	= self.frame.size.width;
    self.numberOfLines 	= 0;
    self.frame 			= tmpRect;
}


- (void)updateWidth{

	[self updateWidthMargin:0];
}

- (void)updateWidthMargin:(CGFloat)margin {
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName : self.font}
                                          context:nil].size;
    
    CGRect tmpRect 		= self.frame;
    tmpRect.size.width 	= size.width + margin * 2;
    tmpRect.size.height = self.frame.size.height;
    self.textAlignment 	= NSTextAlignmentCenter;
    self.numberOfLines 	= 0;
    self.frame 			= tmpRect;
}


//MARK:- changeFont
- (void)changeFont:(UIFont *)font range:(NSRange)range{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [str addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = str;
}

- (void)changeFont:(UIFont *)font string:(NSString *)string{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [str addAttribute:NSFontAttributeName value:font range:[self.text rangeOfString:string]];
    self.attributedText = str;
}

- (void)changeFont:(UIFont *)font string:(NSString *)string repetition:(BOOL)isRepetition{
   
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    if (isRepetition) {
        
        NSRange range = [self.text rangeOfString:string options:NSBackwardsSearch range:NSMakeRange(0, self.text.length)];
        while(range.location != NSNotFound){
            
            [str addAttribute:NSFontAttributeName value:font range:range];
            NSUInteger start = 0;
            NSUInteger end = range.location;
            NSRange temp = NSMakeRange(start,end);
            range = [self.text rangeOfString:string options:NSBackwardsSearch range:temp];
        }
    }else{
        
        [str addAttribute:NSFontAttributeName value:font range:[self.text rangeOfString:string]];
    }
    self.attributedText = str;
}

//MARK:- changeColor
- (void)changeColor:(UIColor *)color range:(NSRange)range{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = str;
}

- (void)changeColor:(UIColor *)color string:(NSString *)string{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [str addAttribute:NSForegroundColorAttributeName value:color range:[self.text rangeOfString:string]];
    self.attributedText = str;
}

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
