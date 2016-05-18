//
//  CHRJListFoodSearchTableViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJListFoodSearchTableViewCell.h"

@implementation CHRJListFoodSearchTableViewCell

- (void)awakeFromNib {
    [self setNeedsLayout];
}

- (void)setSearchModel:(CHRJListSearchFoodModel *)searchModel{
    if (!searchModel)return;
    _searchModel = searchModel;
    self.nameLabel.text = searchModel.w;
    self.orderLabel.text = [NSString stringWithFormat:@"%zi",[searchModel.order intValue]];
    self.distenceLabel.text = [NSString stringWithFormat:@"%zi",[searchModel.hot intValue]];
    
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

@end
