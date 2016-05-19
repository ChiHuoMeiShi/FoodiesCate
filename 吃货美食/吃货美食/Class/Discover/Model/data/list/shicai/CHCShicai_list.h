//
//  CHCShicai_list.h
//  吃货美食
//
//  Created by eric on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHCShicai_list : NSObject
@property(nonatomic,strong)NSString *myid;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,copy)NSString *tag;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *heat_level;
@property(nonatomic,strong)NSString *heat_word;
@property(nonatomic,strong)NSArray *gongxiao;
@end
