//
//  CHRPublishFoodStepModel.m
//  吃货美食
//
//  Created by scjy on 16/5/24.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublishFoodStepModel.h"

@implementation CHRPublishFoodStepModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"";
        self.photoPath = @"";
        self.stepDetail = @"";
    }
    return self;
}


@end
