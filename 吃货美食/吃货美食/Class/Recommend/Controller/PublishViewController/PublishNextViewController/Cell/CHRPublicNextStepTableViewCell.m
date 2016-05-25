//
//  CHRPublicNextStepTableViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublicNextStepTableViewCell.h"

@implementation CHRPublicNextStepTableViewCell

- (void)awakeFromNib {
    [self.showFoodLabel.layer setBorderWidth:0.8f];
    [self.showFoodLabel.layer setCornerRadius:5.f];
    [self.showFoodLabel.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    self.showFoodLabelWidth.constant = (CHSCREENWIDTH - 20.f)/2;
    
    [self.showCountLabel.layer setBorderWidth:0.8f];
    [self.showCountLabel.layer setCornerRadius:5.f];
    [self.showCountLabel.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    self.showCountLabelWidth.constant = (CHSCREENWIDTH - 20.f)/2;
    
    [self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self setSelectedBackgroundView:bgColorView];
}

- (void)setFoodModel:(CHRPublishFoodMainFoodModel *)foodModel{
    if (!foodModel)return;
    _foodModel = foodModel;
    self.showFoodLabel.text = foodModel.name;
    self.showCountLabel.text = foodModel.count;
}


@end
