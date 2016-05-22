//
//  CHCFaXianDetailViewController.h
//  吃货美食
//
//  Created by eric on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHCFaXianDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,copy)NSString *gid;
@property(nonatomic,strong)NSString *tid;

- (IBAction)Back:(id)sender;



@end
