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
    self.likeButton.hidden = YES;
    self.hateButton.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    self.nameLabel.text = self.searchModel.title;
    NSString * hardString = [NSString stringWithFormat:@"%@步",self.searchModel.step];
    if (![self.searchModel.mt isEqualToString:@""]) {
        hardString = [NSString stringWithFormat:@"%@//%@",hardString,self.searchModel.mt];
    }
    self.hardLabel.text = hardString;
    NSString * typeString = [NSString stringWithFormat:@"%@//%@",self.searchModel.kouwei,self.searchModel.gongyi];
    self.typeLabel.text = typeString;
    
}


- (IBAction)selectLikeButtton:(UIButton *)sender {
    self.likeButton.hidden = NO;
    self.hateButton.hidden = NO;
}
@end
