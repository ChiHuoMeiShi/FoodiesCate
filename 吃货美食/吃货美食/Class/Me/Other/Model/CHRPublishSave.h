//
//  CHRPublishSave.h
//  吃货美食
//
//  Created by scjy on 16/5/24.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHRPublishFoodDetailModel.h"

@interface CHRPublishSave : NSObject
@property (nonatomic,strong)NSDictionary * foodDic;
@property (nonatomic,copy)NSString * foodName;
@property (nonatomic,copy)NSString * saveTime;

@property (nonatomic,strong)CHRPublishFoodDetailModel * foodDetail;

@end
