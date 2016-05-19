//
//  CHCrecipes_list.m
//  吃货美食
//
//  Created by eric on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCrecipes_list.h"
#import <MJExtension.h>
@implementation CHCrecipes_list
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"myid": @"id"};
}
@end
