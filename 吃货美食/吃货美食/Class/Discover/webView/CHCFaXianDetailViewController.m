//
//  CHCFaXianDetailViewController.m
//  吃货美食
//
//  Created by eric on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCFaXianDetailViewController.h"

@implementation CHCFaXianDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
     self.webView.scrollView.bounces = NO;
    NSString *baseUrl = @"http://m.meishij.net/html5/shihua_content.php?";
//    http://m.meishij.net/html5/shihua_content.php?gid=20&tid=1069604

    NSString *urlStr = [NSString stringWithFormat:@"%@gid=%@&tid=%@",baseUrl,self.gid,self.tid];
    //
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [self.webView loadRequest:request];

}
//-(void)pp
//{
//    NSURL *url = [NSURL URLWithString:self.loadurl];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    [self.webView loadRequest:request];
//}

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
