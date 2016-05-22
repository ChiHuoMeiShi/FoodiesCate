//
//  CHCCaiDanWebViewController.h
//  吃货美食
//
//  Created by eric on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHCCaiDanWebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *WebView;
@property(nonatomic,copy)NSString *rid;


- (IBAction)BackClick:(id)sender;

@end
