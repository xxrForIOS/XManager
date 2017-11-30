//
//  XStepper.m
//  XMelo
//
//  Created by X.Melo on 2017/7/15.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XStepper.h"


@interface XStepper()
@property (nonatomic, strong) UIButton                *leftButton;
@property (nonatomic, strong) UIButton                *rightButton;

@end

@implementation XStepper

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (!self) {
        return nil;
    }
    
    self.textColor 		= [UIColor blueColor];
    self.font 			= [UIFont systemFontOfSize:14];
    self.textAlignment 	= NSTextAlignmentCenter;
    
    
    
    self.leftButton = ({
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
        theButton.frame = CGRectMake(0, 0, self.height, self.height);
        theButton.layer.cornerRadius = theButton.height/2;
        theButton.layer.borderColor = [UIColor redColor].CGColor;
        theButton.layer.borderWidth = 1;
        theButton.layer.masksToBounds = YES;
        [theButton setTitle:@"-" forState:UIControlStateNormal];
        [theButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [theButton addTarget:self action:@selector(clickForMinusInptValue:) forControlEvents:UIControlEventTouchUpInside];
        theButton;
    });
    
    
    self.rightButton = ({
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
        theButton.frame = CGRectMake(0, 0, self.height, self.height);
        theButton.layer.cornerRadius = theButton.height/2;
        theButton.layer.borderColor = [UIColor redColor].CGColor;
        theButton.layer.borderWidth = 1;
        theButton.layer.masksToBounds = YES;
        [theButton setTitle:@"+" forState:UIControlStateNormal];
        [theButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [theButton addTarget:self action:@selector(clickForPlusInptValue:) forControlEvents:UIControlEventTouchUpInside];
        theButton;
    });
    
    self.leftViewMode = UITextFieldViewModeAlways;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    self.leftView = self.leftButton;
    self.rightView = self.rightButton;
    
    self.layer.cornerRadius = self.height/2;
    
    return self;
}

- (void)clickForPlusInptValue:(UIButton *)sender {
    
    if (![self.text isNunmber] )      return;
	
    if (self.text.intValue + 1 > 0) {
        
        self.leftButton.alpha = 1;
        self.leftButton.enabled = YES;
    }
    
    self.text =  kStringFormat(@"%d",self.text.intValue + 1);
}


- (void)clickForMinusInptValue:(UIButton *)sender {
    
    
    if (![self.text isNunmber] )  return;
    
    
    self.text =  kStringFormat(@"%d",self.text.intValue - 1);
    
    if (self.text.intValue <= 0) {
        
        sender.alpha = 0.3;
        sender.enabled = NO;
        return;
    }
}


@end
