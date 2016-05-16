//
//  CHEChatDetailController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/14.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHEChatDetailController.h"

@interface CHEChatDetailController ()

@end

@implementation CHEChatDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //20&tid=
    NSString *baseUrl = @"http://m.meishij.net/html5/shihua_content.php?gid=";
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@&tid=%@",baseUrl,self.gid,self.tid];
    
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

@end
