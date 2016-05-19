//
//  CHRAIBAseFoodDefault.h
//  吃货美食
//
//  Created by scjy on 16/5/19.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHRAIBAseFoodDefault : NSObject

@property (nonatomic,strong)NSMutableArray * baseFoodArray;

+ (instancetype)shareSelectedBaseFood;

@end
