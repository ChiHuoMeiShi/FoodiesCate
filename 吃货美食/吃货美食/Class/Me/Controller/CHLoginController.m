//
//  CHLoginController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHLoginController.h"
#import "CHUserDefaults.h"
#import "CHRegisterController.h"

@interface CHLoginController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;



@end

@implementation CHLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)navBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginBtnClick:(id)sender {
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/login.php?format=json";
    NSDictionary *parameters = @{@"lat" : @"34.6049907522264",@"lon" : @"112.4229875834745",@"source" : @"iphone",@"format" : @"json"};
    
    [manger.requestSerializer setAuthorizationHeaderFieldWithUsername:@"13007551820" password:@"zt123456"];
    __weak typeof(self) mySelf = self;
    [manger POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = (NSDictionary *)responseObject;
        int code = [[dic objectForKey:@"code"] intValue];

        if ([mySelf.accountTextField.text isEqualToString:@""]) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"账号不能为空" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        if ([mySelf.passwdTextField.text isEqualToString:@""]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        if (code == 1) {
            CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
            [userDefault setUserDict:dic];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"请输入正确的账号密码" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];

    
//    [manger.userRequest POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSDictionary * dic = (NSDictionary *)responseObject;
//        int code = [[dic objectForKey:@"code"] intValue];
//        
//        
//        
//        if ([mySelf.accountTextField.text isEqualToString:@""]) {
//            
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"账号不能为空" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//            [alertController addAction:okAction];
//            [self presentViewController:alertController animated:YES completion:nil];
//        }
//        if ([mySelf.passwdTextField.text isEqualToString:@""]) {
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//            [alertController addAction:okAction];
//            [self presentViewController:alertController animated:YES completion:nil];
//        }
//        if (code == 1) {
//            CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
//            [userDefault setUserDict:dic];
//        }else{
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"请输入正确的账号密码" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//            [alertController addAction:okAction];
//            [self presentViewController:alertController animated:YES completion:nil];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    }];

}

- (IBAction)registBtnClick:(id)sender {
    CHRegisterController *targetVC = [[CHRegisterController alloc] init];
    [self.navigationController pushViewController:targetVC animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.accountTextField resignFirstResponder];
    [self.passwdTextField resignFirstResponder];
}
@end
