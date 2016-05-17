//
//  CHRJListFoodBaseModel.h
//  吃货美食
//
//  Created by scjy on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
@interface CHRJListFoodBaseModel : NSObject
@property (nonatomic,strong)NSNumber * myID;
@property (nonatomic,strong)NSNumber * order;

@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSMutableArray * recipes;

@end
