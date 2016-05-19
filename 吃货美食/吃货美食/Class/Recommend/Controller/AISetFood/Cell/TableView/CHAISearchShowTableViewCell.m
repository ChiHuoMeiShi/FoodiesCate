//
//  CHAISearchShowTableViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/19.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHAISearchShowTableViewCell.h"

@implementation CHAISearchShowTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFoodModel:(CHAISearchFoodTableModel *)foodModel{
    if (!foodModel)return;
    _foodModel = foodModel;
    [self setMyLayer];
}

- (void)setMyLayer{
    __weak typeof(self)mySelf = self;
    self.showLabel.text = self.foodModel.t;
    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:self.foodModel.myImg] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        mySelf.showImageView.image = image;
        
    }];
}

@end
