//
//  CHMyInfoController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/25.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHMyInfoController.h"
#import "CHUserDefaults.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "CHNameViewCell.h"
#import "CHLoginController.h"
#import "GDataXMLNode.h"
#import "CHHTTPRequestManager.h"
#import "CHLocation.h"
#import "CHDBHelper.h"
#import "CHAboutUsController.h"

@interface CHMyInfoController () <UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate>
{
    CGFloat _tableViewY;
}
@property (nonatomic,strong)UIButton *iconBtn;
@property (nonatomic,strong)UITextField *nameTextField;
@property (nonatomic,strong)UITableView *mTableView;
@property (nonatomic,strong)NSData *imageData;
@property (nonatomic,strong)NSString *imageName;



@end

@implementation CHMyInfoController
- (void)viewWillAppear:(BOOL)animated{
    [self.mTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"个人信息";
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self viewlayout];
    
}
- (void)navBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewlayout{
    CGFloat btnY = 64 + 50.f;
    CGFloat btnW = 120.f;
    CGFloat btnX = CHSCREENWIDTH / 2 - btnW / 2;
    CGFloat btnH = btnW;
    self.iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    
    _tableViewY = btnY + btnW + 70.f;
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:userDefault.photo] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [self.iconBtn setImage:image forState:UIControlStateNormal];
    }];
    [self.iconBtn addTarget:self action:@selector(changeIcon) forControlEvents:UIControlEventTouchUpInside];
    self.iconBtn.layer.masksToBounds = YES;
    self.iconBtn.layer.cornerRadius = self.iconBtn.width * 0.5;
    [self.view addSubview:self.iconBtn];
    //tableView
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, _tableViewY, CHSCREENWIDTH, CHSCREENHEIGH - _tableViewY) style:UITableViewStyleGrouped];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"CHNameViewCell" bundle:nil] forCellReuseIdentifier:@"CHNameViewCell"];
    
    [self.view addSubview:self.mTableView];
    
}
- (void)changeIcon{
    
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
            CHLog(@"照片源不可用");
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
    
    [self.iconBtn setImage:image forState:UIControlStateNormal];

    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 需要将照片保存至应用程序沙箱，由于涉及到数据存储，同时与界面无关
    // 可以使用多线程来保存图像
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 保存图像
        // 1. 取图像路径
        NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *imagePath = [docs[0]stringByAppendingPathComponent:@"newICon.png"];
        // 2. 转换成NSData保存
        NSData *imageData = UIImagePNGRepresentation(image);
        
        self.imageData = imageData;
        [imageData writeToFile:imagePath atomically:YES];
        
        [self uploadImage];
        
    });
}

