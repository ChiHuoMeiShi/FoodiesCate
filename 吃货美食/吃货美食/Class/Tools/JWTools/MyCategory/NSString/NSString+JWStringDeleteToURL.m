//
//  NSString+JWStringDeleteToURL.m
//  吃货美食
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "NSString+JWStringDeleteToURL.h"

@implementation NSString (JWStringDeleteToURL)

/**
 *  string删除
 *
 *  @param string      原本的string
 *  @param deleteString 要删的string
 *
 *  @return 删除完的string
 */
- (NSString *)string:(NSString *)string withDeleteString:(NSString *)deleteString{
    NSString * myString = [string stringByReplacingOccurrencesOfString:deleteString withString:@""];
    return myString;
}

/**
 *  string删除“\”
 *
 *  @param string 原本的string
 *
 *  @return 删除完的string
 */
- (NSString *)stringDeleteToURL:(NSString *)string{
    NSString * myString = [string stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return myString;
}


@end
