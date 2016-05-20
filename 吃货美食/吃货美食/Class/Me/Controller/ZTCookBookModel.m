//
//  ZTCookBookModel.m
//  吃货美食
//
//  Created by 赵天 on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "ZTCookBookModel.h"
#import <MJExtension.h>
#import "CBData.h"
@implementation ZTCookBookModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data":[CBData class]};
}

@end
