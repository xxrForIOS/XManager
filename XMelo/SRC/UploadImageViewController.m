//
//  UploadImageViewController.m
//  XMelo
//
//  Created by X.Melo on 2017/8/23.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "UploadImageViewController.h"
#import "UploadImageCell.h"

@interface UploadImageViewController ()

@property (nonatomic, assign) CGFloat           theUploadCellHeght;
@property (nonatomic, strong) NSMutableArray    *uploadImages;

@end


@implementation UploadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"上传图片";
    self.uploadImages = [NSMutableArray arrayWithCapacity:6];
    self.theUploadCellHeght = ((kScreenWidth - 40) / 3 + 10) + 10;
    @kWeakSelf;

    self.numberOfRowsInSection = ^NSInteger(NSInteger section) {
        
        return 3;
    };
    
    self.heightForRowAtIndexPath = ^CGFloat(NSIndexPath *indexPath) {
      
        NSArray *heights = @[@50,
                             [NSNumber numberWithFloat:selfWeak.theUploadCellHeght + 10],
                             @100];
        return [heights[indexPath.row] floatValue];
    };
    
    [self.tableView registerClass:[UploadImageCell class] forCellReuseIdentifier:@"uploadCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    self.cellForRowAtIndexPath = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
      
        
//        if (indexPath.row == 0) {
//            
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//            cell.textLabel.text = @"custom cell for something";
//            cell.textLabel.font = kFontTheme(14);
//            cell.textLabel.textColor = [UIColor blackColor];
//            return cell;
//        }
        
        if (indexPath.row == 1) {
            
            UploadImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"uploadCell" forIndexPath:indexPath];
            
            @kWeakObj(cell);
            cell.uploadImage = ^(NSArray *images, CGFloat cellHeight) {
                
                if (selfWeak.uploadImages) {
                    
                    [selfWeak.uploadImages removeAllObjects];
                }
                selfWeak.uploadImages = [NSMutableArray arrayWithArray:images];
                
                selfWeak.theUploadCellHeght = cellHeight;
                
                NSIndexPath *theIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [selfWeak.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:theIndexPath,nil]
                                          withRowAnimation:UITableViewRowAnimationNone];
                
                [cellWeak configImagesWith:selfWeak.uploadImages];
            };
            return cell;
        } else {
            
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.text = @"[tableView dequeueReusableCellWithIdentifier:@\"cell\" forIndexPath:indexPath]";
            cell.textLabel.font = kFontTheme(14);
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.textColor = [UIColor blackColor];
            return cell;
        }

        return nil;
    };
}

- (void)creatCellView:(UploadImageCell *)cell With:(NSIndexPath *)indexPath {
    for (UIView *theView in cell.contentView.subviews) {
        [theView removeFromSuperview];
    }
    
    
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"展位数据";
    }
    
    if (indexPath.row == 1) {
        
        
    }

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
