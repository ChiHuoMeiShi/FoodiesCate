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
@property (strong, nonatomic) UIAlertController *alertController;



@end

@implementation CHLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginBtnClick:(id)sender {
    CHHTTPRequestManager * manger = [CHHTTPRequestManager manager];
    manger.userRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/login.php?format=json";
    NSDictionary *parameters = @{@"lat" : @"34.6049907522264",@"lon" : @"112.4229875834745",@"source" : @"iphone",@"format" : @"json"};
    __weak typeof(self) mySelf = self;
    [manger.userRequest.requestSerializer setAuthorizationHeaderFieldWithUsername:self.accountTextField.text password:self.passwdTextField.text];
    
    [manger.userRequest POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = (NSDictionary *)responseObject;
        int code = [[dic objectForKey:@"code"] intValue];
        
        
        
        if ([mySelf.accountTextField.text isEqualToString:@""]) {
            
            mySelf.alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"账号不能为空" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [mySelf.alertController addAction:okAction];
        }
        if ([mySelf.passwdTextField.text isEqualToString:@""]) {
            mySelf.alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [mySelf.alertController addAction:okAction];
        }
        if (code == 1) {
            CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
            [userDefault setUserDict:dic];
        }else{
            mySelf.alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"请输入正确的账号密码" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [mySelf.alertController addAction:okAction];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];

}

- (IBAction)registBtnClick:(id)sender {
    CHRegisterController *targetVC = [[CHRegisterController alloc] init];
    [self.navigationController pushViewController:targetVC animated:YES];
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
