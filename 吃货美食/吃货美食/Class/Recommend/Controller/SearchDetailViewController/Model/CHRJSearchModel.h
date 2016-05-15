//
//  CHRJSearchModel.h
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHRJSearchContentModel.h"
#import <MJExtension.h>
@interface CHRJSearchModel : NSObject
@property (nonatomic,copy)NSString * city_hot;
@property (nonatomic,strong)NSMutableArray * data;
@property (nonatomic,strong)NSNumber * search_num;
@property (nonatomic,strong)NSNumber * column_rank;
@property (nonatomic,strong)NSNumber * is_filter;
@property (nonatomic,strong)NSNumber * total;
@property (nonatomic,strong)NSNumber * solr_num;

@end
