//
//  CHRTodayBannerScrollerView.h
//  吃货美食
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHJRecomdTdayBannerModel.h"
#import <UIImageView+WebCache.h>
extern const CGFloat todayBannerHeigh;
@interface CHRTodayBannerScrollerView : UIScrollView

@property (nonatomic,assign)NSInteger currentBannerCount;
@property (nonatomic,strong)NSMutableArray * imagesArray;
@property (nonatomic,strong)NSMutableArray * urlStringArray;
@property (nonatomic,strong)NSArray * modelArray;
@property (nonatomic,strong)UIButton * currentView;
@property (nonatomic,strong)UIView * beyoundView;
@property (nonatomic,strong)UIView * laterView;

- (void)imagesArrayAdd;

- (void)viewGetImagesView;

- (void)leftShift;

- (void)rightShift;

@end
