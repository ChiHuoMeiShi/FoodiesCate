//
//  CHCArticalData.h
//  吃货美食
//
//  Created by eric on 16/5/15.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHCTop_Images_list.h"
#import "CHCTableVIewData_list.h"
#import "CHCZhunTi_classes_list.h"
#import <MJExtension.h>
@interface CHCArticalData : NSObject
@property(nonatomic,strong)NSMutableArray *top_imgs;
@property(nonatomic,strong)NSMutableArray *list;
//@property(nonatomic,strong)NSString *<#string#>;
//@property(nonatomic,strong)NSString *<#string#>;
//@property(nonatomic,strong)NSString *<#string#>;
//@property(nonatomic,strong)NSString *<#string#>;
//@property(nonatomic,strong)NSString *<#string#>;
@property(nonatomic,copy)NSString *cid;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)NSMutableArray *classes;
@end
