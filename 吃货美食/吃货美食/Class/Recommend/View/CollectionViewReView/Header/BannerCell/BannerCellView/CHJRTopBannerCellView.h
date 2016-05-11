//
//  CHJRTopBannerCellView.h
//  吃货美食
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHJRTopBannerShowModel.h"
#import <UIImageView+WebCache.h>

@interface CHJRTopBannerCellView : UIView
@property (nonatomic,strong)UIButton *chooseButton;
@property (nonatomic,strong)UILabel *showLabel;
@property (nonatomic,strong)UILabel *detailLabel;
@property (nonatomic,strong)CHJRTopBannerShowModel * showBannerModel;

@end
