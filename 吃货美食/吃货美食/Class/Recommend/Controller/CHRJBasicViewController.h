//
//  CHRJBasicViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHRWebViewController.h"
@interface CHRJBasicViewController : UIViewController

- (void)navBackAction;
- (void)pushToWebViewWithID:(NSNumber *)myID withUrlString:(NSString *)urlString;
@end
