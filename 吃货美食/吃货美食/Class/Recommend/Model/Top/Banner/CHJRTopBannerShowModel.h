//
//  CHJRTopBannerShowModel.h
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
#import "CHJRecommendJumpModel.h"
@interface CHJRTopBannerShowModel : NSObject
@property (nonatomic,strong)NSNumber * myID;
@property (nonatomic,copy)NSString * click_trackingURL;
@property (nonatomic,strong)NSNumber * click_obj;
@property (nonatomic,strong)NSNumber * sft;
@property (nonatomic,copy)NSString * titlepic;
@property (nonatomic,strong)NSNumber * fav_num;
@property (nonatomic,copy)NSString * descr;
@property (nonatomic,copy)NSString * pv_trackingURL;
@property (nonatomic,strong)NSNumber * is_tj;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,strong)NSNumber * click_type;
@property (nonatomic,strong)NSNumber * is_recipe;
@property (nonatomic,copy)NSString * tj_img;
@property (nonatomic,strong)CHJRecommendJumpModel * jump;


@end
