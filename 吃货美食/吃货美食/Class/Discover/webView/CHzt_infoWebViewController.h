//
//  CHzt_infoWebViewController.h
//  吃货美食
//
//  Created by eric on 16/5/22.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHzt_infoWebViewController : UIViewController
- (IBAction)Back:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,strong)NSString *ztId;
@end
