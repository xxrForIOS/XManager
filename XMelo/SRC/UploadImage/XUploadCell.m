//
//  XUploadCell.m
//  XMelo
//
//  Created by X.Melo on 2017/9/5.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XUploadCell.h"

@interface XUploadCell()

@property (nonatomic, strong) UILabel           *remarkLabel;
@property (nonatomic, strong) UIButton          *rightButton;
@property (nonatomic, strong) UIButton          *upLoadButton;
@property (nonatomic, assign) NSInteger         currentIndex;

@property (nonatomic, strong) NSArray           *uplodImageButtons;
@property (nonatomic, strong) NSMutableArray    *uploadImages;
@property (nonatomic, strong) UIView            *bgView;

@end

@implementation XUploadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.remarkLabel = ({
        
        UILabel *theLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 30)];
        theLabel.textColor = kColorThemeGray;
        theLabel.text = @"简介";
        theLabel.font = kFontTheme(14);
        [self.contentView addSubview:theLabel];
        theLabel;
    });
    [self.remarkLabel updateWidth];
    
    
    self.introTextfield = ({
        
        UITextField *theTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.remarkLabel.maxX + 10, 10,
                                                                                 kScreenWidth - self.remarkLabel.maxX - 50, self.remarkLabel.height)];
        theTextField.textColor = kColorThemeBlack;
        theTextField.placeholder = @"请输入物品,收货人大概位置,要求等";
        theTextField.font = kFontTheme(14);
        [self.contentView addSubview:theTextField];
        theTextField;
    });
    
    self.rightButton = ({
        
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
        theButton.frame = CGRectMake(kScreenWidth - 50, 10, 30, 30);
        theButton.layer.cornerRadius = theButton.height/2;
        theButton.layer.masksToBounds = YES;
        [theButton setBackgroundImage:[XManager getImageFromColor:[UIColor cyanColor]] forState:UIControlStateSelected];
        [theButton setBackgroundImage:[XManager getImageFromColor:[UIColor redColor]] forState:UIControlStateNormal];
        theButton.selected = NO;

		@kWeakSelf;
		[theButton addBlockWithTouchUpInside:^(UIButton *sender) {

			if (sender.isSelected == NO) {

				selfWeak.bgView.hidden = NO;
				sender.selected = YES;
				selfWeak.cellOpenBlock((kScreenWidth - 10 * 4) / 3 + 50 + 20);
			} else {

				selfWeak.bgView.hidden = YES;
				sender.selected = NO;
				selfWeak.cellOpenBlock(50);
			}
		}];
        [selfWeak.contentView addSubview:theButton];
        theButton;
    });
    
    self.uploadImages = [NSMutableArray arrayWithCapacity:3];
    CGFloat imageWidth = (kScreenWidth - 10 * 4) / 3;
    self.bgView = ({
        
        UIView *theView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, imageWidth + 20)];
        theView.backgroundColor = [UIColor whiteColor];
        theView.hidden = YES;
        [self.contentView addSubview:theView];
        theView;
    });
    
    NSMutableArray *tmpButton = [NSMutableArray arrayWithCapacity:3];
    for (int index = 0; index < 3; index ++) {
        
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
        theButton.hidden = YES;
        theButton.frame = CGRectMake(10 + (imageWidth + 10) * index, 10,
                                     imageWidth, imageWidth);
        theButton.tag = 100 + index;
        theButton.layer.masksToBounds = YES;
        [self.bgView addSubview:theButton];
        [tmpButton addObject:theButton];
        
        [theButton addSubview:({

            UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
            dele.frame = CGRectMake(theButton.width - 20, 0, 20, 20);
            dele.layer.cornerRadius = 10;
            [dele setBackgroundColor:[UIColor redColor]];
            [dele setTitle:@"×" forState:UIControlStateNormal];
            dele.titleLabel.font = [UIFont boldSystemFontOfSize:18];

//			@kWeakSelf;
			[dele addBlockWithTouchUpInside:^(UIButton *sender) {


				if ([theButton.currentImage isKindOfClass:[UIImage class]]) {
//
//					UIImage *theImage = selfWeak.uploadImages[theButton.tag - 100];
//					if (theImage) {
//
//						[selfWeak.uploadImages removeObjectAtIndex:theButton.tag - 100];
//						[selfWeak configImagesWith:selfWeak.uploadImages];
//						!selfWeak.uploadImages ?: selfWeak.upImageBlock(selfWeak.uploadImages);
//					}
				}
			}];
            dele;
        })];
        self.uplodImageButtons = [NSArray arrayWithArray:tmpButton];
    }
    
    self.upLoadButton = ({
        
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [theButton setImage:kImageName(@"uploadImage") forState:UIControlStateNormal];
        [theButton setImage:kImageName(@"uploadImage") forState:UIControlStateSelected];
        theButton.frame = CGRectMake(10, 10, imageWidth, imageWidth);
		[theButton addBlockWithTouchUpInside:^(UIButton *sender) {

//			@kWeakSelf;
//			[XImagePicker showImagePickerViewIn:selfWeak.viewController handler:^(UIImage *pickerImagePic) {
//
//				[selfWeak.uploadImages addObject:pickerImagePic];
//				[selfWeak configImagesWith:selfWeak.uploadImages];
//				!selfWeak.upImageBlock ?: selfWeak.upImageBlock(selfWeak.uploadImages);
//			}];
		}];
        [self.bgView addSubview:theButton];
        theButton;
    });
    
    return self;
}

- (void)configImagesWith:(NSArray<UIImage *> *)images {
    
    self.uploadImages = [NSMutableArray arrayWithArray:images];
    [self updateUploadImageButtonFrame];
}

- (void)updateUploadImageButtonFrame {
    
    for (UIButton *theButton in self.uplodImageButtons) {
        
        theButton.hidden = YES;
    }
    
    for (int index = 0; index < self.uploadImages.count; index ++) {
        
        UIButton *theImageButton = self.uplodImageButtons[index];
        theImageButton.hidden = NO;
        [theImageButton setImage:self.uploadImages[index] forState:UIControlStateNormal];
    }
    
    if (self.uploadImages.count != 3) {
        
        self.upLoadButton.hidden = NO;
        UIButton *theImageButton = self.uplodImageButtons[self.uploadImages.count];
        self.upLoadButton.frame = theImageButton.frame;
    } else {
        
        self.upLoadButton.hidden = YES;
    }
}

@end
