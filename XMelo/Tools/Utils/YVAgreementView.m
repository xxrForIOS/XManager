//
//  YVAgreementView.m
//  YiWeiZD
//
//  Created by X.Melody on 2017/5/9.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import "YVAgreementView.h"
#import <objc/runtime.h>

static char                     yvClickableKey;
#define kClickIdentifierUrl    @"yVUserAgreementClickKey://"
#define kClickIdentifierKey    @"yVUserAgreementClickKey"


@interface YVAgreementView ()<UITextViewDelegate>

@end


@implementation YVAgreementView

//manager单例类
+ (YVAgreementView *)sharedManager{
    static YVAgreementView *_sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [[YVAgreementView alloc]init];
    });
    return _sharedManager;
}

+ (void)getCanClickViewWithTitle:(NSString *)fString
                     clickString:(NSString *)cString
                       addInView:(UIView *)inView
                       withFrame:(CGRect)frame
                         handler:(void(^)())aBlock{

    
    objc_setAssociatedObject([self sharedManager],
                             &yvClickableKey,
                             aBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UIView *bgView = [[UIView alloc]initWithFrame:frame];
    [inView addSubview:bgView];
    
    
    UIButton *readButton = [UIButton buttonWithType:UIButtonTypeCustom];
    readButton.frame = CGRectMake(5, bgView.frame.size.height/2 - 10, 20, 20);
    [readButton setBackgroundImage:kImageName(@"agreement_n") forState:UIControlStateNormal];
    [readButton setBackgroundImage:kImageName(@"agreement_s") forState:UIControlStateSelected];
    readButton.selected = YES;
    [readButton addTarget:[self sharedManager] action:@selector(readButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self sharedManager].isRead = YES;
    [bgView addSubview:readButton];
    [self sharedManager].readButton = readButton;
    
    
    UITextView *theTextView = ({
        UITextView *tView = [[UITextView alloc]initWithFrame:CGRectMake(30, 0, bgView.width - 60, bgView.height)];
        tView.delegate = [self sharedManager];
        tView.editable = NO;
        tView.scrollEnabled = NO;
        tView.contentMode = UIViewContentModeCenter;
        tView.backgroundColor = [UIColor clearColor];

        tView.attributedText = ({
            NSMutableAttributedString *theAttributedString = [[NSMutableAttributedString alloc]initWithString:fString];
            [theAttributedString addAttribute:NSLinkAttributeName
                                        value:kClickIdentifierUrl
                                        range:[[theAttributedString string] rangeOfString:cString]];
            theAttributedString;
        });
        
        tView.linkTextAttributes = @{ NSForegroundColorAttributeName: [UIColor blueColor],
                                      NSUnderlineColorAttributeName: [UIColor clearColor],
                                      NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
        tView;
    });
    [bgView addSubview:theTextView];
}

- (void)readButtonClick:(UIButton *)button {

    
    if (button.isSelected) {
        [button setSelected:NO];
        self.isRead = NO;
    }else {
        [button setSelected:YES];
        self.isRead = YES;
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:kClickIdentifierKey]) {
        
        yvClickableBlock block = objc_getAssociatedObject(self, &yvClickableKey);
        if (block) {
            block();
        }
        return NO;
    }
    return YES; // let the system open this URL
}

@end
