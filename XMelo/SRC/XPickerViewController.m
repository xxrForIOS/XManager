//
//  XPickerViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/8/26.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XPickerViewController.h"

@interface XPickerViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView      *picker;
@property (nonatomic, strong) UILabel           *contentLabel;

@end

@implementation XPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"picker";
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.picker = ({
        
        
        UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 64 - 200, kScreenWidth, 200)];
        picker.delegate = self;
        picker.dataSource = self;
        picker.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:picker];
        picker;
    });
    
    self.contentLabel = ({
        
        UILabel *theLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, kScreenWidth - 20, 30)];
        theLabel.textAlignment = NSTextAlignmentCenter;
        theLabel.font = kFontTheme(15);
        theLabel.backgroundColor = [UIColor cyanColor];
        theLabel.textColor = [UIColor blackColor];

        [self.view addSubview:theLabel];
        theLabel;
    });
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 5;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 50;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view __TVOS_PROHIBITED {
    
    UIImageView *theView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    theView.backgroundColor = kColorRandom;
    return theView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
