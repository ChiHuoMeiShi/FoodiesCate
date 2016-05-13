//
//  EChatModel.m
//  吃货美食
//
//  Created by 赵天 on 16/5/12.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "EChatModel.h"
#import "Hot_topocModel.h"

@implementation EChatModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"hot_topic":[Hot_topocModel class]};
}

@end
