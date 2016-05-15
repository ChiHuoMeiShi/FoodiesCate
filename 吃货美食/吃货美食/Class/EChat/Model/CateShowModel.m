//
//  CateShowModel.m
//  吃货美食
//
//  Created by 赵天 on 16/5/15.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CateShowModel.h"
#import "Topic_List.h"
#import "User_infoModel.h"
#import "Recipe_infoModel.h"
#import "ImgsModel.h"
@implementation CateShowModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"topic_List":[Topic_List class]};
}

@end
