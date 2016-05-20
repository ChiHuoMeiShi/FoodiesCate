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
- (IBAction)chooseButtonAction:(UIButton *)sender {
    self.choosedImageView.hidden = self.isChoosed;
    self.isChoosed = !self.isChoosed;
    __weak typeof(self)mySelf = self;
    if (self.delegate && [self.delegate respondsToSelector:@selector(getCellBaseFood:)]) {
        [mySelf.delegate  getCellBaseFood:mySelf.foodModel];
    }
}
@end
