//
//  CHJRecomdTopHCollectionReusableView.m
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHJRecomdTopHCollectionReusableView.h"

@implementation CHJRecomdTopHCollectionReusableView

- (void)awakeFromNib {
    self.topBannerCollectionView.dataSource = self;
    [self.topBannerCollectionView registerNib:[UINib nibWithNibName:@"CHJRTopBannerCollectCell" bundle:nil] forCellWithReuseIdentifier:@"CHJRTopBannerCollectCell"];
}

- (void)setTopBannerTittle:(NSMutableArray *)topBannerTittle{
    if (!topBannerTittle)return;
    _topBannerTittle = topBannerTittle;
    if (_topBannerTittle.count >= 2) {
        self.topBanerPageView.numberOfPages = _topBannerTittle.count;
        [self.topBannerCollectionView setContentOffset:CGPointMake(CHSCREENWIDTH - 20.f, 0.f)];
    }else{
        self.topBanerPageView.numberOfPages = 1;
        self.topBanerPageView.currentPage = 0;
    }
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.topBannerTittle.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CHJRTopBannerCollectCell * topBannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHJRTopBannerCollectCell" forIndexPath:indexPath];
    CHJRTopBannerTittleModel * tittleModel = self.topBannerTittle[indexPath.row];
    topBannerCell.showLabel.text = tittleModel.title;
    topBannerCell.detailLabel.text = tittleModel.sub_title;
    __weak typeof(self)mySelf = self;
    for (int i = 3 * (int)indexPath.row; i < (3 * (indexPath.row + 1)); i++) {
        CHJRTopBannerShowModel * bannerShowModel = self.topBannerShow[i];
        if (i%3 == 1) {
            topBannerCell.topFoodView.showBannerModel = bannerShowModel;
            topBannerCell.topFoodView.selectedJump = ^(CHJRTopBannerShowModel * model){
                mySelf.choosedJump(model);
            };
        } else if (i%3 == 2) {
            topBannerCell.centerFoodView.showBannerModel = bannerShowModel;
            topBannerCell.centerFoodView.selectedJump = ^(CHJRTopBannerShowModel * model){
                mySelf.choosedJump(model);
            };
        } else{
            topBannerCell.lastFoodView.showBannerModel = bannerShowModel;
            topBannerCell.lastFoodView.selectedJump = ^(CHJRTopBannerShowModel * model){
                mySelf.choosedJump(model);
            };
        }
    }
    return topBannerCell;
}

@end
