//
//  CHJRecmdTodayCollectionViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHJRecmdTodayCollectionViewCell.h"

@implementation CHJRecmdTodayCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setTodayModel:(CHJRecomdTodayModel *)todayModel{
    if (!todayModel)return;
    _todayModel = todayModel;
    __weak typeof(self)mySelf = self;
    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:todayModel.photo] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        mySelf.showImageView.image = image;
    }];
    self.showLabel.text = todayModel.title;
    self.detailLabel.text = todayModel.descr;
}

@end
