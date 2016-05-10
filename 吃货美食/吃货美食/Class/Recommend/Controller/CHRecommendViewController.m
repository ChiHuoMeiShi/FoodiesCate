//
//  CHRecommendViewController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRecommendViewController.h"
#import <AFNetworking.h>

#import "CHJRecomdTopHCollectionReusableView.h"
#import "CHJRecomdTodayHCollectionReusableView.h"
#import "CHJRecomdUpdateHCollectionReusableView.h"
#import "CHJRecmdUpdateCollectionViewCell.h"
#import "CHJRecomdFucFCollectionReusableView.h"
#import "CHJRecomdTodayBanerFCollectionReusableView.h"
#import "CHRecomdSugstFCollectionReusableView.h"

@interface CHRecommendViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *recommendCollection;

@end

@implementation CHRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
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
        CHLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
    }];
}

#pragma mark - Actions

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
    [self.recommendCollection registerNib:[UINib nibWithNibName:@"CHRecomdSugstFCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CHRecomdSugstFCollectionReusableView"];
}

#pragma mark - UICollectionViewDelegateFlowLayout


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



@end
