//
//  CHCWenZhanViewController.m
//  吃货美食
//
//  Created by eric on 16/5/22.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCWenZhanViewController.h"

@interface CHCWenZhanViewController ()

@end

@implementation CHCWenZhanViewController
- (void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];

    NSString *baseUrl = @"http://m.meishij.net/html5/news.php?id=";
    //    http://m.meishij.net/html5/news.php?id=202158
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",baseUrl,self.wenId];
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

- (IBAction)back:(id)sender {
}
@end
