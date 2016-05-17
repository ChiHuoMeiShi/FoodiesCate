//
//  CHRecommendViewController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRecommendViewController.h"

@interface CHRecommendViewController ()<UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *recommendCollection;
@property (nonatomic,strong)CHJRecommendModel * recommendModel;
@property (nonatomic,strong)CHJRecomdTopHCollectionReusableView * topHeaderView;
@property (nonatomic,strong)CHRJSearchModel * searchModel;
@property (nonatomic,strong)CHRTodayBannerScrollerView * todayBannerScrollerView;
@property (nonatomic,strong)CHJRecomdTodayBanerFCollectionReusableView * todayFooterView;
@property (nonatomic,strong)AFHTTPSessionManager * afnManger;
@property (nonatomic,strong)NSTimer * todayBannerTimer;
@end

@implementation CHRecommendViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.recommendCollection.tag = 10955617;
    self.navigationItem.leftBarButtonItem = nil;
    self.title = @"";
    [self recommendCollectionRegister];
    [self getCollectionViewData];
    [self.backToTopButton addTarget:self action:@selector(backToTopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self requestUpdateFoodData];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self recommdSearchBarSetWithRect:CGRectMake(54.f, 26.f, (CHSCREENWIDTH - 108.f), 30.f)];
    
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

- (AFHTTPSessionManager *)afnManger{
    if (!_afnManger) {
        _afnManger = [AFHTTPSessionManager manager];
        _afnManger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    }
    return _afnManger;
}

- (void)recommdSearchBarSetWithRect:(CGRect)rect{
    self.searchView = [[[NSBundle mainBundle]loadNibNamed:@"CHRJSearchView" owner:nil options:nil]lastObject];
    self.searchView.frame = rect;
    [self.searchView.searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.searchView;
}

- (void)getCollectionViewData{
    __weak typeof(self)mySelf = self;
    NSString * url = @"http://api.meishi.cc/v5/index5.php?format=json";
    NSDictionary * dic = @{@"lat":@(myLat),@"lon":@(myLon),@"source":@"iphone",@"format":@"json",@"page":@"1",@"app_liketime":@"1462495842"};
    [self.afnManger POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
//        CHLog(@"%@",dic[@"obj"]);
        mySelf.recommendModel = [CHJRecommendModel mj_objectWithKeyValues:dic[@"obj"]];
        [mySelf.recommendCollection reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
    }];
}

- (void)requestUpdateFoodData{
    //    request like food
    if (self.searchModel)return;
    __weak typeof(self)mySelf = self;
    NSString * likeURL = @"http://api.meishi.cc/v5/search_category.php?format=json";
    NSDictionary * likeDicTemp = @{@"lat":@(myLat),@"lon":@(myLon),@"source":@"iphone",@"format":@"json",@"step":@"",@"kw":@"",@"page":@(0),@"q":@"热菜",@"sort_sc":@"desc",@"sort":@"default",@"gy":@"",@"mt":@""};
    NSMutableDictionary * likeDic = [NSMutableDictionary dictionaryWithDictionary:likeDicTemp];
    for (int pageCount = 1; pageCount < 4; pageCount++) {
        [likeDic setValue:@(pageCount) forKey:@"page"];
        [self.afnManger POST:likeURL parameters:likeDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic = (NSDictionary *)responseObject;
            //        CHLog(@"%@",dic[@"obj"]);
            if (!mySelf.searchModel) {
                mySelf.searchModel = [CHRJSearchModel mj_objectWithKeyValues:dic[@"obj"]];
            }else{
                CHRJSearchModel * tempModel = [CHRJSearchModel mj_objectWithKeyValues:dic[@"obj"]];
                [mySelf.searchModel.data addObjectsFromArray:tempModel.data];
            }
            [mySelf.recommendCollection reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            CHLog(@"%@",error);
        }];
    }
}

#pragma mark - ButtonActions

- (void)commitAction{
    
}
- (void)backToTopButtonAction:(id)sender {
    [self.recommendCollection setContentOffset:CGPointMake(0.f, -64.f) animated:YES];
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
    [self.recommendCollection registerNib:[UINib nibWithNibName:@"CHJRecmdTodayCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CHJRecmdTodayCollectionViewCell"];
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        CHJRecomdTodayModel * todayModel = self.recommendModel.today[indexPath.row];
        [self pushToWebViewWithID:todayModel.myID withUrlString:nil];
    } else if (indexPath.section == 2){
        CHRJSearchContentModel * searchMdodel = self.searchModel.data[indexPath.row];
        [self pushToWebViewWithID:searchMdodel.myID withUrlString:nil];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (collectionView.tag == 15928) {
        return CGSizeZero;
    }
    if (section == 0) {
        return CGSizeMake(CHRCollectionbWidth, 440.f);
    }else if (section == 1){
        return CGSizeMake(CHRCollectionbWidth, 35.f);
    }
    
    return CGSizeMake(CHRCollectionbWidth, 45.f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (collectionView.tag == 15928) {
        return CGSizeZero;
    }
    if (section == 0) {
        return CGSizeMake(CHRCollectionbWidth, 200.f);
    }else if (section == 1){
        return CGSizeMake(CHRCollectionbWidth, 90.f);
    }else{
        return CGSizeMake(CHRCollectionbWidth, 80.f);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 15928) {
        return CGSizeMake(CHRCollectionbWidth, 440.f);
    }
//    self.recommendCollection
    if (indexPath.section == 1) {
        return CGSizeMake(CHRCollectionbWidth, 140.f);
    }else if (indexPath.section == 2){
        return CGSizeMake((CHRCollectionbWidth - 10.f)/2, 145.f);
    }else{
        return CGSizeZero;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == 15928) {
//        topBannerScrollerView
        NSInteger currentBannerCount = (scrollView.contentOffset.x + (CHSCREENWIDTH/2) )/ CHSCREENWIDTH;
        if (currentBannerCount == self.topHeaderView.topBanerPageView.currentPage)return;
        self.topHeaderView.topBanerPageView.currentPage = currentBannerCount;
    }else if (scrollView.tag == 192168){
//        todayBannerScrollerView
        CHRTodayBannerScrollerView * todayScrollerVoew = (CHRTodayBannerScrollerView *)scrollView;
        if (scrollView.contentOffset.x >= (CHRCollectionbWidth) * 2) {
            [todayScrollerVoew rightShift];
        } else if (scrollView.contentOffset.x <= 0.f){
            [todayScrollerVoew leftShift];
        }
        self.todayFooterView.todayBannerPageControl.currentPage = todayScrollerVoew.currentBannerCount;
    }else if (scrollView.tag == 10955617){
        if (scrollView.contentOffset.y >= CHSCREENHEIGH * 2) {
            self.backToTopButton.hidden = NO;
        }else{
            self.backToTopButton.hidden = YES;
        }
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 1) {
        return self.recommendModel.today.count;
    }else if (section == 2) {
        return self.searchModel.data.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        CHJRecmdUpdateCollectionViewCell * recommdCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHJRecmdUpdateCollectionViewCell" forIndexPath:indexPath];
        recommdCell.searchMdodel = self.searchModel.data[indexPath.row];
        return recommdCell;
    }
    CHJRecmdTodayCollectionViewCell * todayCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHJRecmdTodayCollectionViewCell" forIndexPath:indexPath];
    todayCell.todayModel = self.recommendModel.today[indexPath.row];
    return todayCell;
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
