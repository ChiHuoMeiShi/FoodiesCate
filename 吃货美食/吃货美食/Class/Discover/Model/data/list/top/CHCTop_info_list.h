//
//  CHCTop_info_list.h
//  吃货美食
//
//  Created by eric on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHCUse_info_list.h"
#import "CHCimages_list.h"
@interface CHCTop_info_list : NSObject
@property(nonatomic,strong)CHCUse_info_list *user_info;
@property(nonatomic,strong)NSMutableArray *imgs;
@property(nonatomic,strong)NSString *gid;
@property(nonatomic,strong)NSString *tid;
@property(nonatomic,strong)NSString *comment_num;
@property(nonatomic,strong)NSString *is_ding;
@property(nonatomic,strong)NSString *ding_num;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *summary;
@property(nonatomic,strong)NSString *img_num;
@property(nonatomic,strong)NSString *zhiding;
@property(nonatomic,strong)NSArray *recipes;
@property(nonatomic,strong)NSString *sourceType;
@end
