//
//  CHRegisterController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/20.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRegisterController.h"
//#import "RegexKitLite.h"
@interface CHRegisterController ()

@end

@implementation CHRegisterController

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
}
- (IBAction)registBtnClick:(id)sender {
    CHHTTPRequestManager * manger = [CHHTTPRequestManager manager];
    manger.userRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://m.meishij.net/register.php";
    NSDictionary *parameters = @{@"ac" : self.accountTextField.text,@"pw" : self.passwdTextField.text,@"rt" : @"1"};
    __weak typeof(self) mySelf = self;
    [manger.userRequest POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = (NSDictionary *)responseObject;
        int code = [[dic objectForKey:@"code"] intValue];
        
        if (code == 1) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功请登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        if (code == -2) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"此账号已被注册请登录" preferredStyle:UIAlertControllerStyleAlert];
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
        if ([mySelf.accountTextField.text isEqualToString:@""]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"邮箱不能为空" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        
        NSString *emailAddres = mySelf.accountTextField.text;
        NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex]; 
        BOOL isValid = [predicate evaluateWithObject:emailAddres];
        if (!isValid) {
            CHLog(@"不是邮箱");
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"这不是一个邮箱请重新输入" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        /*
         注册成功
         {
         code = 1;
         msg = "\U6ce8\U518c\U6210\U529f";
         obj =     {
         birthday = "";
         clicks = 0;
         "cook_num" = 0;
         email = "87037710@qq.com";
         "follower_num" = 0;
         "following_num" = 0;
         hometown = "";
         "hometown_p" = "";
         location = "";
         "location_p" = "";
         password = 491ee57d72f0aec0a92a83fde2045c48;
         photo = "";
         profession = "";
         sex = "";
         tizhis = "";
         "user_id" = 6252292;
         "user_name" = "\U6770\U7c736822595341";
         };
         }
         */
        
        /*
         邮箱已被注册
         code = "-2";
         msg = "\U90ae\U7bb1\U5730\U5740\U5df2\U6ce8\U518c\Uff0c\U8bf7\U76f4\U63a5\U767b\U5f55";
         */
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.accountTextField resignFirstResponder];
    [self.passwdTextField resignFirstResponder];
}
@end
