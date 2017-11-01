//
//  YVPickerView.m
//  YIVITestProject
//
//  Created by X.Melo on 2017/8/29.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "YVPickerView.h"

static char     yvPickerViewKey;

@interface YVPickerView() <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray       *datas;
@property (nonatomic, assign) BOOL          isChoose;
@end


@implementation YVPickerView


+ (YVPickerView *)sharedManager {
    static YVPickerView *sharedManager = nil;
    
    @synchronized (self) {
        
        if (!sharedManager) {
            sharedManager = [[[self class] alloc] init];
        }
    }
    return sharedManager;
}

+ (void)showPickerIn:(UIViewController *)vcc withDatas:(NSArray *)datas handler:(XRPickerChooseObject)aBlock {
    
    __block UIViewController *theVC = vcc;
    __block YVPickerView *theSelf = [self sharedManager];
    
    theSelf.isChoose = NO;
    theSelf.datas = [NSArray arrayWithArray:datas];
    objc_setAssociatedObject(theSelf, &yvPickerViewKey, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UIView *theView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    theView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [theVC.navigationController.view addSubview:theView];
    theView.userInteractionEnabled = YES;
//    [theView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
//
//        [theView removeFromSuperview];
//        if (!theSelf.isChoose) {
//
//            !aBlock ?: aBlock(datas[0]);
//        }
//    }]];

    UIView *toolBar = [[UIView alloc]initWithFrame:CGRectMake(0, theView.height - 216 - 40, kScreenWidth, 40)];
    toolBar.backgroundColor = kColorRGB(240, 240, 240,1);
    [theView addSubview:toolBar];
    
    UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
    theButton.frame = CGRectMake(kScreenWidth - 80, 0, 80, 40);
    [theButton setTitle:@"完成" forState:0];
    [theButton setTitleColor:kColorHex(0x2a83fb) forState:UIControlStateNormal];
    theButton.titleLabel.font = kFontTheme(15);
    theButton.backgroundColor = kColorRGB(240, 240, 240,1);
    [toolBar addSubview:theButton];
//    [theButton addBlockWithblock:^(UIButton *button) {
//
//        [theView removeFromSuperview];
//        if (!theSelf.isChoose) {
//            
//            !aBlock ?: aBlock(datas[0]);
//        }
//    }];

    UIPickerView *thePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 216, kScreenWidth, 216)];
    thePicker.delegate = theSelf;
    thePicker.dataSource = theSelf;
    thePicker.backgroundColor = [UIColor whiteColor];
    [theView addSubview:thePicker];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 60;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.datas.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
    theButton.frame = CGRectMake(0, 5, kScreenWidth, 50);
    theButton.backgroundColor = [UIColor whiteColor];
    [theButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    theButton.titleLabel.font = kFontTheme(15);
    
    id dataCell = self.datas[0];
    if ([dataCell isKindOfClass:[UIImage class]]) {
        
        [theButton setImage:(UIImage *)self.datas[row] forState:UIControlStateNormal];
    }
    
    if ([dataCell isKindOfClass:[NSString class]]) {
        
        [theButton setTitle:(NSString *)self.datas[row] forState:UIControlStateNormal];
    }
    return theButton;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    self.isChoose = YES;
    id chooseObje = self.datas[row];
    XRPickerChooseObject block = objc_getAssociatedObject(self, &yvPickerViewKey);
    !block ?: block(chooseObje);
}


@end
