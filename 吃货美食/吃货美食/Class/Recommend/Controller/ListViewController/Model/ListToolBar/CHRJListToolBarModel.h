//
//  CHRJListToolBarModel.h
//  吃货美食
//
//  Created by scjy on 16/5/16.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
#import "CHRJListToolBarContentModel.h"
@interface CHRJListToolBarModel : NSObject

@property (nonatomic,strong)NSArray * d;
@property (nonatomic,strong)NSMutableArray * navs;
@property (nonatomic,strong)NSNumber * code;
@property (nonatomic,copy)NSString * msg;
@property (nonatomic,strong)NSNumber * t;

@end
