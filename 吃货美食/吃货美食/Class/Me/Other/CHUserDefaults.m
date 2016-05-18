//
//  CHUserDefaults.m
//  吃货美食
//
//  Created by 赵天 on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHUserDefaults.h"
#define kUserDict @"userDict"
static CHUserDefaults *userDefault = nil;
@implementation CHUserDefaults

+ (instancetype)shareUserDefault
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        userDefault = [[CHUserDefaults alloc] init];
        [userDefault loadUserInfo];
    });
    return userDefault;
}
- (void)loadUserInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //取到本地的userDict
    NSDictionary *userDict = [defaults objectForKey:kUserDict];
    if (userDict)
    {
        self.user_id    = [userDict objectForKey:@"user_id"];
        self.user_name  = [userDict objectForKey:@"user_name"];
        self.sex        = [userDict objectForKey:@"sex"];
        self.photo      = [userDict objectForKey:@"photo"];
        self.password   = [userDict objectForKey:@"password"];
        self.email      = [userDict objectForKey:@"email"];
    }
}
- (void)setUserDict:(NSDictionary *)userDict
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //把传进来的userDict保留到本地
    [defaults setObject:userDict forKey:kUserDict];
    self.user_id    = [userDict objectForKey:@"user_id"];
    self.user_name  = [userDict objectForKey:@"user_name"];
    self.sex        = [userDict objectForKey:@"sex"];
    self.photo      = [userDict objectForKey:@"photo"];
    self.password   = [userDict objectForKey:@"password"];
    self.email      = [userDict objectForKey:@"email"];
}

@end
