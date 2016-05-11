//
//  CHJRTopBannerCollectCell.m
//  吃货美食
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHJRTopBannerCollectCell.h"

@implementation CHJRTopBannerCollectCell

- (void)awakeFromNib {
    self.centerFoodView.showLabel.textAlignment = NSTextAlignmentLeft;
    self.centerFoodView.detailLabel.textAlignment = NSTextAlignmentLeft;
}

@end
