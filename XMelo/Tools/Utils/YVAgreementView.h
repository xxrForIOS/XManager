//
//  YVAgreementView.h
//  YiWeiZD
//
//  Created by X.Melody on 2017/5/9.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHead.h"

@protocol agreementDelegate


- (void)readChange:(BOOL)isRead;
@end

@interface YVAgreementView : NSObject


typedef void (^yvClickableBlock)(void);


//左侧按钮是否勾选
@property (nonatomic, assign)   BOOL                            isRead;
@property (nonatomic, strong)   UIButton                        *readButton;
//@property (nonatomic, weak)     id<agreementDelegate>           delegate;



+ (YVAgreementView *)sharedManager;


/**
 创建左侧带有按钮以及可点击超文本组合的view
 */
+ (void)getCanClickViewWithTitle:(NSString *)fString
                     clickString:(NSString *)cString
                       addInView:(UIView *)inView
                       withFrame:(CGRect)frame
                         handler:(void(^)(void))aBlock;
@end
