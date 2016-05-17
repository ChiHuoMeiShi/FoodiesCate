//
//  CHRJListFoodBaseTableViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJListFoodBaseTableViewCell.h"

@implementation CHRJListFoodBaseTableViewCell

- (void)awakeFromNib {
    self.imageViewArr = @[self.firstImageView,self.secondImageView,self.thirdImageView];
    [self setNeedsLayout];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self setSelectedBackgroundView:bgColorView];
}

- (void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithWhite:0.5f alpha:0.5f] set];
    CGContextSetLineWidth(ctx, 0.5f);
    CGContextMoveToPoint(ctx, 5.f, CGRectGetMaxY(rect) - 1.f);
    CGContextAddLineToPoint(ctx, CHSCREENWIDTH - 30.f, CGRectGetMaxY(rect) - 1.f);
    CGContextStrokePath(ctx);
}
- (CHRJListFoodAndTypeModel *)myFoodTypeModel{
    if (!_myFoodTypeModel) {
        _myFoodTypeModel = [[CHRJListFoodAndTypeModel alloc]init];
    }
    return _myFoodTypeModel;
}

- (void)foodTypeModelSetLayer{
    self.orderLabel.text = [NSString stringWithFormat:@"%zi",[self.myFoodTypeModel.order intValue]];
    self.nameLabel.text = self.myFoodTypeModel.title;
    self.myID = self.myFoodTypeModel.myID;
    __weak typeof(self)mySelf = self;
    [self.myFoodTypeModel.recipes enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:[obj stringDeleteToURL:obj]] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            UIImageView * imageViewTemp = mySelf.imageViewArr[idx];
            imageViewTemp.image = image;
        }];
    }];
}

@end
