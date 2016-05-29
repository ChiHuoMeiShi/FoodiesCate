//
//  CHAISearchFoodTableModel.h
//  吃货美食
//
//  Created by scjy on 16/5/19.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHDBModel.h"
#import <MJExtension.h>
@interface CHAISearchFoodTableModel : CHDBModel<NSCoding>

@property (nonatomic,strong)NSNumber * myID;
@property (nonatomic,copy)NSString * t;
@property (nonatomic,copy)NSString * ft;
@property (nonatomic,copy)NSString * myImg;

@end
