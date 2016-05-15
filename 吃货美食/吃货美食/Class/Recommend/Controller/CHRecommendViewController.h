//
//  CHRecommendViewController.h
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>

#import "CHJRecommendModel.h"
#import "CHJRecomdTopHCollectionReusableView.h"
#import "CHJRecomdTodayHCollectionReusableView.h"
#import "CHJRecomdUpdateHCollectionReusableView.h"
#import "CHJRecomdFucFCollectionReusableView.h"
#import "CHJRecomdTodayBanerFCollectionReusableView.h"
#import "CHJRecomdSugstFCollectionReusableView.h"
#import "CHRTodayBannerScrollerView.h"
#import "CHJRecmdUpdateCollectionViewCell.h"
#import "CHJRecmdTodayCollectionViewCell.h"
#import "CHRJSearchModel.h"

#define CHRCollectionbWidth (CHSCREENWIDTH - 20.f)
extern const CGFloat myLat;
extern const CGFloat myLon;
@interface CHRecommendViewController : CHRJBasicViewController

@property (weak, nonatomic) IBOutlet UIButton *backToTopButton;

- (void)getCollectionViewData;
@end
