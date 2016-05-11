//
//  CHNavigationController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHNavigationController.h"

@implementation CHNavigationController
- (void)viewDidLoad{
    [super viewDidLoad];
    UINavigationBar * navBar = [[UINavigationBar alloc]init];
    navBar.backgroundColor = [UIColor whiteColor];
    navBar.barTintColor = [UIColor whiteColor];
    [self setValue:navBar forKey:@"navigationBar"];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



@end
