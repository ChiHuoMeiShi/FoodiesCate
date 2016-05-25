//
//  CHRPublishFoodDetailModel.m
//  吃货美食
//
//  Created by scjy on 16/5/24.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublishFoodDetailModel.h"

@implementation CHRPublishFoodDetailModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mainFoodArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.supFoodArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.stepFoodArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}


@end
