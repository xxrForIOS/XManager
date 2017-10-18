//
//  XPickerViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/8/26.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XPickerViewController.h"
#import <MLeaksFinder/MLeaksFinder.h>


//#import "YVPickerView.h"

@interface XPickerViewController ()

//@property (nonatomic, strong) UIButton      *stringButton;
//@property (nonatomic, strong) UIButton      *imageButton;
//@property (nonatomic, copy)   NSString      *chooseString;
//@property (nonatomic, strong) UIImage       *chooseImage;

@end

@implementation XPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"custom picker";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    @kWeakSelf;
//    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
//
//        return 2;
//    };
//
//    self.heightForRowAtIndexPath = ^CGFloat(NSIndexPath *indexPath) {
//
//        return 50;
//    };

	[XManager addRightBarItemInViewController:self itemTitle:@"dismiss" andItemBlock:^(UIButton *aButton) {

//		[selfWeak.navigationController popViewControllerAnimated:YES];
		[selfWeak dismissViewControllerAnimated:YES completion:nil];
	}];

    self.creatCellView = ^(UITableViewCell *cell, NSIndexPath *indexPath) {
      
		cell.textLabel.text = @"xxx";//@[@"show string picker", @"show image picker"][indexPath.row];
//        cell.textLabel.font = kFontTheme(14);

//        //textlabel会覆盖右侧自定义控件 只是显示的话，透明背景颜色即可 如需交互还是老老实实全自定义
//        cell.textLabel.backgroundColor = [UIColor clearColor];
//        if (indexPath.row == 0) {
//
//            selfWeak.stringButton = ({
//
//                UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                theButton.frame = CGRectMake(kScreenWidth - 70, 5, 70, 40);
//                theButton.titleLabel.font = kFontTheme(15);
//                [theButton setTitleColor:kColor_yan forState:UIControlStateNormal];
//                [cell.contentView addSubview:theButton];
//                theButton;
//            });
//            [selfWeak.stringButton setTitle:selfWeak.chooseString forState:UIControlStateNormal];
//        }
//
//        if (indexPath.row == 1) {
//
//            selfWeak.imageButton = ({
//
//                UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                theButton.frame = CGRectMake(kScreenWidth - 70, 5, 70, 40);
//                [cell.contentView addSubview:theButton];
//                theButton;
//            });
//            [selfWeak.imageButton setImage:selfWeak.chooseImage forState:UIControlStateNormal];
//        }
    };
    
//    self.didSelectRowAtIndexPath = ^(NSIndexPath *indexPath) {

//        [YVPickerView showPickerIn:selfWeak withDatas:[selfWeak configDatasIn:indexPath] handler:^(id chooseObj) {
//
//            if (indexPath.row == 0) {
//
//                selfWeak.chooseString = (NSString *)chooseObj;
//                [selfWeak.stringButton setTitle:(NSString *)chooseObj forState:UIControlStateNormal];
//            } else {
//
//                selfWeak.chooseImage = (UIImage *)chooseObj;
//                [selfWeak.imageButton setImage:(UIImage *)chooseObj forState:UIControlStateNormal];
//            }
//        }];
//    };
}

//- (NSArray *)configDatasIn:(NSIndexPath *)indexPath {
//
//    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:0];
//    if (indexPath.row == 0) {
//
//        for (int index = 0; index < 11; index ++) {
//
//            NSString *theString = kStringFormat(@"%u",arc4random()%100);
//            [tmpArray addObject:theString];
//        }
//    } else {
//
//        for (int index = 0; index < 10; index ++) {
//
//            UIImage *theImage = kImageName(@"wish_grab_%d",index + 1);
//            [tmpArray addObject:theImage];
//        }
//    }
//
//    return [NSArray arrayWithArray:tmpArray];
//}

//- (BOOL)willDealloc
//{
//	if(![super willDealloc]) {
//		return NO;
//	}
//	// 可以这样 我们来看看是哪个对象没有被释放
//	MLCheck(self);
//	return YES;
//}




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
