//
//  CHCData_list.h
//  吃货美食
//
//  Created by eric on 16/5/15.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHCuser_info_caidanlist.h"
@interface CHCData_list : NSObject
@property(nonatomic,strong)NSString *myid;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)CHCuser_info_caidanlist *user_info;
@property(nonatomic,strong)NSArray *photos;
@property(nonatomic,strong)NSString *descr;
@property(nonatomic,strong)NSString *recipe_num;

@end
