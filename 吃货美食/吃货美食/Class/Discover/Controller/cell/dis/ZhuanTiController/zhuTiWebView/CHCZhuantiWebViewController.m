//
//  CHCZhuantiWebViewController.m
//  吃货美食
//
//  Created by eric on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCZhuantiWebViewController.h"

@interface CHCZhuantiWebViewController ()

@end

@implementation CHCZhuantiWebViewController
- (void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];

    NSURL *url = [NSURL URLWithString:self.f_s_type];
    
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
        [self.zhuTiWebView loadRequest:request];

    
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
