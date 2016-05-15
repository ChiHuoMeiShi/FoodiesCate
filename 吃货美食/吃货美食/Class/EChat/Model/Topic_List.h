//
//  Topic_List.h
//  吃货美食
//
//  Created by 赵天 on 16/5/15.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User_infoModel.h"
#import "ImgsModel.h"
#import "CateUserInfo.h"
#import "CateImgsModel.h"
@interface Topic_List : NSObject
/**
 *  用户信息字典
 */
@property (nonatomic,strong) CateUserInfo * user_info;

@property (nonatomic,copy) NSString * gid;

@property (nonatomic,copy) NSString * tid;

@property (nonatomic,strong) NSNumber * img_num;

@property (nonatomic,copy) NSString * summary;
//图片数组
@property (nonatomic,strong) NSMutableArray * imgs;

@property (nonatomic,copy) NSString * time;

@property (nonatomic,copy) NSString * comment_num;

@property (nonatomic,copy) NSString * is_ding;

@property (nonatomic,copy) NSString * ding_num;

@property (nonatomic,copy) NSString * zhiding;


@end
