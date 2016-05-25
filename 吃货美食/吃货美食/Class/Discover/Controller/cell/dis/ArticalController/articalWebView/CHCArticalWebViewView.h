//
//  CHCArticalWebViewView.h
//  吃货美食
//
//  Created by eric on 16/5/25.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHCArticalWebViewView : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,copy)NSString *myid;
- (IBAction)back:(id)sender;
@end
