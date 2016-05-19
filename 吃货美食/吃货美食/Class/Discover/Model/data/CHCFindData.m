//
//  CHCFindData.m
//  吃货美食
//
//  Created by eric on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCFindData.h"

@implementation CHCFindData
//指定一个数组的元素，是那个模型类
+(NSDictionary*)mj_objectClassInArray
{
    return @{@"faxian_list":[CHCfaxian_list class]};
}
//+(NSDictionary*)mj_replacedKeyFromPropertyName
//{
//    return @{@"myid": @"id"};
//}

@end
