//
//  CHCfaxian_list.h
//  吃货美食
//
//  Created by eric on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

#import "CHCShicai_list.h"
#import "CHCgongyi_info_list.h"
#import "CHCHuoDong_list.h"
#import "CHArticle_info_list.h"
#import "CHCTop_info_list.h"
#import "CHCRecipe_info_list.h"
#import "CHCZt_info_list.h"
#import "CHCCaidan_list.h"
#import "CHCgoods_info_list.h"
@interface CHCfaxian_list : NSObject
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,copy)NSString*tag;
@property(nonatomic,strong)CHCRecipe_info_list *recipe_info;
@property(nonatomic,strong)CHCShicai_list *shicai_info;
@property(nonatomic,strong)CHCHuoDong_list *huodong;
//缺一组
@property(nonatomic,strong)CHArticle_info_list *article_info;
@property(nonatomic,strong)CHCgongyi_info_list *gongyi_info;
@property(nonatomic,strong)CHCCaidan_list *caidan_info;
@property(nonatomic,strong)CHCZt_info_list *zt_info;
@property(nonatomic,strong)CHCTop_info_list *topic_info;
@property(nonatomic,strong)CHCgoods_info_list *goods_info;





@end
