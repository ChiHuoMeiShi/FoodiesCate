//
//  CHRJListFoodTableViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJListFoodTableViewCell.h"

@implementation CHRJListFoodTableViewCell

- (void)awakeFromNib {
    self.starImageViewArr = @[self.firstStarImageView,self.secondStarImageView,self.thirdStarImageView,self.forthStarImageView,self.fifthStarImageView];
    [self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self setSelectedBackgroundView:bgColorView];
}
- (void)setSearchModel:(CHRJSearchContentModel *)searchModel{
    if (!searchModel)return;
    _searchModel = searchModel;
    [self cellLayerSet];
}
- (void)cellLayerSet{
    __weak typeof(self)mySelf = self;
    int starCount = [self.searchModel.rate intValue];
    if (starCount > 5) {
        starCount = 5;
    }
    for (int i = 0; i < starCount; i++) {
        UIImageView * starImageView= self.starImageViewArr[i];
        starImageView.image = [UIImage imageNamed:@"ms_caipu_level"];
    };
    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:self.searchModel.titlepic] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        mySelf.showImageView.image = image;
    }];
    self.orderLabel.text = [NSString stringWithFormat:@"%zi",[self.searchModel.order intValue]];
    self.nameLabel.text = self.searchModel.title;
    NSString * hardString = [NSString stringWithFormat:@"%@步",self.searchModel.step];
    if (![self.searchModel.mt isEqualToString:@""]) {
        hardString = [NSString stringWithFormat:@"%@,%@",hardString,self.searchModel.mt];
    }
    self.hardLabel.text = hardString;
    NSString * typeString = [NSString stringWithFormat:@"%@,%@",self.searchModel.kouwei,self.searchModel.gongyi];
    self.typeLabel.text = typeString;
    
    if (!self.searchModel.distance) {
        self.locationLabel.text = self.searchModel.right_w;
        return;
    }
}
- (void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithWhite:0.5f alpha:0.5f] set];
    CGContextSetLineWidth(ctx, 0.5f);
    CGContextMoveToPoint(ctx, 5.f, CGRectGetMaxY(rect) - 1.f);
    CGContextAddLineToPoint(ctx, CHSCREENWIDTH - 30.f, CGRectGetMaxY(rect) - 1.f);
    CGContextStrokePath(ctx);
}

@end
