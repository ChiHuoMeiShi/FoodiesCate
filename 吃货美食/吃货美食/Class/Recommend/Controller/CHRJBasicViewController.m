//
//  CHRJBasicViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"

@interface CHRJBasicViewController ()

@end

@implementation CHRJBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)pushToWebViewWithID:(NSNumber *)myID withUrlString:(NSString *)urlString{
    CHRWebViewController * webVC = [[CHRWebViewController alloc]init];
    webVC.webID = myID;
    webVC.urlString = urlString;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - HUD
- (void)showHUDWithText:(NSString *)string withTextFont:(UIFont *)font withTextColor:(UIColor *)color withTextSize:(CGSize)textSize withAction:(SEL)method withIsAnimated:(BOOL)isAnimated{
    NSDictionary * attributes = [NSDictionary dicOfTextAttributeWithFont:font withTextColor:color];
    CGRect myRect = [string boundingRectWithSize:textSize options:NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    self.myHUD = [[MBProgressHUD alloc]initWithFrame:myRect];
    self.myHUD.mode= MBProgressHUDModeText;
    self.myHUD.delegate= self;
    self.myHUD.labelText= string;
    [self.view addSubview:self.myHUD];
    [self.myHUD showWhileExecuting:method onTarget:self withObject:nil animated:isAnimated];
}

- (void)hudWasHidden:(MBProgressHUD *)hud{
    [self.myHUD removeFromSuperview];
    self.myHUD = nil;
}

- (void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchButtonAction{
    CHRJSearchViewController * searchVC = [[CHRJSearchViewController alloc]init];
    [self.searchView removeFromSuperview];
    self.searchView = nil;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)recommdSearchBarSetWithRect:(CGRect)rect{
    self.searchView = [[[NSBundle mainBundle]loadNibNamed:@"CHRJSearchView" owner:nil options:nil]lastObject];
    self.searchView.frame = rect;
    [self.searchView.searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.searchView];
}

@end
