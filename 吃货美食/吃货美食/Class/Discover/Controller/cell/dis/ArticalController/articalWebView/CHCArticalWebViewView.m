//
//  CHCArticalWebViewView.m
//  吃货美食
//
//  Created by eric on 16/5/25.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCArticalWebViewView.h"

@interface CHCArticalWebViewView ()

@end

@implementation CHCArticalWebViewView

- (void)viewDidLoad {
    [super viewDidLoad];
     self.webView.scrollView.bounces = NO;
  
    NSString *basleurl=@"http://m.meishij.net/html5/news.php?id=";
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",basleurl,self.myid];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
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

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
