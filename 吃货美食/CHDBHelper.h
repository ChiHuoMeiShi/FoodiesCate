//
//  JKDataBase.h
//  吃货美食
//
//  Created by 赵天 on 16/5/25.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface CHDBHelper : NSObject

@property (nonatomic, retain, readonly) FMDatabaseQueue *dbQueue;

+ (CHDBHelper *)shareInstance;

+ (NSString *)dbPath;

@end
