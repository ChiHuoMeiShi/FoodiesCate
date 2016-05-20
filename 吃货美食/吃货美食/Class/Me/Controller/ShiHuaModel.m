//
//  ShiHuaModel.m
//  吃货美食
//
//  Created by 赵天 on 16/5/19.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "ShiHuaModel.h"
#import <MJExtension.h>
#import "SHData.h"
@implementation ShiHuaModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data":[SHData class]};
}

@end
