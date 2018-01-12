//
//  ImageValidationViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/9/1.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "ImageValidationViewController.h"
#import "NNValidationView.h"

@interface ImageValidationViewController ()

@property (nonatomic, strong) UITextField           *inputTF;
@property (nonatomic, strong) NNValidationView      *valView;

@end

@implementation ImageValidationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"图片验证码";
    @kWeakSelf;
    
    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
        
        return 1;
    };
    
    self.heightForRowAtIndexPath = ^CGFloat(NSIndexPath *indexPath) {
      
        return 60;
    };
    
    self.creatCellView = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
    
        selfWeak.inputTF = ({
			
			//WithFrame:CGRectMake(20, 5, kScreenWidth - 40, 50)
            UITextField *theTF 	= [[UITextField alloc]init];
            theTF.placeholder 	= @"请输入右侧图片内字母";
            theTF.font 			= kFontTheme(15);
            theTF.textColor 	= kColor_yan;
			theTF.rightViewMode = UITextFieldViewModeAlways;
			selfWeak.valView = ({
				
				NNValidationView *theView = [[NNValidationView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)
																	  andCharCount:4
																	  andLineCount:10];
				
				@kWeakObj(theView);
				theView.changeValidationCodeBlock = ^{
					
					YVLog(@"new code %@",theViewWeak.charString);
				};
				theView;
			});
			
			theTF.rightView = selfWeak.valView;
            [cell.contentView addSubview:theTF];
			[theTF mas_makeConstraints:^(MASConstraintMaker *make) {
				
				make.left.mas_offset(20);
				make.top.and.bottom.mas_offset(0);
				make.right.offset(-20);
//				make.edges.mas_offset(UIEdgeInsetsMake(0, 20, 0, 20));
			}];
			
			

            theTF;
        });
    };
    
    [self showFooerButtonWithTitle:@"验证" clickBlock:^(UIButton *aButton) {
       
        if ([selfWeak.inputTF.text isEqualToString:@""]) {
            
            [XAlertController showAlertWith:@"还没输入"];
            return;
        }

        if ([selfWeak.inputTF.text isSameCompareNoCaseWith:selfWeak.valView.charString]) {
            
            [XAlertController showAlertWith:@"那你好胖胖哦"];
        } else {
            
            [XAlertController showAlertWith:@"打错了呢"];
        }
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
