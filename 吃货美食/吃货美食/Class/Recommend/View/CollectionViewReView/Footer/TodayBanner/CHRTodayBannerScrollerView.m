//
//  CHRTodayBannerScrollerView.m
//  吃货美食
//
//  Created by scjy on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRTodayBannerScrollerView.h"
const CGFloat todayBannerHeigh = 80.f;

@implementation CHRTodayBannerScrollerView

- (void)setModelArray:(NSArray *)modelArray{
    if (!modelArray)return;
    _modelArray = modelArray;
    self.contentSize = CGSizeMake((CHSCREENWIDTH - 20.f) * _modelArray.count, todayBannerHeigh);
    self.imagesArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.urlStringArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self imagesArrayAdd];
}

- (void)viewGetImagesView{
    UIImageView * currentImageView = self.imagesArray[0];
    [self.currentView addSubview:currentImageView];
    
    [self setContentOffset:CGPointMake(self.frame.size.width, 0.f) animated:NO];
    
    UIImageView * laterImageView = self.imagesArray[1];
    [self.laterView addSubview:laterImageView];
    
    UIImageView * beyoundImageView = [self.imagesArray lastObject];
    [self.beyoundView addSubview:beyoundImageView];
}

- (void)imagesArrayAdd{
    __weak typeof(self)mySelf = self;
    [self.modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CHJRecomdTdayBannerModel * todayBannerModel = (CHJRecomdTdayBannerModel *)obj;
        [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:todayBannerModel.photo] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            UIImageView * imageViewTemp = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, CHSCREENWIDTH - 20.f, todayBannerHeigh)];
            imageViewTemp.image = image;
            [mySelf.imagesArray addObject:imageViewTemp];
            if (idx >= mySelf.modelArray.count - 1) {
                [self viewGetImagesView];
            }
        }];
        [mySelf.urlStringArray addObject:todayBannerModel.jump.property.urlString];
    }];
    
    self.beyoundView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, CHSCREENWIDTH - 20.f, todayBannerHeigh)];
    self.beyoundView.backgroundColor = [UIColor cyanColor];
    [self addSubview:self.beyoundView];
    self.currentView = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.beyoundView.frame), 0.f, CHSCREENWIDTH - 20.f, todayBannerHeigh)];
    [self.currentView addTarget:self action:@selector(currentChooseAction) forControlEvents:UIControlEventTouchUpInside];
    self.currentView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.currentView];
    self.laterView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.currentView.frame), 0.f, CHSCREENWIDTH - 20.f, todayBannerHeigh)];
    self.laterView.backgroundColor = [UIColor redColor];
    [self addSubview:self.laterView];
    
}

- (void)leftShift{
    self.currentBannerCount--;
    if (self.currentBannerCount < 0) {
        self.currentBannerCount = [self.modelArray count] - 1;
    }
    UIImageView * imageViewTemp = [self.imagesArray lastObject];
    
    [self.imagesArray removeLastObject];
    [self.imagesArray insertObject:imageViewTemp atIndex:0];
    
    [self viewGetImagesView];
}

- (void)rightShift{
    self.currentBannerCount++;
    if (self.currentBannerCount >= self.modelArray.count) {
        self.currentBannerCount = 0;
    }
    UIImageView * imageViewTemp = [self.imagesArray firstObject];
    
    [self.imagesArray removeObjectAtIndex:0];
    [self.imagesArray addObject:imageViewTemp];
    
    [self viewGetImagesView];
}

- (void)currentChooseAction{
    self.todayjump(self.urlStringArray[self.currentBannerCount]);
}

@end
