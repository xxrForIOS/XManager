//
//  UILabel+Frame.m
//  YiWeiZD
//
//  Created by X.Melody on 2017/5/6.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import "UILabel+Frame.h"

//计算高度时额外的边缘距离
#define marginLeft      5


//计算宽度时额外的边缘距离
#define marginTop       5

@implementation UILabel (Frame)



- (void)updateHeigh{
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
    
    
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName : self.font}
                                          context:nil].size;
    
    CGRect tmpRect = self.frame;
    tmpRect.size.height = size.height + marginTop * 2;
    tmpRect.size.width = self.frame.size.width;
    
    self.numberOfLines = 0;
    self.frame = tmpRect;
}

- (void)updateHeighMargin:(CGFloat)margin {
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName : self.font}
                                          context:nil].size;
    
    CGRect tmpRect = self.frame;
    tmpRect.size.height = size.height + margin * 2;
    tmpRect.size.width = self.frame.size.width;
    
    self.numberOfLines = 0;
    self.frame = tmpRect;
}


- (void)updateWidth{

    
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName : self.font}
                                          context:nil].size;
    
    CGRect tmpRect = self.frame;
    tmpRect.size.width = size.width; //+ marginLeft * 2;
    tmpRect.size.height = self.frame.size.height;
    
    self.textAlignment = NSTextAlignmentCenter;
    self.numberOfLines = 0;
    self.frame = tmpRect;
}

- (void)updateWidthMargin:(CGFloat)margin {
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName : self.font}
                                          context:nil].size;
    
    CGRect tmpRect = self.frame;
    tmpRect.size.width = size.width + margin * 2;
    tmpRect.size.height = self.frame.size.height;
    
    self.textAlignment = NSTextAlignmentCenter;
    self.numberOfLines = 0;
    self.frame = tmpRect;
}


- (void)changeFont:(UIFont *)font withRange:(NSRange)range{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [str addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = str;
}

- (void)changeFont:(UIFont *)font withString:(NSString *)string isRepetition:(BOOL)isRe{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    if (isRe) {
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




- (void)changeColor:(UIColor *)color withRange:(NSRange)range{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = str;
}

- (void)changeColor:(UIColor *)color withString:(NSString *)string isRepetition:(BOOL)isRe{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    if (isRe) {
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
