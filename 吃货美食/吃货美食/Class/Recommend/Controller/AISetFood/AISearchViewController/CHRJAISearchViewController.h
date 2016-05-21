//
//  CHRJAISearchViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIImageView+WebCache.h>
#import "CHRJBasicViewController.h"
#import "CHAISearchFoodTableModel.h"
#import "CHAISearchShowTableViewCell.h"
#import "CHRAIGetBaseFoodProtocol.h"

@interface CHRJAISearchViewController : UIViewController
@property (nonatomic,strong)NSMutableArray * dataArray;

@property (weak, nonatomic) IBOutlet UITextField *foodTextField;
@property (weak, nonatomic) IBOutlet UITableView *baseFoodTableView;
@property (nonatomic,strong)CHHTTPRequestManager * afnManger;

@property (nonatomic,weak)id<CHRAIGetBaseFoodProtocol> delegate;

- (IBAction)canelButtonAction:(UIButton *)sender;

@end
