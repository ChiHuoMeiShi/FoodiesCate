//
//  CHRPublishObjGetDic.m
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublishObjGetDic.h"

@implementation CHRPublishObjGetDic

+ (NSDictionary *)dicGetTittle:(NSString *)str getID:(NSString *)myID{
    NSDictionary * dic = @{@"tittle":str,@"myID":myID};
    
    return dic;
}

@end
