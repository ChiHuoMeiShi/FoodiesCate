//
//  CHMeViewController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHMeViewController.h"
#import "CHHTTPRequestManager.h"
#import "CHUserDefaults.h"
@interface CHMeViewController ()

@end

@implementation CHMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    CHLog(@"%@",userDefault.user_name);
    CHLog(@"%@",userDefault.user_id);
    CHLog(@"%@",userDefault.photo);
    CHLog(@"%@",userDefault.sex);
    
    // Do any additional setup after loading the view from its nib.
}
- (void)login{
    /*
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/login.php?format=json";
    NSDictionary *parameters = @{@"lat" : @"34.6049907522264",@"lon" : @"112.4229875834745",@"source" : @"iphone",@"format" : @"json"};
    [manger.requestSerializer setAuthorizationHeaderFieldWithUsername:@"13007551820" password:@"zt123456"];
    
    [manger POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic = (NSDictionary *)responseObject;
        //            CHUserDefaults
        
        int code = [[dic objectForKey:@"code"] intValue];
        if (code == 1) {
            CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
            [userDefault setUserDict:dic];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    */
    //----------------------
    CHHTTPRequestManager *myManager = [CHHTTPRequestManager manager];
    myManager.userRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [myManager.userRequest.requestSerializer setAuthorizationHeaderFieldWithUsername:@"13007551820" password:@"zt123456"];
    NSString *url = @"http://api.meishi.cc/v5/login.php?format=json";
    NSDictionary *parameter = @{@"lat" : @"34.6049907522264",@"lon" : @"112.4229875834745",@"source" : @"iphone",@"format" : @"json"};
    [myManager.userRequest POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        //            CHUserDefaults
        
        int code = [[dic objectForKey:@"code"] intValue];
        if (code == 1) {
            CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
            [userDefault setUserDict:dic];
        }else{
            CHLog(@"用户名或者密码错误");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self login];
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
