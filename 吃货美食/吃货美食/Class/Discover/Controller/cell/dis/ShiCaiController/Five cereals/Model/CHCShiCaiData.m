//
//  CHCShiCaiData.m
//  吃货美食
//
//  Created by eric on 16/5/14.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCShiCaiData.h"
#import <MJExtension.h>
@implementation CHCShiCaiData
//+(NSDictionary*)mj_replacedKeyFromPropertyName
//{
//    return @{@"obj_list": @"obj"};
//}
//
//指定一个数组的元素，是那个模型类
+(NSDictionary*)mj_objectClassInArray
{
    return @{@"obj":[CHCSHiCaiObjData class]};
}

@end
