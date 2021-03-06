//
//  XImagePicker.m
//  XMelo
//
//  Created by X.Melo on 2017/8/26.
//  Copyright © 2017年 欣欣然. All rights reserved.
//

#import "XImagePicker.h"

static char     xImagePickerViewBlockKey;
@interface XImagePicker() <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@end



@implementation XImagePicker

+ (XImagePicker *)sharedManager {
    static XImagePicker *sharedManager = nil;
    
    @synchronized (self) {
        
        if (!sharedManager) {
            sharedManager = [[[self class] alloc] init];
        }
    }
    return sharedManager;
}



#pragma mark- 相册相机选择照片的actionsheet
+ (void)showImagePickerViewIn:(UIViewController *)vcc handler:(pickerImagePic)aBlock{
    
    __block UIViewController    *theVC = vcc;
    __block XImagePicker       *theSelf = [self sharedManager];
    objc_setAssociatedObject(theSelf, &xImagePickerViewBlockKey, aBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"照片"
                                                                   message:@"您可以选择不同的图片"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = theSelf;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        theVC.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        [theVC presentViewController:imagePicker animated:YES completion:nil];
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            
            YVLog(@"模拟器不支持拍照");
            return ;
        }
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = theSelf;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [theVC presentViewController:imagePicker animated:YES completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [theVC presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        
        UIImage *aImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];//编辑之后的图片
        pickerImagePic block = objc_getAssociatedObject(self, &xImagePickerViewBlockKey);
        [picker dismissViewControllerAnimated:YES completion:^{
            
            if (block) {
                
                block(aImage);
            }
        }];
    }
}

@end
