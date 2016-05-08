//
//  CHTabBarController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHTabBarController.h"
#import "CHRecommendViewController.h"
#import "CHDiscoverViewController.h"
#import "CHEChatViewController.h"
#import "CHMeViewController.h"
#import "CHNavigationController.h"

@implementation CHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CHRecommendViewController *recommend = [[CHRecommendViewController alloc] init];
    [self addSubVc:recommend title:@"推荐" imageName:nil selectImageName:nil];
    
    CHDiscoverViewController *discover = [[CHDiscoverViewController alloc] init];
    [self addSubVc:discover title:@"发现" imageName:nil selectImageName:nil];
    CHEChatViewController *eChat = [[CHEChatViewController alloc] init];
    [self addSubVc:eChat title:@"食话" imageName:nil selectImageName:nil];
    
    CHMeViewController *me = [[CHMeViewController alloc] init];
    [self addSubVc:me title:@"我" imageName:nil selectImageName:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addSubVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName
{
    childVc.tabBarItem.title = title;
    childVc.navigationItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    CHNavigationController *nav = [[CHNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}


@end
