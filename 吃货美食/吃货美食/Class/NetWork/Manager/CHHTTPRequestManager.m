//
//  CHHTTPRequestManager.m
//  吃货美食
//
//  Created by 赵天 on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHHTTPRequestManager.h"

@implementation CHHTTPRequestManager
+ (id)manager
{
    return [[self alloc] init];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.messageRequest = [[CHMessageRequest alloc] init];
        self.userRequest = [[CHUserRequest alloc] init];
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static CHHTTPRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
        
    });
    return manager;
}

@end
