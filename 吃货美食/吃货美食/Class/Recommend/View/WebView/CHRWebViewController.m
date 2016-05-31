//
//  CHRWebViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRWebViewController.h"

@interface CHRWebViewController ()

@end

@implementation CHRWebViewController


- (instancetype)initWithURLString:(NSString *)urlString{
    self = [super init];
    if (self) {
        self.urlString = urlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:@"refresh" withSelectImage:@"refresh" withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTarget:self action:@selector(webReload) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
    self.title = @"菜品详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (!self.urlString) {
        self.urlString = [NSString stringWithFormat:@"http://m.meishij.net/html5/news.php?id=%@",self.webID];
    }else{
        self.urlString = [self.urlString stringDeleteToURL:self.urlString];
    }
    NSURL * requestURL = [NSURL URLWithString:[self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:requestURL];
    [self.webDetailView loadRequest:request];
    self.webDetailView.scrollView.bounces = NO;
    
    
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    if(navigationType==UIWebViewNavigationTypeLinkClicked)
    {
        return NO;
    }
    else{return YES;}
}
- (void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
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
- (void)webReload{
    [self.webDetailView reload];
}

- (void)hudWasHidden:(MBProgressHUD *)hud{
    [self.myHUD removeFromSuperview];
    self.myHUD = nil;
}
- (void)recommdSearchBarSetWithRect:(CGRect)rect{
    self.searchView = [[[NSBundle mainBundle]loadNibNamed:@"CHRJSearchView" owner:nil options:nil]lastObject];
    self.searchView.frame = rect;
    [self.searchView.searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.searchView];
}
- (void)searchButtonAction{
    return;
}

@end
