//
//  CHRJBasicViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHRWebViewController.h"
#import <MBProgressHUD.h>
@interface CHRJBasicViewController : UIViewController<MBProgressHUDDelegate>
@property (nonatomic,strong)MBProgressHUD * myHUD;

- (void)navBackAction;
- (void)pushToWebViewWithID:(NSNumber *)myID withUrlString:(NSString *)urlString;

- (void)showHUDWithText:(NSString *)string withTextFont:(UIFont *)font withTextColor:(UIColor *)color withTextSize:(CGSize)textSize withAction:(SEL)method withIsAnimated:(BOOL)isAnimated;

@end
