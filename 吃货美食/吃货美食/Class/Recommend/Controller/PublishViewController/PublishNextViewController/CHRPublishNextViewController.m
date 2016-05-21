//
//  CHRPublishNextViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublishNextViewController.h"

@interface CHRPublishNextViewController ()

@end

@implementation CHRPublishNextViewController

- (instancetype)initWithFoodDic:(NSDictionary *)foodDic withFoodName:(NSString *)foodName
{
    self = [super init];
    if (self) {
        self.foodName = foodName;
        self.foodDataDic = foodDic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑菜谱";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTittle:@"发布" withTittleColor:[UIColor redColor] withTarget:self action:@selector(publishFood) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)publishFood{
    
    [self showHUDWithText:@"抱歉,请完善数据" withTextFont:[UIFont systemFontOfSize:16.f] withTextColor:[UIColor whiteColor] withTextSize:CGSizeMake(MAXFLOAT, 0.f) withAction:@selector(testHud) withIsAnimated:YES];
    
}

@end
