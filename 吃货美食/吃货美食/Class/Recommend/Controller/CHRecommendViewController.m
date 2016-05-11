//
//  CHRecommendViewController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRecommendViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>

#import "CHJRecommendModel.h"
#import "CHJRecomdTopHCollectionReusableView.h"
#import "CHJRecomdTodayHCollectionReusableView.h"
#import "CHJRecomdUpdateHCollectionReusableView.h"
#import "CHJRecmdUpdateCollectionViewCell.h"
#import "CHJRecomdFucFCollectionReusableView.h"
#import "CHJRecomdTodayBanerFCollectionReusableView.h"
#import "CHJRecomdSugstFCollectionReusableView.h"

@interface CHRecommendViewController ()<UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *recommendCollection;
@property (nonatomic,strong)CHJRecommendModel * recommendModel;
@property (nonnull,strong)CHJRecomdTopHCollectionReusableView * topHeaderView;


@end

@implementation CHRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCollectionViewData];
    [self recommendCollectionRegister];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getCollectionViewData{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString * url = @"http://api.meishi.cc/v5/index5.php?format=json";
    
    NSDictionary * dic = @{@"lat":@"34.6049907522264",@"lon":@"112.4229875834745",@"source":@"iphone",@"format":@"json",@"page":@"1",@"app_liketime":@"1462495842"};
    [manger POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
//        CHLog(@"%@",dic[@"obj"]);
        self.recommendModel = [CHJRecommendModel mj_objectWithKeyValues:dic[@"obj"]];
        [self.recommendCollection reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
    }];
}

#pragma mark - ButtonActions
- (void)commitAction{
    
}

#pragma mark - initSubs
- (void)recommendCollectionRegister{
    [self.recommendCollection registerNib:[UINib nibWithNibName:@"CHJRecmdUpdateCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CHJRecmdUpdateCollectionViewCell"];
//    Header
    [self.recommendCollection registerNib:[UINib nibWithNibName:@"CHJRecomdTopHCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CHJRecomdTopHCollectionReusableView"];
    [self.recommendCollection registerNib:[UINib nibWithNibName:@"CHJRecomdTodayHCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CHJRecomdTodayHCollectionReusableView"];
    [self.recommendCollection registerNib:[UINib nibWithNibName:@"CHJRecomdUpdateHCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CHJRecomdUpdateHCollectionReusableView"];
    
//    Footer
    [self.recommendCollection registerNib:[UINib nibWithNibName:@"CHJRecomdFucFCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CHJRecomdFucFCollectionReusableView"];
    [self.recommendCollection registerNib:[UINib nibWithNibName:@"CHJRecomdTodayBanerFCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CHJRecomdTodayBanerFCollectionReusableView"];
    [self.recommendCollection registerNib:[UINib nibWithNibName:@"CHJRecomdSugstFCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CHJRecomdSugstFCollectionReusableView"];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (collectionView.tag == 15928) {
        return CGSizeZero;
    }
    if (section == 0) {
        return CGSizeMake(self.view.width, 440.f);
    }else if (section == 1){
        return CGSizeMake(self.view.width, 35.f);
    }
    
    return CGSizeMake(self.view.width, 45.f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (collectionView.tag == 15928) {
        return CGSizeZero;
    }
    if (section == 0) {
        return CGSizeMake(self.view.width, 200.f);
    }
    return CGSizeMake(self.view.width, 80.f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 15928) {
        return CGSizeMake(CHSCREENWIDTH, 440.f);
    }
    return CGSizeMake(CHSCREENWIDTH, 440.f);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (collectionView.tag == 15928) {
        return 0;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (collectionView.tag == 15928) {
        return 0;
    }
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == 15928) {
        NSInteger currentBannerCount = (self.topHeaderView.topBannerCollectionView.contentOffset.x + (CHSCREENWIDTH/2) )/ CHSCREENWIDTH;
        if (currentBannerCount == self.topHeaderView.topBanerPageView.currentPage)return;
        self.topHeaderView.topBanerPageView.currentPage = currentBannerCount;
    }
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 2) {
        return 10;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CHJRecmdUpdateCollectionViewCell * recommdCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHJRecmdUpdateCollectionViewCell" forIndexPath:indexPath];
    
    return recommdCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            self.topHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CHJRecomdTopHCollectionReusableView" forIndexPath:indexPath];
            self.topHeaderView.topBannerShow = self.recommendModel.topBannerShow;
            self.topHeaderView.topBannerTittle = self.recommendModel.topBannerTittle;
            self.topHeaderView.topBannerCollectionView.tag = 15928;
            self.topHeaderView.topBannerCollectionView.delegate = self;
            [self.topHeaderView.topBannerCollectionView reloadData];
            return self.topHeaderView;
        }else if (indexPath.section == 1){
            CHJRecomdTodayHCollectionReusableView * todayHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CHJRecomdTodayHCollectionReusableView" forIndexPath:indexPath];
            return todayHeaderView;
        }else{
            CHJRecomdUpdateHCollectionReusableView * updateHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CHJRecomdUpdateHCollectionReusableView" forIndexPath:indexPath];
            updateHeaderView.showLabel.text = self.recommendModel.myLike.title;
            updateHeaderView.timeLabel
            .text = self.recommendModel.myLike.time;
            return updateHeaderView;
        }
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        if (indexPath.section == 0) {
            CHJRecomdFucFCollectionReusableView * funFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CHJRecomdFucFCollectionReusableView" forIndexPath:indexPath];
            return funFooterView;
        }else if (indexPath.section == 1){
            CHJRecomdTodayBanerFCollectionReusableView * todayFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CHJRecomdTodayBanerFCollectionReusableView" forIndexPath:indexPath];
            return todayFooterView;
        }else{
            CHJRecomdSugstFCollectionReusableView * sugFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CHJRecomdSugstFCollectionReusableView" forIndexPath:indexPath];
            [sugFooterView.commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
            return sugFooterView;
        }
        
    }
    return nil;
}

@end
