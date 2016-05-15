//
//  CHRWebViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRWebViewController.h"

@interface CHRWebViewController ()

@end

@implementation CHRWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    if (!self.urlString) {
        self.urlString = [NSString stringWithFormat:@"http://m.meishij.net/html5/news.php?id=%@",self.webID];
    }else{
        self.urlString = [self.urlString stringDeleteToURL:self.urlString];
        [self.backButton setImage:[UIImage imageNamed:@"ms_back_icon2"] forState:UIControlStateNormal];
        [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
    }
    NSURL * requestURL = [NSURL URLWithString:[self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:requestURL];
    [self.webDetailView loadRequest:request];
    
    
    [self.backButton addTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
    
}


- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    if(navigationType==UIWebViewNavigationTypeLinkClicked)
    {
        return NO;
    }
    else{return YES;}
}
- (void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
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
