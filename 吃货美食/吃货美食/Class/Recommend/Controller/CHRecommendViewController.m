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
#import "CHRWebViewController.h"
#import "CHRTodayBannerScrollerView.h"
@interface CHRecommendViewController ()<UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *recommendCollection;
@property (nonatomic,strong)CHJRecommendModel * recommendModel;
@property (nonatomic,strong)CHJRecomdTopHCollectionReusableView * topHeaderView;
@property (nonatomic,strong)CHRTodayBannerScrollerView * todayBannerScrollerView;
@property (nonatomic,strong)CHJRecomdTodayBanerFCollectionReusableView * todayFooterView;
@property (nonatomic,strong)NSTimer * todayBannerTimer;
@end

@implementation CHRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCollectionViewData];
    [self recommendCollectionRegister];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    if (!self.todayBannerTimer) {
        self.todayBannerTimer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(todayBannerTimerAction) userInfo:nil repeats:YES];
    }
    
    if (self.todayFooterView) {
        NSInteger currentPage = self.todayFooterView.todayBannerScrollerView.currentBannerCount;
        for (NSInteger i = 0; i < currentPage; i++) {
            [self.todayFooterView.todayBannerScrollerView rightShift];
        }
        self.todayFooterView.todayBannerPageControl.currentPage = self.todayFooterView.todayBannerScrollerView.currentBannerCount;
    }
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

- (void)pushToWebViewWithID:(NSNumber *)myID withUrlString:(NSString *)urlString{
    CHRWebViewController * webVC = [[CHRWebViewController alloc]init];
    webVC.webID = myID;
    webVC.urlString = urlString;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - ButtonActions
- (void)commitAction{
    
}

- (void)todayBannerTimerAction{
    [self.todayFooterView.todayBannerScrollerView rightShift];
    self.todayFooterView.todayBannerPageControl.currentPage = self.todayFooterView.todayBannerScrollerView.currentBannerCount;
}
#pragma mark - initSubs
- (void)recommdTopBannerHeaderSetting{
    self.topHeaderView.topBannerShow = self.recommendModel.topBannerShow;
    self.topHeaderView.topBannerTittle = self.recommendModel.topBannerTittle;
    self.topHeaderView.topBannerCollectionView.tag = 15928;
    self.topHeaderView.topBannerCollectionView.delegate = self;
    __weak typeof(self)mySelf = self;
    self.topHeaderView.choosedJump = ^(CHJRTopBannerShowModel * topModel){
        [mySelf pushToWebViewWithID:topModel.myID withUrlString:nil];
    };
    [self.topHeaderView.topBannerCollectionView reloadData];
}
- (void)recommdTodayBannerHeaderSetting{
    self.todayFooterView.todayBannerScrollerView.modelArray = self.recommendModel.todayBanner;
    self.todayFooterView.todayBannerScrollerView.delegate = self;
    self.todayFooterView.todayBannerScrollerView.tag = 192168;
    __weak typeof(self)mySelf = self;
    self.todayFooterView.todayBannerScrollerView.todayjump = ^(NSString * todayJumpURL){
        [mySelf pushToWebViewWithID:nil withUrlString:todayJumpURL];
    };
}
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
//        topBannerScrollerView
        NSInteger currentBannerCount = (self.topHeaderView.topBannerCollectionView.contentOffset.x + (CHSCREENWIDTH/2) )/ CHSCREENWIDTH;
        if (currentBannerCount == self.topHeaderView.topBanerPageView.currentPage)return;
        self.topHeaderView.topBanerPageView.currentPage = currentBannerCount;
    }else if (scrollView.tag == 192168){
//        todayBannerScrollerView
        if (self.todayFooterView.todayBannerScrollerView.contentOffset.x >= (CHSCREENWIDTH - 16.f) * 2) {
            [self.todayFooterView.todayBannerScrollerView rightShift];
        } else if (self.todayFooterView.todayBannerScrollerView.contentOffset.x <= 0.f){
            [self.todayFooterView.todayBannerScrollerView leftShift];
        }
        self.todayFooterView.todayBannerPageControl.currentPage = self.todayFooterView.todayBannerScrollerView.currentBannerCount;
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
            [self recommdTopBannerHeaderSetting];
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
            funFooterView.functionArr = self.recommendModel.topFunction;
            funFooterView.list = self.recommendModel.list;
            funFooterView.compose = self.recommendModel.compose;
            [funFooterView buttonSettingFun];
            __weak typeof(self)mySelf = self;
            funFooterView.topFunChoosePush = ^(UIViewController * pushVC){
                [mySelf.navigationController pushViewController:pushVC animated:YES];
            };
            return funFooterView;
        }else if (indexPath.section == 1){
            if (!self.todayFooterView) {
                self.todayFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CHJRecomdTodayBanerFCollectionReusableView" forIndexPath:indexPath];
                [self recommdTodayBannerHeaderSetting];
            }
            return self.todayFooterView;
        }else{
            CHJRecomdSugstFCollectionReusableView * sugFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CHJRecomdSugstFCollectionReusableView" forIndexPath:indexPath];
            [sugFooterView.commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
            return sugFooterView;
        }
        
    }
    return nil;
}

@end
