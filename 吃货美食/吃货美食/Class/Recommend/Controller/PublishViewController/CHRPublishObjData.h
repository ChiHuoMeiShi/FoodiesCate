//
//  CHRPublishObjData.h
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHRPublishObjGetDic.h"
typedef enum jPublishFood{
    CHRPublishFoodGongYi = 0,
    CHRPublishFoodKouWei,
    CHRPublishFoodNanDu,
    CHRPublishFoodZBShijian,
    CHRPublishFoodPRShijian,
    CHRPublishFoodRenShu,
    CHRPublishFoodGuiGe
}CHRPublishFoodArrType;
@interface CHRPublishObjData : NSObject

@property (nonatomic,assign)CHRPublishFoodArrType arrType;


+ (NSArray *)publishDataWithType:(CHRPublishFoodArrType)type;

@end
