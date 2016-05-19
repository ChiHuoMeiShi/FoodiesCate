//
//  CHCgongyi_info_list.m
//  吃货美食
//
//  Created by eric on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCgongyi_info_list.h"
#import <MJExtension.h>
#import "CHCrecipes_list.h"
@implementation CHCgongyi_info_list
+(NSDictionary*)mj_objectClassInArray
{
    return @{@"recipes":[CHCrecipes_list class]};
}
@end
