//
//  CHZSendEChatController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHZSendEChatController.h"

@interface CHZSendEChatController ()<UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *myTextView;

@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@end

@implementation CHZSendEChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIGestureRecognizer *singeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTouch:)];
    
    [self.showImageView addGestureRecognizer:singeTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark -- AddTextField

#pragma mark --UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"/n"])
    {
        [textView resignFirstResponder];
    }
    return  YES;
}

#pragma mark -- ImageViewTouch
- (void)imageTouch:(UITapGestureRecognizer *)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击拍照
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            // 0）实例化控制器
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            // 1）设置照片源
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            
            // 2) 设置允许修改
            [picker setAllowsEditing:YES];
            // 3) 设置代理
            [picker setDelegate:self];
            // 4) 显示控制器
            [self presentViewController:picker animated:YES completion:nil];
            
        } else {
            NSLog(@"照片源不可用");
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击去相册
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            // 0）实例化控制器
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            // 1）设置照片源
            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            
            // 2) 设置允许修改
            [picker setAllowsEditing:YES];
            // 3) 设置代理
            [picker setDelegate:self];
            // 4) 显示控制器
            [self presentViewController:picker animated:YES completion:nil];
            
        } else {
            CHLog(@"照片源不可用");
        }
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];

}
#pragma mark - imagePicker代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    [self.showImageView setImage:image];
    
    // 关闭照片选择器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 需要将照片保存至应用程序沙箱，由于涉及到数据存储，同时与界面无关
    // 可以使用多线程来保存图像
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 保存图像
        // 1. 取图像路径
        NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *imagePath = [docs[0]stringByAppendingPathComponent:@"abc.png"];
        // 2. 转换成NSData保存
        NSData *imageData = UIImagePNGRepresentation(image);
        [imageData writeToFile:imagePath atomically:YES];
    });
}
@end
