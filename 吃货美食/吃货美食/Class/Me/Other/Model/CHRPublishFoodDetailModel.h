//
//  CHRPublishFoodDetailModel.h
//  吃货美食
//
//  Created by scjy on 16/5/24.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHRPublishFoodStepModel.h"
#import "CHRPublishFoodMainFoodModel.h"
@interface CHRPublishFoodDetailModel : NSObject

@property (nonatomic,copy)NSString * storyIMGPath;
@property (nonatomic,copy)NSString * storyStr;

@property (nonatomic,strong)NSMutableArray * mainFoodArray;
@property (nonatomic,strong)NSMutableArray * supFoodArray;
@property (nonatomic,strong)NSMutableArray * stepFoodArray;

@property (nonatomic,copy)NSString * finishIMGPath;
@property (nonatomic,copy)NSString * finishStr;

@end
