//
//  CHJRecmdUpdateCollectionViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHJRecmdUpdateCollectionViewCell.h"

@implementation CHJRecmdUpdateCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSearchMdodel:(CHRJSearchContentModel *)searchMdodel{
    if (!searchMdodel)return;
    _searchMdodel = searchMdodel;
    __weak typeof(self)mySelf = self;
    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:searchMdodel.titlepic] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        mySelf.showImageView.image = image;
    }];
    self.showLabel.text = searchMdodel.title;
}


@end
