//
//  CHzt_infoWebViewController.m
//  吃货美食
//
//  Created by eric on 16/5/22.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHzt_infoWebViewController.h"

@interface CHzt_infoWebViewController ()

@end

@implementation CHzt_infoWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *baseUrl = @"http://www.meishij.net/topic-";
    //    http://m.meishij.net/html5/news.php?id=1615023
    NSString *urlStr = [NSString stringWithFormat:@"%@%@.html",baseUrl,self.ztId];
    //
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [self.webView loadRequest:request];

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

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
