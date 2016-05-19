//
//  CHCRecipe_info_list.m
//  吃货美食
//
//  Created by eric on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCRecipe_info_list.h"
#import <MJExtension.h>
@implementation CHCRecipe_info_list
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"myid": @"id"};
}
@end
