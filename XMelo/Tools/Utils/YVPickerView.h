//
//  YVPickerView.h
//  YIVITestProject
//
//  Created by X.Melo on 2017/8/29.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^ XRPickerChooseObject)(id chooseObj);
@interface YVPickerView : NSObject


+ (void)showPickerIn:(UIViewController *)vcc withDatas:(NSArray *)datas handler:(XRPickerChooseObject)aBlock;

@end
