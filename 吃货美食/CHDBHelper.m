//
//  JKDataBase.m
//  吃货美食
//
//  Created by 赵天 on 16/5/25.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHDBHelper.h"

@interface CHDBHelper ()

@property (nonatomic, retain) FMDatabaseQueue *dbQueue;

@end

@implementation CHDBHelper

static CHDBHelper *_instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _instance;
}

+ (NSString *)dbPath
{
//    MARK:带有文件夹的数据库存放路径
//    NSString *docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSFileManager *filemanage = [NSFileManager defaultManager];
//    docsdir = [docsdir stringByAppendingPathComponent:@"JKBD"];
//    BOOL isDir;
//    BOOL exit =[filemanage fileExistsAtPath:docsdir isDirectory:&isDir];
//    if (!exit || !isDir) {
//        [filemanage createDirectoryAtPath:docsdir withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    NSString *dbpath = [docsdir stringByAppendingPathComponent:@"jkdb.sqlite"];
//    
//    MARK:直接存放数据库路径
    NSString *dbpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test.sqlite"];
    
    
    
    
    
    
    
    
    NSLog(@"%@",dbpath);
    return dbpath;
}

- (FMDatabaseQueue *)dbQueue
{
    if (_dbQueue == nil) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:[self.class dbPath]];
    }
    return _dbQueue;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [CHDBHelper shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [CHDBHelper shareInstance];
}

#if ! __has_feature(objc_arc)
- (oneway void)release
{
    
}

- (id)autorelease
{
    return _instance;
}

- (NSUInteger)retainCount
{
    return 1;
}
#endif

@end
