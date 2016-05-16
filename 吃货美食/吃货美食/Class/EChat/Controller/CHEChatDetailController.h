//
//  CHEChatDetailController.h
//  吃货美食
//
//  Created by 赵天 on 16/5/14.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHEChatDetailController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic,copy) NSString * tid;

@property (nonatomic,copy) NSString * gid;

@end
