//
//  TableViewAnimationKit.h
//  TableViewAnimationKit-OC
//
//  Created by fenqile on 2017/7/11.
//  Copyright © 2017年 com.cn.fql. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XRCellAnimationType) {
	
	XRCellAnimationTypeMove 		= 1,
	XRCellAnimationTypeAlpha 		= 2,
	XRCellAnimationTypeFall 		= 3,
	XRCellAnimationTypeShake 		= 4,
	XRCellAnimationTypeOverTurn 	= 5,
	XRCellAnimationTypeToTop 		= 6,
	XRCellAnimationTypeSpring 		= 7,
	XRCellAnimationTypeShrinkToTop 	= 8,
	XRCellAnimationTypeLayDown 		= 9,
	XRCellAnimationTypeRote 		= 10,
};
@interface TableViewAnimationKit : NSObject<UICollisionBehaviorDelegate>

+ (void)cellAnimationWithTableView:(UITableView *)tableView animationType:(XRCellAnimationType)type;

@end
