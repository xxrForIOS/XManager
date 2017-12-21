//
//  XImagePicker.h
//  XMelo
//
//  Created by X.Melo on 2017/8/26.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^pickerImagePic)(UIImage *pickerImagePic);
@interface XImagePicker : NSObject


@property (copy, nonatomic) pickerImagePic              pickerImagePic;


+ (void)showImagePickerViewIn:(UIViewController *)vcc handler:(pickerImagePic)aBlock;



@end
