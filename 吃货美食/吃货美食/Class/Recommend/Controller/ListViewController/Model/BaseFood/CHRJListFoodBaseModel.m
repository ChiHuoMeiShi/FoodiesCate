//
//  CHRJListFoodBaseModel.m
//  吃货美食
//
//  Created by scjy on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJListFoodBaseModel.h"

@implementation CHRJListFoodBaseModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"myID":@"id"};
}

@end
