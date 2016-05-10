//
//  CHJRecommendModel.m
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHJRecommendModel.h"

@implementation CHJRecommendModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"topBannerShow":@"san_can",@"topFunction":@"fenlei",@"list":@"func2",@"compose":@"func1",@"topBannerTittle":@"san_can_titles",@"today":@"zt",@"todayBanner":@"top4",@"myLike":@"customized"};
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"topFunction":[CHJRTopFunctionModel class],@"topBannerShow":[CHJRTopBannerShowModel class],@"topBannerTittle":[CHJRTopBannerTittleModel class],@"today":[CHJRecomdTodayModel class],@"todayBanner":[CHJRecomdTdayBannerModel class],@"myLike":[CHJRecommendMyLikeModel class]};
}

@end
