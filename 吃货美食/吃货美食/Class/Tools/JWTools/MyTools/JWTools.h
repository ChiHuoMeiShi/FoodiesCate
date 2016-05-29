//
//  JWTools.h
//  JW百思
//
//  Created by scjy on 16/3/21.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface JWTools : NSObject


/**
 *  实现数组的排序功能
 *
 *  @param arr 将要被排序的数组
 *
 *  @param des 是升序还是降序，如果是降序为YES，反之为升序
 *
 *  @return 返回排序之后的数组
 */
+ (id)sortWithArray:(NSArray *)arr des:(BOOL)des;

/**
 *  通过文字来计算文字所占的区域大小
 *
 *  @param text 文字
 *  @param font 字体大小
 *  @param size 控件最大大小
 *
 *  @return 文字所占的区域大小
 */
+ (CGSize)sizeForText:(NSString *)text withFont:(UIFont *)font withSize:(CGSize)size;


#pragma mark - FilePath
/**
 *  获取文件路径
 *
 *  @param fileName 文件名
 *  @param type     文件类型
 *
 *  @return 文件路径
 */
+ (NSString *)filePathWithFileName:(NSString *)fileName ofType:(NSString *)type;
/**
 *  获取文件路径
 *
 *  @param fileName 文件名
 *
 *  @return 文件路径
 */
+ (NSString *)filePathWithFileName:(NSString *)fileName;
/**
 *  通过文件名获取文本文件内容
 *
 *  @param fileName 文件名
 *
 *  @return 文件
 */
+ (NSString *)fileWithFileName:(NSString *)fileName;
/**
 *  通过文件名获取文件内容
 *
 *  @param fileName Array文件名
 *
 *  @return Array文件
 */
+ (NSArray *)contentArrayForFileName:(NSString *)fileName;
/**
 *  通过文件名获取文件内容
 *
 *  @param fileName Dictionary文件名
 *
 *  @return Dictionary文件
 */
+ (NSDictionary *)contentDictForFileName:(NSString *)fileName;

/**
 *  保存图片到本地
 *
 *  @param image 图片
 *
 *  @return 存储地址
 */
+ (NSString *)saveJImage:(UIImage *)image;

#pragma mark - NSDate
/**
 *  传一个日期字符串，判断是否是昨天，或者是今天的日期
 *
 *  @param dateStr 日期字符串
 *
 *  @return 修改完的日期字符串
 */
+ (NSString *)dateStr:(NSString *)dateStr;


@end
