//
//  YVWishAlertView.h
//  YVPinRoot
//
//  Created by melo on 2017/12/25.
//  Copyright © 2017年 大兵布莱恩特. All rights reserved.
//

#import <UIKit/UIKit.h>

///wish红包抢单错误type
typedef NS_ENUM(NSUInteger, YVWishErrorType) {
	
	///已送出22个红包，休息四个小时再来
	YVWishErrorTypeTooMore = 1017,
	///已抢10个该类红包，先发送一个吧
	YVWishErrorTypeNeedSend = 1018,
	///需要发送一个一心红包
	YVWishErrorTypeNeedTypeOne = 1019,
	///需要发送一个二意红包
	YVWishErrorTypeNeedTypeTwo = 1020,
};
@interface YVWishAlertView : UIView

- (instancetype)initWithType:(YVWishErrorType)type;

- (void)showAlertView;
@end
