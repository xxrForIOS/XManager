//
//  ViewController.h
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <UIKit/UIKit.h>

///支付类型
typedef NS_ENUM(NSUInteger, YVServerPayType) {
	
	///账户充值
	YVServerPayTypeRecharge = 1,
	///缴纳服务保证金
	YVServerPayTypeServiceMargin = 2,
	///接单押金
	YVServerPayTypeOrderDeposit = 3,
	///心愿基金
	YVServerPayTypeWish = 4,
	///一键发单
	YVServerPayTypeOneKey = 5,
	///订单加价
	YVServerPayTypeMakeyUp = 6,
	///订单补差价
	YVServerPayTypeOrderSupply = 7,
	///急件要发
	YVServerPayTypeDispatch = 8,
	///跑腿劳务
	YVServerPayTypePostReward = 9,
	///我的店铺
	YVServerPayTypeMyShop = 10,
	///打赏服务
	YVServerPayTypeServiceReward = 11,
	///购买服务
	YVServerPayTypeServiceBuy = 12,
	///服务订单加价
	YVServerPayTypeServiceOrderMakeUp = 13,
	///城市合伙人
	YVServerPayTypeCityPartner = 14,
	///补签支付
	YVServerPayTypeReSignIn = 15,
	///签到
	YVServerPayTypeSignIn = 16,
	///满勤
	YVServerPayTypeSignInFull = 17,
	///余额支付签到
	YVServerPayTypeSignInPayWallet = 18,
	///余额支付满勤
	YVServerPayTypeSignInFullWallet = 19,
	///支付宝满勤
	YVServerPayTypeSignInFullAliPay = 20,
	///支付宝支付签到
	YVServerPayTypeSignInAliPay = 21,
	///开启红包
	YVServerPayTypeRedPacketOpen = 22,
	///打赏支付
	YVServerPayTypeShopDynamicReward = 23,
	///粉丝红包支付
	YVServerPayTypeSDFRedPacket = 24,
};

typedef void (^YVHttpBlockString)	(BOOL successed,NSString *idString);
typedef void (^YVHttpBlockBool)		(BOOL successed, BOOL isAlright);

@interface ViewController : UIViewController


@end

