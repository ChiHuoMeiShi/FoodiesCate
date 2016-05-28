//
//  CHRWebViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHJRecommendJumpModel.h"
#import "CHRJSearchView.h"
#import <MBProgressHUD.h>
#import "CHLoginController.h"
#import "CHUserDefaults.h"
@interface CHRWebViewController : UIViewController<MBProgressHUDDelegate>
@property (nonatomic,strong)NSNumber * webID;
@property (nonatomic,copy)NSString * urlString;
@property (nonatomic,strong)CHJRecommendJumpModel * jumpModel;
@property (weak, nonatomic) IBOutlet UIWebView *webDetailView;
@property (nonatomic,strong)CHRJSearchView * searchView;
@property (nonatomic,strong)MBProgressHUD * myHUD;
@property (nonatomic,strong)CHUserDefaults * userDefault;


- (instancetype)initWithURLString:(NSString *)urlString;

@end
