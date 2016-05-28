//
//  CHJRecomdTdayBannerModel.h
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
#import "CHJRecommendJumpModel.h"
@interface CHJRecomdTdayBannerModel : NSObject<NSCoding>

@property (nonatomic,copy)NSString * click_trackingURL;
@property (nonatomic,strong)NSNumber * is_recipe;
@property (nonatomic,strong)NSNumber * click_type;
@property (nonatomic,copy)NSString * pv_trackingURL;
@property (nonatomic,copy)NSString * photo;
@property (nonatomic,copy)NSString * click_obj;
@property (nonatomic,strong)NSNumber * sft;
@property (nonatomic,strong)CHJRecommendJumpModel * jump;

@end