- (void)uploadImage{
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //接收xml
    //    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:userDefault.email password:userDefault.password];
    [manager.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"application/xml",@"text/html",nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/modi_userinfo.php?format=json";
    
    NSString *encodeKurl = [kUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //如果带图片
    if (self.imageData) {
        [manager POST:encodeKurl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:self.imageData name:@"photo" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSDictionary *dataDict = dict[@"data"];
            self.imageName = [dataDict objectForKey:@"photo"];
            CHLog(@"上传头像返回的信息%@",self.imageName);
            CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
            NSDictionary *userDict = @{@"photo":self.imageName ,@"sex": userDefault.sex ,@"user_id" :userDefault.user_id ,@"user_name":userDefault.user_name, @"password":userDefault.password , @"email":userDefault.email};
            
            [userDefault setUserDict:userDict];

//            [userDefault setPhoto:self.imageName];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            CHLog(@"#######upload error%@", error);
        }];
    }
}


#pragma mark - UITableViewDataSource
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return @"昵称只能输入汉字字母和数字";
    }else if (1 == section) {
        return @"设置";
    }else if (2 == section){
        return @"退出当前账号";
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CHNameViewCell *nameCell = [tableView dequeueReusableCellWithIdentifier:@"CHNameViewCell"];
        CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
        nameCell.nameTextField.text = userDefault.user_name;

        nameCell.nameTextField.delegate = self;
        
        return nameCell;
    }
    static NSString *ID = @"ZTCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        //缓存的路径
        NSFileManager* fileManager=[NSFileManager defaultManager];
        NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *pathStr = [NSString stringWithFormat:@"%@/test.sqlite",docs[0]];
        NSString *plistPathStr = [NSString stringWithFormat:@"%@/CHJRecommendModel.plist",docs[0]];
        NSError *error = nil;
        NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:pathStr error:&error];
        NSDictionary *fileAttributes2 = [fileManager attributesOfItemAtPath:plistPathStr error:&error];
        
        float size = 0;
        float size2 = 0;
        if (fileAttributes != nil) {
            //这里是B 字节
            NSString *fileSize = [fileAttributes objectForKey:NSFileSize];
            size = [fileSize floatValue] / 1024  ;
//            fileSize+= fileAttributes.fileSize/ 1024.0/1024.0;
            if (fileSize) {
                CHLog(@"File size: %fMB\n",size/10);
            }
            
        }
        else {  
            CHLog(@"Path (%@) is invalid.", pathStr);
        }
        if (fileAttributes2 != nil) {
            //这里是B 字节
            NSString *fileSize = [fileAttributes2 objectForKey:NSFileSize];
            size2 = [fileSize floatValue] / 1024  ;
            //            fileSize+= fileAttributes.fileSize/ 1024.0/1024.0;
            if (fileSize) {
                CHLog(@"File size: %fMB\n",size2);
            }
            
        }
        else {
            CHLog(@"Path (%@) is invalid.", plistPathStr);
        }
        
        float totalSize = (size + size2)/10;
        cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(%.1fMB)",totalSize];
        
    }else if (indexPath.section == 1 && indexPath.row == 1){
        cell.textLabel.text = @"关于我们";
    }else if (indexPath.section == 2){
        UIButton *logout = [[UIButton alloc] initWithFrame:CGRectMake(10.f, 5.f, CHSCREENWIDTH - 20.f, 50.f)];
        [logout setTitle:@"退出登录" forState:UIControlStateNormal];
        [logout setBackgroundColor:[UIColor redColor]];
        [logout addTarget:self action:@selector(logouClick) forControlEvents:UIControlEventTouchUpInside];
        logout.layer.cornerRadius = 16.f;
        cell.contentView.backgroundColor = [[UIColor alloc] initWithRed:239 / 255.f green:239 / 255.f blue:239 / 255.f alpha:1];
        [cell.contentView addSubview:logout];
    }
    return cell;
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50.f;
    }
    return 60.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 0 ) {
        CHLog(@"清除缓存");

        NSFileManager* fileManager=[NSFileManager defaultManager];
        
        
        NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *pathStr = [NSString stringWithFormat:@"%@/test.sqlite",docs[0]];
        
        NSString *plistPathStr = [NSString stringWithFormat:@"%@/CHJRecommendModel.plist",docs[0]];
        
        BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:pathStr];
        BOOL plHave=[[NSFileManager defaultManager] fileExistsAtPath:plistPathStr];
        if ((!blHave) && (!plHave)) {
            CHLog(@"缓存为空");
            return;
        }else{
            BOOL blDele= [fileManager removeItemAtPath:pathStr error:nil];
            BOOL plDele= [fileManager removeItemAtPath:plistPathStr error:nil];
            if (blDele && plDele) {
                NSMutableArray *indexPathes = [NSMutableArray arrayWithObject:indexPath];
                //刷新
                [tableView reloadRowsAtIndexPaths:indexPathes withRowAnimation:UITableViewRowAnimationFade];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"清除缓存成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }else {
                
            }
        }
    }else if (indexPath.section == 1 && indexPath.row == 1){
        CHAboutUsController *targetVC = [[CHAboutUsController alloc] init];
        [self.navigationController pushViewController:targetVC animated:YES];
    }
}

#pragma mark -- 退出按钮
- (void)logouClick{
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    [userDefault setUserDict:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 输入框代理
//点击return键响应的函数
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    CHLog(@"%@",textField.text);
    
    CHHTTPRequestManager *manager = [CHHTTPRequestManager manager];
    
    manager.userRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/modi_userinfo.php?format=json";
    CHLocation *location = [CHLocation shareLocation];
    
    NSDictionary *parameters = @{@"lat" : @(location.lat),@"lon" : @(location.lon),@"source" : @"iphone",@"format" : @"json",@"user_name":textField.text};
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    [manager.userRequest.requestSerializer setAuthorizationHeaderFieldWithUsername:userDefault.email password:userDefault.password];
    [manager.userRequest POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = (NSDictionary *)responseObject;
        int code = [[dic objectForKey:@"code"] intValue];
        
        if (code == 1) {
            //如果成功的话，更改本地用户名吃货美食123
            NSDictionary *userDict = @{@"photo":userDefault.photo ,@"sex": userDefault.sex ,@"user_id" :userDefault.user_id ,@"user_name":textField.text , @"password":userDefault.password , @"email":userDefault.email};
            [userDefault setUserDict:userDict];
            CHLog(@"%@",dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];

    [textField resignFirstResponder];
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
