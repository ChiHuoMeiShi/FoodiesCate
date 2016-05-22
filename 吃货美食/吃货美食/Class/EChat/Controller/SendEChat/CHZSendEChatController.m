//
//  CHZSendEChatController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHZSendEChatController.h"
#import "CHRTextView.h"
#import "GDataXMLNode.h"
#import "CHUserDefaults.h"
@interface CHZSendEChatController ()<UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet CHRTextView *chTextView;

@property (weak, nonatomic) IBOutlet UIButton *selectImage;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, strong)NSData *imageData;

@end

@implementation CHZSendEChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chTextView.placeholder = @"无法接受了；扩大及法律凯撒的离开；撒";
    [self.selectImage addTarget:self action:@selector(selectImageClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTittle:@"发布" withTittleColor:[UIColor redColor] withTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)navBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)publishBtnClick
{
    //上传
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //接收xml
    //    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:userDefault.email password:userDefault.password];
    [manager.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"application/xml",nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/topic_img_upload.php";
    [manager POST:kUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:self.imageData name:@"img_0" fileName:@"img_0.jpg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //开始解析xml
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseObject encoding:NSUTF8StringEncoding error:nil];
        
        //获取根节点（items）
        GDataXMLElement *rootElement = [doc rootElement];
        
        NSArray *imgs = [rootElement elementsForName:@"imgs"];
        
        for (GDataXMLElement *img in imgs) {
            NSString *imgStr = [img stringValue];
            
            /*******************/
            //	NSString to NSDictionary
            NSError *error = nil;
            NSDictionary *string2dic = [NSJSONSerialization JSONObjectWithData: [imgStr dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
            self.imageName = string2dic[@"img_0"];
            NSLog(@"%@",self.imageName);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"#######upload error%@", error);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.chTextView resignFirstResponder];
    
}
#pragma mark --selectImageClick
- (void)selectImageClick
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
    [self.selectImage setBackgroundImage:image forState:UIControlStateNormal];
    
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
        
        self.imageData = imageData;
        [imageData writeToFile:imagePath atomically:YES];
    });
}
@end
