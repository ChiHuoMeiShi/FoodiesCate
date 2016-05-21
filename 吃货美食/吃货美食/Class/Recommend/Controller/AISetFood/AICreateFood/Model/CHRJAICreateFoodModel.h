//
//  CHRJAICreateFoodModel.h
//  吃货美食
//
//  Created by scjy on 16/5/20.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHRJAICreateFoodNewsesModel.h"
#import <MJExtension.h>
@interface CHRJAICreateFoodModel : NSObject

@property (nonatomic,strong)NSString * title;
@property (nonatomic,strong)NSString * gongxiao;
@property (nonatomic,copy)NSNumber * total;
@property (nonatomic,strong)NSMutableArray * newses;
@property (nonatomic,copy)NSNumber * sids;

@end
