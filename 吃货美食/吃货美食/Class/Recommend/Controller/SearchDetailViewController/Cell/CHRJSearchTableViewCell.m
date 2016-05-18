//
//  CHRJSearchTableViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJSearchTableViewCell.h"

@implementation CHRJSearchTableViewCell

- (void)awakeFromNib {
    self.starImageViewArr = @[self.firstStarImageView,self.secondStarImageView,self.thirdStarImageView,self.forthStarImageView,self.fifthStarImageView];
    [self hideLikeHateButton];
    [self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self hideLikeHateButton];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self setSelectedBackgroundView:bgColorView];
}

- (void)setSearchModel:(CHRJSearchContentModel *)searchModel{
    if (!searchModel)return;
    _searchModel = searchModel;
    [self cellLayerSet];
    [self.isSeeButton.layer setBorderWidth:0.3f];
    [self.isSeeButton.layer setCornerRadius:5.f];
    [self.isSeeButton.layer setBorderColor:[UIColor orangeColor].CGColor];
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
    self.nameLabel.text = self.searchModel.title;
    NSString * hardString = [NSString stringWithFormat:@"%@步",self.searchModel.step];
    if (self.searchModel.mt) {
        hardString = [NSString stringWithFormat:@"%@/%@",hardString,self.searchModel.mt];
    }
    self.hardLabel.text = hardString;
    NSString * typeString = [NSString stringWithFormat:@"%@/%@",self.searchModel.kouwei,self.searchModel.gongyi];
    self.typeLabel.text = typeString;
    if ([self.searchModel.is_see intValue] == 0) {
        self.isSeeButton.hidden = YES;
    }
    if (self.searchModel.distance) {
        self.selectLikeButtton.hidden = YES;
        self.locationLabel.hidden = NO;
        self.locationLabel.text = self.searchModel.distance;
        self.locationImageView.hidden = NO;
        return;
    }
    [self buttonSetFunctin];
}

- (void)showLikeHateButton{
    self.likeButton.hidden = NO;
    self.hateButton.hidden = NO;
}
- (void)hideLikeHateButton{
    self.likeButton.hidden = YES;
    self.hateButton.hidden = YES;
}
- (void)buttonSetFunctin{
    [self.selectLikeButtton addTarget:self action:@selector(selectLikeButttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.likeButton addTarget:self action:@selector(likeButttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.hateButton addTarget:self action:@selector(hateButttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectLikeButttonAction:(UIButton *)sender {
    [self showLikeHateButton];
}

- (void)likeButttonAction:(UIButton *)sender {
    self.isLike(YES);
    [self hideLikeHateButton];
}

- (void)hateButttonAction:(UIButton *)sender {
    self.isLike(NO);
    [self hideLikeHateButton];
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
