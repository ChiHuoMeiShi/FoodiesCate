//
//  CHRAIFoodCollectionViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRAIFoodCollectionViewCell.h"

@implementation CHRAIFoodCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)chooseButtonAction:(UIButton *)sender {
    self.isChoosed = !self.isChoosed;
    self.choosedImageView.hidden = self.isChoosed;
    
}

- (IBAction)deleButtonAction:(UIButton *)sender {
    if (!self.isDelete)return;
    
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    [self setSelectedBackgroundView:bgColorView];
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
