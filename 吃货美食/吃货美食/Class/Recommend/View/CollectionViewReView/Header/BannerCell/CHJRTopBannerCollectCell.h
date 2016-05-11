//
//  CHJRTopBannerCollectCell.h
//  吃货美食
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHJRTopBannerCellView.h"
#import "CHJRTopBannerShowModel.h"

@interface CHJRTopBannerCollectCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet CHJRTopBannerCellView *topFoodView;
@property (weak, nonatomic) IBOutlet CHJRTopBannerCellView *centerFoodView;
@property (weak, nonatomic) IBOutlet CHJRTopBannerCellView *lastFoodView;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
