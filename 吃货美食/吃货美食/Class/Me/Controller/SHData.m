//
//  SHData.m
//  吃货美食
//
//  Created by 赵天 on 16/5/19.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "SHData.h"
#import "SHImgs.h"
#import <MJExtension.h>
@implementation SHData

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"imgs":[SHImgs class]};
}

@end
