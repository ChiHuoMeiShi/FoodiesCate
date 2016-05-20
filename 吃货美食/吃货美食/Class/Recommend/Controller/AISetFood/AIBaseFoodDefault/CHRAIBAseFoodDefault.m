//
//  CHRAIBAseFoodDefault.m
//  吃货美食
//
//  Created by scjy on 16/5/19.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRAIBAseFoodDefault.h"

@implementation CHRAIBAseFoodDefault

+ (instancetype)shareSelectedBaseFood{
    
    return [[self alloc]init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static CHRAIBAseFoodDefault * baseFood = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseFood = [super allocWithZone:zone];
        baseFood.baseFoodArray = [[NSMutableArray alloc]initWithCapacity:0];
        
    });
    
    return baseFood;
}

@end
