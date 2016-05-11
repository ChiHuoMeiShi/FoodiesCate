//
//  CHJRTopBannerCellView.m
//  吃货美食
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHJRTopBannerCellView.h"

@implementation CHJRTopBannerCellView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.chooseButton = [[UIButton alloc]initWithFrame:CGRectMake(0.f, 0.f, CHSCREENWIDTH - 16.f, 115.f)];
        [self.chooseButton addTarget:self action:@selector(selectedJumpAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.chooseButton];
        self.showLabel = [[UILabel alloc]initWithFrame:CGRectMake(8.f, 55.f, CHSCREENWIDTH - 32.f, 21.f)];
        self.showLabel.textColor = [UIColor whiteColor];
        self.showLabel.font = [UIFont systemFontOfSize:20.f];
        self.showLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.showLabel];
        
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(8.f, 79.f, CHSCREENWIDTH - 32.f, 21.f)];
        self.detailLabel.textColor = [UIColor whiteColor];
        self.detailLabel.font = [UIFont systemFontOfSize:14.f];
        self.detailLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.detailLabel];
        
    }
    return self;
}

- (void)selectedJumpAction{
    self.selectedJump(self.showBannerModel);
}

- (void)setShowBannerModel:(CHJRTopBannerShowModel *)showBannerModel{
    if (!showBannerModel)return;
    _showBannerModel = showBannerModel;
    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:_showBannerModel.titlepic] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [self.chooseButton setImage:image forState:UIControlStateNormal];
    }];
    self.showLabel.text = _showBannerModel.title;
    self.detailLabel.text = _showBannerModel.descr;
    
}

@end
