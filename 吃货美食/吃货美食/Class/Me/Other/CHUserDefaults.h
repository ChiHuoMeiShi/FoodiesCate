//
//  CHUserDefaults.h
//  吃货美食
//
//  Created by 赵天 on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHRPublishSave.h"

@interface CHUserDefaults : NSObject



@property (nonatomic,copy) NSString * photo;

@property (nonatomic,copy) NSString * sex;

@property (nonatomic,copy) NSString * user_id;

@property (nonatomic,copy) NSString * user_name;

@property (nonatomic,copy) NSString * password;

@property (nonatomic,copy) NSString * email;

@property (nonatomic,strong)NSMutableArray * foodSaveArray;

+ (instancetype)shareUserDefault;

- (void)setUserDict:(NSDictionary *)userDict;

@end
