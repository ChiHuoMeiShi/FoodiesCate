//
//  CHCShicai_list.m
//  吃货美食
//
//  Created by eric on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCShicai_list.h"
#import <MJExtension.h>
#import "CHCGongxiao_list.h"
@implementation CHCShicai_list
///将属性名myCount，替换成count，然后解析数据
//当属性名为一个非法的属性的时候使用
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"myid": @"id"};
}

@end
