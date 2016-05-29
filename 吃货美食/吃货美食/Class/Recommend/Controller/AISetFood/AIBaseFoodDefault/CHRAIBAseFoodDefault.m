//
//  CHRAIBAseFoodDefault.m
//  吃货美食
//
//  Created by scjy on 16/5/19.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRAIBAseFoodDefault.h"

@implementation CHRAIBAseFoodDefault

+ (instancetype)shareSelectedBaseFood{
    
    return [[self alloc]init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static CHRAIBAseFoodDefault * baseFood = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseFood = [super allocWithZone:zone];
        baseFood.baseFoodArray = [[NSMutableArray alloc]initWithCapacity:0];
        
    });
    
    return baseFood;
}

MJExtensionCodingImplementation;

- (void)saveInfo{
    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * savePath = [NSString stringWithFormat:@"%@/CHRAIBAseFoodDefault.plist",docs[0]];
    NSData * saveData = [NSKeyedArchiver archivedDataWithRootObject:self];

    if ([saveData writeToFile:savePath atomically:YES]) {
        CHLog(@"save success");
    } else{
        CHLog(@"save failed");
    }
}

- (CHRAIBAseFoodDefault *)getInfo{
    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * filePath = [NSString stringWithFormat:@"%@/CHRAIBAseFoodDefault.plist",docs[0]];
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    CHLog(@"filePath is %@",filePath);

    id idValue = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return (CHRAIBAseFoodDefault *)idValue;
}

@end
