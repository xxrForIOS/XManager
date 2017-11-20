//
//  TableViewAnimationKit.m
//  TableViewAnimationKit-OC
//
//  Created by fenqile on 2017/7/11.
//  Copyright © 2017年 com.cn.fql. All rights reserved.
//

#import "TableViewAnimationKit.h"


#define XS_SCREEN_WIDTH 	[[UIScreen mainScreen] bounds].size.width
#define XS_SCREEN_HEIGHT 	[[UIScreen mainScreen] bounds].size.height

@interface TableViewAnimationKit ()

@end

@implementation TableViewAnimationKit

+ (void)cellAnimationWithTableView:(UITableView *)tableView animationType:(XRCellAnimationType)type {
	
	NSArray *cells 		= tableView.visibleCells;
	switch (type) {
		case XRCellAnimationTypeMove: {
			
			for (int i = 0; i < cells.count; i++) {
				
				CGFloat totalTime 		= 0.4;
				UITableViewCell *cell 	= [tableView.visibleCells objectAtIndex:i];
				cell.transform 			= CGAffineTransformMakeTranslation(-XS_SCREEN_WIDTH, 0);
				[UIView animateWithDuration:0.4
									  delay:i*(totalTime/cells.count)
					 usingSpringWithDamping:0.7 initialSpringVelocity:1/0.7
									options:UIViewAnimationOptionCurveEaseIn
								 animations:^{
					
									 cell.transform = CGAffineTransformIdentity;
								 } completion:nil];
			}
		}	break;
			
		case XRCellAnimationTypeAlpha: {
			
			for (int i = 0; i < cells.count; i++) {
				UITableViewCell *cell 	= [tableView.visibleCells objectAtIndex:i];
				cell.alpha 				= 0.0;
				[UIView animateWithDuration:0.3
									  delay:i*0.05
									options:0
								 animations:^{
					
									 cell.alpha = 1.0;
								 } completion:nil];
			}
		}	break;
			
		case XRCellAnimationTypeFall: {
			
			NSTimeInterval totalTime = 0.8;
			for (int i = 0; i < cells.count; i++) {
				UITableViewCell *cell 	= [tableView.visibleCells objectAtIndex:i];
				cell.transform 			= CGAffineTransformMakeTranslation(0, - XS_SCREEN_HEIGHT);
				[UIView animateWithDuration:0.3
									  delay:(cells.count - i)*(totalTime/cells.count)
									options:0
								 animations:^{
					
									 cell.transform = CGAffineTransformIdentity;
								 } completion:nil];
			}
		}	break;
			
		case XRCellAnimationTypeShake: {
			
			for (int i = 0; i < cells.count; i++) {
				UITableViewCell *cell 	= [cells objectAtIndex:i];
				cell.transform 			=  CGAffineTransformMakeTranslation(i % 2 == 0 ? -XS_SCREEN_WIDTH :XS_SCREEN_WIDTH ,0);
				[UIView animateWithDuration:0.4
									  delay:i*0.03
					 usingSpringWithDamping:0.75
					  initialSpringVelocity:1/0.75
									options:0
								 animations:^{
					
									 cell.transform = CGAffineTransformIdentity;
								 } completion:nil];
			}
		}	break;
			
		case XRCellAnimationTypeOverTurn: {
			
			for (int i = 0; i < cells.count; i++) {
				
				UITableViewCell *cell 		= [cells objectAtIndex:i];
				cell.layer.opacity 			= 0.0;
				cell.layer.transform 		= CATransform3DMakeRotation(M_PI, 1, 0, 0);
				NSTimeInterval totalTime 	= 0.7;
				[UIView animateWithDuration:0.3
									  delay:i*(totalTime/cells.count)
									options:0
								 animations:^{
									 
									 cell.layer.opacity = 1.0;
									 cell.layer.transform = CATransform3DIdentity;
								 } completion:nil];
			}
		}	break;
			
		case XRCellAnimationTypeToTop: {
			
			NSTimeInterval totalTime = 0.8;
			for (int i = 0; i < cells.count; i++) {
				
				UITableViewCell *cell 	= [tableView.visibleCells objectAtIndex:i];
				cell.transform 			= CGAffineTransformMakeTranslation(0,  XS_SCREEN_HEIGHT);
				[UIView animateWithDuration:0.35
									  delay:i*(totalTime/cells.count)
									options:UIViewAnimationOptionCurveEaseOut
								 animations:^{
									 
									 cell.transform = CGAffineTransformIdentity;
								 } completion:nil];
			}
		}	break;
			
		case XRCellAnimationTypeSpring: {
			
			for (int i = 0; i < cells.count; i++) {
				
				UITableViewCell *cell 		= [cells objectAtIndex:i];
				cell.layer.opacity 			= 0.7;
				cell.layer.transform 		= CATransform3DMakeTranslation(0, -XS_SCREEN_HEIGHT, 20);
				NSTimeInterval totalTime 	= 1.0;
				[UIView animateWithDuration:0.4
									  delay:i*(totalTime/cells.count)
					 usingSpringWithDamping:0.65
					  initialSpringVelocity:1/0.65
									options:UIViewAnimationOptionCurveEaseIn
								 animations:^{

									 cell.layer.opacity = 1.0;
									 cell.layer.transform = CATransform3DMakeTranslation(0, 0, 20);
								 } completion:nil];
			}

		}	break;
			
		case XRCellAnimationTypeShrinkToTop: {
			
			for (int i = 0; i < cells.count; i++) {
				
				UITableViewCell *cell 	= [cells objectAtIndex:i];
				CGRect rect 			= [cell convertRect:cell.bounds fromView:tableView];
				cell.transform 			= CGAffineTransformMakeTranslation(0, -rect.origin.y);
				[UIView animateWithDuration:0.5 animations:^{
					
					cell.transform = CGAffineTransformIdentity;
				}];
			}
		}	break;
			
		case XRCellAnimationTypeLayDown: {
			
			NSMutableArray *rectArr = [[NSMutableArray alloc] init];
			for (int i = 0; i < cells.count; i++) {
				
				UITableViewCell *cell 	= [cells objectAtIndex:i];
				CGRect rect 			= cell.frame;
				[rectArr addObject:[NSValue valueWithCGRect:rect]];
				rect.origin.y 			= i * 10;
				cell.frame 				= rect;
				cell.layer.transform 	= CATransform3DMakeTranslation(0, 0, i*5);
			}
			NSTimeInterval totalTime = 0.8;
			for (int i = 0; i < cells.count; i++) {
				UITableViewCell *cell 	= [cells objectAtIndex:i];
				CGRect rect 			= [[rectArr objectAtIndex:i] CGRectValue];
				[UIView animateWithDuration:(totalTime/cells.count) * i
								 animations:^{
									 
									 cell.frame = rect;
								 } completion:^(BOOL finished) {
									 
									 cell.layer.transform = CATransform3DIdentity;
								 }];
			}
		}	break;
			
		case XRCellAnimationTypeRote: {
			
			CABasicAnimation *animation 	= [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
			animation.fromValue 			= @(-M_PI);
			animation.toValue 				= 0;
			animation.duration 				= 0.3;
			animation.removedOnCompletion 	= NO;
			animation.repeatCount 			= 3;
			animation.fillMode 				= kCAFillModeForwards;
			animation.autoreverses 			= NO;
			
			for (int i = 0; i < cells.count; i++) {
				
				UITableViewCell *cell 	= [cells objectAtIndex:i];
				cell.alpha 				= 0.0;
				[UIView animateWithDuration:0.1
									  delay:i*0.25
									options:0
								 animations:^{
									 
									 cell.alpha = 1.0;
								 } completion:^(BOOL finished) {
									 
									 [cell.layer addAnimation:animation forKey:@"rotationYkey"];
								 }];
			}
		}	break;
		default:
			
			break;
	}
}

@end
