//
//  CHRAIBAseFoodDefault.h
//  吃货美食
//
//  Created by scjy on 16/5/19.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHDBModel.h"
#import <MJExtension.h>

@interface CHRAIBAseFoodDefault : CHDBModel<NSCoding>

@property (nonatomic,strong)NSMutableArray * baseFoodArray;

+ (instancetype)shareSelectedBaseFood;

- (void)saveInfo;

- (CHRAIBAseFoodDefault *)getInfo;

@end
