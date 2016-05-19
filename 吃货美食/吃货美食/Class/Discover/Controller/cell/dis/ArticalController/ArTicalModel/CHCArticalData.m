//
//  CHCArticalData.m
//  吃货美食
//
//  Created by eric on 16/5/15.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCArticalData.h"

@implementation CHCArticalData
+(NSDictionary*)mj_objectClassInArray
{
    return @{@"top_imgs":[CHCTop_Images_list class],@"list":[CHCTableVIewData_list class],@"classes":[CHCZhunTi_classes_list class]};
}

@end
