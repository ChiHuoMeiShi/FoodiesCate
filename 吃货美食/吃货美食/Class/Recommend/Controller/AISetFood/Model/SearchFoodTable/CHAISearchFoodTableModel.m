//
//  CHAISearchFoodTableModel.m
//  吃货美食
//
//  Created by scjy on 16/5/19.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHAISearchFoodTableModel.h"

@implementation CHAISearchFoodTableModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"myID":@"id",@"myImg":@"img"};
}

MJExtensionCodingImplementation;




@end
