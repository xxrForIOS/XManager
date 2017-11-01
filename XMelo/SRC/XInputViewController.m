//
//  XInputViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/8/26.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XInputViewController.h"

#import "FSTextView.h"

@interface XInputViewController ()

@property (nonatomic, strong) FSTextView        *fsTextView;
@property (nonatomic, strong) UILabel           *fsLabel;

@end

@implementation XInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
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
