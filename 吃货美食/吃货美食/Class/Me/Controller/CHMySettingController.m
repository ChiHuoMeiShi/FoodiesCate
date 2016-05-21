//
//  CHMySettingController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHMySettingController.h"
#import "CHLoginController.h"
@interface CHMySettingController ()

@end

@implementation CHMySettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)navBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)loginTest:(id)sender {
    CHLoginController *targetVC =[[CHLoginController alloc] init];
    [self.navigationController pushViewController:targetVC animated:YES];
}
@end
