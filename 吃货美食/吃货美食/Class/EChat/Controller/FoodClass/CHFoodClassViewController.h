//
//  CHFoodClassViewController.h
//  吃货美食
//
//  Created by 赵天 on 16/5/15.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EChatModel.h"
#import "Hot_topocModel.h"
@interface CHFoodClassViewController : UIViewController
@property (nonatomic,assign) int page;

@property(strong,nonatomic)EChatModel *echatModel;
@end
