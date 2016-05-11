//
//  CHJRecomdTopHCollectionReusableView.h
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHJRTopBannerShowModel.h"
#import "CHJRTopBannerTittleModel.h"
#import "CHJRTopBannerCollectCell.h"

#import <UIImageView+WebCache.h>
typedef void (^topBannerChosedJump)(CHJRTopBannerShowModel *);
@interface CHJRecomdTopHCollectionReusableView : UICollectionReusableView<UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *topBannerCollectionView;

@property (weak, nonatomic) IBOutlet UIPageControl *topBanerPageView;
@property (nonatomic,strong)NSMutableArray * topBannerShow;
@property (nonatomic,strong)NSMutableArray * topBannerTittle;
@property (nonatomic,copy)topBannerChosedJump choosedJump;

@end
