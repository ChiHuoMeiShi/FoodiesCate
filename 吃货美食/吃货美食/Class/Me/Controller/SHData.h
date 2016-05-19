//
//  SHData.h
//  吃货美食
//
//  Created by 赵天 on 16/5/19.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHData : NSObject

@property (nonatomic,copy) NSString * gid;

@property (nonatomic,copy) NSString * create_time;

@property (nonatomic,copy) NSString * comment_num;

@property (nonatomic,copy) NSString * ding_num;

@property (nonatomic,copy) NSString * tid;

@property (nonatomic,copy) NSString * summary;

@property (nonatomic,copy) NSString * img_num;

@property (nonatomic,strong) NSMutableArray * imgs;

@end
