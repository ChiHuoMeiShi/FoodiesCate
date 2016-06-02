//
//  CHLocation.m
//  吃货美食
//
//  Created by scjy on 16/5/25.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHLocation.h"

@implementation CHLocation

+ (instancetype)shareLocation{
    
    return [[self alloc]init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static CHLocation * location = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [super allocWithZone:zone];
        location.lat = 34.f;
        location.lon = 112.f;
        location.coordinate = (CLLocationCoordinate2D){34.f,112.f};
    });
    return location;
}

@end
