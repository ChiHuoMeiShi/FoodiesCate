//
//  CHJRecomdTodayBanerFCollectionReusableView.h
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHRTodayBannerScrollerView.h"
@interface CHJRecomdTodayBanerFCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet CHRTodayBannerScrollerView *todayBannerScrollerView;
@property (weak, nonatomic) IBOutlet UIPageControl *todayBannerPageControl;

@end
