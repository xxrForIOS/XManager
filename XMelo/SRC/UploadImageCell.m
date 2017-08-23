//
//  UploadImageCell.m
//  XMelo
//
//  Created by X.Melo on 2017/8/23.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "UploadImageCell.h"

@interface UploadImageCell()

@property (nonatomic, strong) UIButton          *upLoadButton;
@property (nonatomic, assign) NSInteger         currentIndex;
@property (nonatomic, strong) NSArray           *uplodImageButtons;
@property (nonatomic, strong) NSMutableArray    *uploadImages;

@end

@implementation UploadImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        
        return nil;
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.uploadImages = [NSMutableArray arrayWithCapacity:6];
    
    CGFloat imageWidth = (kScreenWidth - 10 * 4) / 3;
    NSMutableArray *tmpButtons = [NSMutableArray arrayWithCapacity:6];
    for (int index = 0; index < 6; index ++) {
        
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
        theButton.hidden = YES;
        theButton.frame = CGRectMake(10 + (imageWidth + 10) * (index % 3),
                                     10 + (imageWidth + 10) * (index / 3),
                                     imageWidth, imageWidth);
        [self.contentView addSubview:theButton];
        theButton.tag = 100 + index;
        theButton.layer.masksToBounds = YES;
        [tmpButtons addObject:theButton];
        
        
        UIButton *deleButton = ({
            UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
            dele.frame = CGRectMake(theButton.width - 20, 0, 20, 20);
            dele.layer.cornerRadius = 10;
            [dele setBackgroundColor:[UIColor redColor]];
            [dele setTitle:@"×" forState:UIControlStateNormal];
            dele.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            [dele addBlockWithblock:^(id sender) {
               
                if ([theButton.currentImage isKindOfClass:[UIImage class]]) {
                    
                    UIImage *theImage = self.uploadImages[theButton.tag - 100];
                    if (theImage) {
                    
                        [self.uploadImages removeObjectAtIndex:theButton.tag - 100];
                        [self updateUploadImageButtonFrame];
                        if (self.uploadImages) {
                            
                            self.uploadImage(self.uploadImages, [self getFinalHeightWith]);
                        }
                    }
                }
            }];
            dele;
        });
        [theButton addSubview:deleButton];
    }
    self.uplodImageButtons = [NSArray arrayWithArray:tmpButtons];

    
    self.upLoadButton = ({
        
        UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [theButton setImage:kImageName(@"uploadImage") forState:UIControlStateNormal];
        [theButton setImage:kImageName(@"uploadImage") forState:UIControlStateSelected];
        theButton.frame = CGRectMake(10, 10, imageWidth, imageWidth);
        [theButton addBlockWithblock:^(id sender) {
            
            [YVImagePicker showImagePickerViewIn:self.viewController handler:^(UIImage *pickerImagePic) {
                
                [self.uploadImages addObject:pickerImagePic];
                if (self.uploadImages) {
                    
                    self.uploadImage(self.uploadImages, [self getFinalHeightWith]);
                }
                [self updateUploadImageButtonFrame];
            }];
        }];
        [self.contentView addSubview:theButton];
        theButton;
    });
    
    return self;
}

- (void)configImagesWith:(NSArray<UIImage *> *)images {
    
    [self.uploadImages removeAllObjects];
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
    
    if (self.uploadImages.count != 6) {
        
        self.upLoadButton.hidden = NO;
        UIButton *theImageButton = self.uplodImageButtons[self.uploadImages.count];
        self.upLoadButton.frame = theImageButton.frame;
    } else {
        
        self.upLoadButton.hidden = YES;
    }
}

- (CGFloat)getFinalHeightWith{
    
    int row = (int)self.uploadImages.count / 3;
    if (self.uploadImages.count >= 6) {
        
        row = 1;
    }
    
    CGFloat height = ((kScreenWidth - 10 * 4) / 3 + 10 ) * (row + 1);
    return height;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
