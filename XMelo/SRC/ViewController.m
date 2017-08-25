//
//  ViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/7/4.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ViewController.h"
#import "XHead.h"
#import "XViewController.h"
#import "JTNavigationController.h"
#import "JTBaseNavigationController.h"

#import "UploadImageViewController.h"

#import "FSTextView.h"
@interface ViewController () <UISearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UISearchBar       *searchBar;

@property (nonatomic, strong) FSTextView        *fsTextView;
@property (nonatomic, strong) UILabel           *fsLabel;

@property (nonatomic, strong) UIPickerView      *picker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    NSString * a = @"123456";
    NSString * b = @"abcdefg";
    a = b;
    b = @"奥卡姆剃须刀";
    NSLog(@"%@",a);

    self.view.backgroundColor = kColor_yuebai;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        
        UploadImageViewController *firstVC = [[UploadImageViewController alloc] init];
        JTNavigationController *navvvvvvvv = [[JTNavigationController alloc]initWithRootViewController:firstVC];
        JTBaseNavigationController *firstNav = [[JTBaseNavigationController alloc] initWithRootViewController:navvvvvvvv];
        self.view.window.rootViewController = firstNav;
    }]];
    
    
    self.picker = ({
        
        
        UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 64 - 200, kScreenWidth, 200)];
        picker.delegate = self;
        picker.dataSource = self;
        picker.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:picker];
        picker;
    });
    

    self.fsTextView = [[FSTextView alloc]initWithFrame:CGRectMake(15, 250, kScreenWidth - 30, 50)];
    self.fsTextView.backgroundColor = [UIColor cyanColor];
    self.fsTextView.textColor = [UIColor blackColor];
    self.fsTextView.font = kFontTheme(15);
    [self.view addSubview:self.fsTextView];
    self.fsTextView.maxLength = 15;
    
    // 达到最大限制时提示的Label
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.fsTextView.height - 20, self.fsTextView.width - 10, 20)];
    noticeLabel.font = kFontTheme(15);
    noticeLabel.textColor = UIColor.lightGrayColor;
    noticeLabel.textAlignment = NSTextAlignmentRight;
    noticeLabel.text = kStringFormat(@"0/15");
    [self.fsTextView addSubview:noticeLabel];
    
    __weak __typeof(&*noticeLabel)weakNoticeLabel = noticeLabel;
    [self.fsTextView addTextDidChangeHandler:^(FSTextView *textView) {
    
//        (textView.text.length < textView.maxLength) ? weakNoticeLabel.text = @"":NULL;
        
        weakNoticeLabel.textColor = UIColor.lightGrayColor;
        weakNoticeLabel.text = kStringFormat(@"%lu/%lu",(unsigned long)textView.text.length, (unsigned long)textView.maxLength);
    }];
    
    [self.fsTextView addTextLengthDidMaxHandler:^(FSTextView *textView) {
        
        weakNoticeLabel.textColor = UIColor.redColor;
        weakNoticeLabel.text = [NSString stringWithFormat:@"最多%zi个", textView.maxLength];
    }];
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 5;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}


- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED {
    
    return @"something";

}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view __TVOS_PROHIBITED {

    if (component == 1) {
        UIImageView *theView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        theView.backgroundColor = kColorRandom;
        return theView;
    } else {
        
        return nil;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
