//
//  CHCCaiDanWebViewController.m
//  吃货美食
//
//  Created by eric on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCCaiDanWebViewController.h"

@interface CHCCaiDanWebViewController ()
@end

@implementation CHCCaiDanWebViewController
//- (void)navBackAction{
//    [self.navigationController popViewControllerAnimated:YES];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];

    self.WebView.scrollView.bounces = NO;
    
    NSString *baseUrl = @"http://m.meishij.net/html5/recipe_list.php?rid=";
//    http://m.meishij.net/html5/recipe_list.php?rid=8976085&from=msjmobile
    NSString *urlStr = [NSString stringWithFormat:@"%@%@&from=msjmobile",baseUrl,self.rid];
//
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [self.WebView loadRequest:request];

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

- (IBAction)BackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
