//
//  CHCZhuanTiData_list.h
//  吃货美食
//
//  Created by eric on 16/5/15.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHCZhunTiuser_info_list.h"
@interface CHCZhuanTiData_list : NSObject
@property(nonatomic,strong)NSString *myid;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *tj_type;
@property(nonatomic,strong)NSString *f_s_type;
@property(nonatomic,strong)NSString *photo;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,strong)NSString *descr;
@property(nonatomic,strong)CHCZhunTiuser_info_list *user_info;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *zan_num;
@property(nonatomic,strong)NSString *fav_num;

@end
