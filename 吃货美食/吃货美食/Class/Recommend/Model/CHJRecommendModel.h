//
//  CHJRecommendModel.h
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

#import "CHJRTopListFunctModel.h"
#import "CHJRTopFunctionModel.h"
#import "CHJRTopBannerShowModel.h"
#import "CHJRTopBannerTittleModel.h"

#import "CHJRecomdTodayModel.h"
#import "CHJRecomdTdayBannerModel.h"

#import "CHJRecommendMyLikeModel.h"

@interface CHJRecommendModel : NSObject<NSCoding>

@property (nonatomic,strong)NSMutableArray * topBannerShow;
@property (nonatomic,strong)NSMutableArray * topBannerTittle;

@property (nonatomic,strong)NSMutableArray * topFunction;
@property (nonatomic,strong)CHJRTopListFunctModel * list;
@property (nonatomic,strong)CHJRTopListFunctModel * compose;

@property (nonatomic,strong)NSMutableArray * today;
@property (nonatomic,strong)NSMutableArray * todayBanner;

@property (nonatomic,strong)CHJRecommendMyLikeModel * myLike;

- (void)saveInfo;

- (CHJRecommendModel *)getInfo;

@end
