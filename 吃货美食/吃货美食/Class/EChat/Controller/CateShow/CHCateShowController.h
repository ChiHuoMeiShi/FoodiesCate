//
//  CHCateShowController.h
//  吃货美食
//
//  Created by 赵天 on 16/5/15.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CateShowModel.h"
#import "Topic_List.h"
#import "EChatModel.h"
#import "Hot_topocModel.h"
@interface CHCateShowController : UIViewController

@property (nonatomic,assign) int page;

@property(strong,nonatomic)EChatModel *echatModel;

@end
