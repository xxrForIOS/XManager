//
//  YVImagePicker.h
//  YiWeiZD
//
//  Created by X.Melody on 17/5/2.
//  Copyright © 2017年 一喂直达. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHead.h"

typedef void(^pickerImagePic)(UIImage *pickerImagePic);


@interface YVImagePicker : NSObject



@property (copy, nonatomic) pickerImagePic              pickerImagePic;



+ (void)showImagePickerViewIn:(UIViewController *)vcc handler:(pickerImagePic)aBlock;

@end
