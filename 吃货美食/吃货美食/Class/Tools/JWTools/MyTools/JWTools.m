//
//  JWTools.m
//  JW百思
//
//  Created by scjy on 16/3/21.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWTools.h"

@implementation JWTools

/**
 *  实现数组的排序功能
 *
 *  @param arr 将要被排序的数组
 *
 *  @param des 是升序还是降序，如果是降序为YES，反之为升序
 *
 *  @return 返回排序之后的数组
 */
+ (id)sortWithArray:(NSArray *)arr des:(BOOL)des{
    
    NSMutableArray *resultArr = [arr mutableCopy];
    
    [resultArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (des) {
            return obj1 > obj2;
        }else{
            return obj1 < obj2;
        }
        
    }];
    
    return [resultArr mutableCopy];
}

/**
 *  通过文字来计算文字所占的区域大小
 *
 *  @param text 文字
 *  @param font 字体大小
 *  @param size 控件最大大小
 *
 *  @return 文字所占的区域大小
 */
+ (CGSize)sizeForText:(NSString *)text withFont:(UIFont *)font withSize:(CGSize)size{
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    
    //通过文字来获取文字所占的大小
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size;
}


#pragma mark - FilePath

/**
 *  获取文件路径
 *
 *  @param fileName 文件名（需要类型）
 *
 *  @return 文件路径
 */
+ (NSString *)filePathWithFileName:(NSString *)fileName ofType:(NSString *)type{
    NSFileManager * fileManger = [NSFileManager defaultManager];
    
    NSArray * urlsArray = [fileManger URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL * pathURL = [urlsArray firstObject];
    NSString * path = [pathURL path];
    
    NSString * filePath;
    filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@.%@",fileName,type]];
    
    if (![fileManger fileExistsAtPath:filePath]) {
        [fileManger createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    return filePath;
}

/**
 *  获取文件路径
 *
 *  @param fileName 文件名
 *
 *  @return 文件路径
 */
+ (NSString *)filePathWithFileName:(NSString *)fileName{
    NSFileManager * fileManger = [NSFileManager defaultManager];
    
    NSArray * urlsArray = [fileManger URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL * pathURL = [urlsArray firstObject];
    NSString * path = [pathURL path];
    
    NSString * filePath;
    filePath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    
    if (![fileManger fileExistsAtPath:filePath]) {
        [fileManger createFileAtPath:filePath contents:nil attributes:nil];
    }
    
    return filePath;
}


/**
 *  通过文件名获取文本文件内容
 *
 *  @param fileName 文件名
 *
 *  @return 文件
 */
+ (NSString *)fileWithFileName:(NSString *)fileName{
    //获取数据所在的文件路径
    NSString *file = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    return file;
}


/**
 *  通过文件名获取文件内容
 *
 *  @param fileName Array文件名
 *
 *  @return Array文件
 */
+ (NSArray *)contentArrayForFileName:(NSString *)fileName{
    //将文件的内容转化为数组
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:[self filePathWithFileName:fileName]];
    
    return dataArr;
}

/**
 *  通过文件名获取文件内容
 *
 *  @param fileName Dictionary文件名
 *
 *  @return Dictionary文件
 */
+ (NSDictionary *)contentDictForFileName:(NSString *)fileName{
    //将文件的内容转化为数组
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[self filePathWithFileName:fileName]];
    
    return dict;
}

/**
 *  保存图片到本地
 *
 *  @param image 图片
 *
 *  @return 存储地址
 */
+ (NSString *)saveJImage:(UIImage *)image{
    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate * date = [NSDate date];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
    NSString * imgPath = [NSString stringWithFormat:@"%@.png",[dateFormatter stringFromDate:date]];
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString * imagePath = [NSString stringWithFormat:@"%@/%@",docs[0],imgPath];
    [imageData writeToFile:imagePath atomically:YES];
    return imgPath;
}
#pragma mark - NSDate
/**
 *  传一个日期字符串，判断是否是昨天，或者是今天的日期
 *
 *  @param dateStr 日期字符串
 *
 *  @return 修改完的日期字符串
 */
+ (NSString *)dateStr:(NSString *)dateStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:dateStr];

    //创建一个日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    if (!date) {
        return nil;
    }
    //通过日历对象，判断date是否是昨天的日期
    if ([calendar isDateInYesterday:date]) {
        dateFormatter.dateFormat = @"HH:mm:ss";
        return [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:date]];
    }
    //通过日历对象，判断date是否是今天的日期
    if ([calendar isDateInToday:date]) {
        dateFormatter.dateFormat = @"HH:mm:ss";
        return [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:date]];
    }
    
    dateFormatter.dateFormat = @"MM-dd HH:mm:ss";
    return [dateFormatter stringFromDate:date];
}


@end
