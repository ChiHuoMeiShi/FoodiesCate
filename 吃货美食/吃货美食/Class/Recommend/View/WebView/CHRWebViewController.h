//
//  CHRWebViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHJRecommendJumpModel.h"

@interface CHRWebViewController : UIViewController
@property (nonatomic,strong)NSNumber * webID;
@property (nonatomic,copy)NSString * urlString;
@property (nonatomic,strong)CHJRecommendJumpModel * jumpModel;
@property (weak, nonatomic) IBOutlet UIWebView *webDetailView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end
