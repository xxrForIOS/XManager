//
//  UIImage+Scale.h
//  YiWeiZD
//
//  Created by X.Melody on 2017/5/8.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)


-(UIImage*)getSubImage:(CGRect)rect;


- (UIImage *)imageScaleWithSize:(CGSize)size;
@end
