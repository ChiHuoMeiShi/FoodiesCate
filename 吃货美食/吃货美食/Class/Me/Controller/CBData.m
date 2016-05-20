//
//  CBData.m
//  吃货美食
//
//  Created by 赵天 on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CBData.h"
#import <MJExtension.h>
@implementation CBData
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"myID":@"id"};
}
@end
