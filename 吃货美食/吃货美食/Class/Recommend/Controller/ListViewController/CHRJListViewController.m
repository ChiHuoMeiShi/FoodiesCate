//
//  CHRJListViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/16.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJListViewController.h"
#import <UIImageView+WebCache.h>
#import "CHRJListCollectionViewCell.h"
#import "CHRJListToolBarModel.h"
#import "CHRJListFoodCollectionProtocal.h"
#import "CHRJSearchDetailViewController.h"
@interface CHRJListViewController ()<CHRJListFoodCollectionProtocal>
@property (nonatomic,strong)CHRJListToolBarModel * toolBarModel;

@end

@implementation CHRJListViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self listVCNavBarSet];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestToolBarData];
    self.listControllerView.tag = 54615315;
    [self.listControllerView registerNib:[UINib nibWithNibName:@"CHRJListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CHRJListCollectionViewCell"];
}

- (void)listVCNavBarSet{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#fc7d7d"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
    UILabel * showTittleLabel = [[UILabel alloc]initWithFrame:CGRectMake((CHSCREENWIDTH - 80.f)/2, self.navigationItem.titleView.y, 80.f, 30.f)];
    showTittleLabel.textColor = [UIColor whiteColor];
    showTittleLabel.textAlignment = NSTextAlignmentCenter;
    showTittleLabel.text = @"排行";
    showTittleLabel.font = [UIFont systemFontOfSize:20.f];
    self.navigationItem.titleView = showTittleLabel;
}
- (void)btnArrSet{
    self.btnArray = @[self.locationButton,self.foodbutton,self.foodMakeButton,self.searchButton,self.typeButton];
    __weak typeof(self)mySelf = self;
    [self.btnDataArray enumerateObjectsUsingBlock:^(CHRJListToolBarContentModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:obj.p] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            UIButton * btn = mySelf.btnArray[idx];
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            if (idx >= mySelf.btnArray.count - 1) {
                [mySelf btnAction:self.locationButton];
            }
        }];
    }];
}
- (void)btnAction:(UIButton *)btn{
    [self btnSetImageWithIsIp:NO];
    self.btnCurrentCount = [self.btnArray indexOfObject:btn];
    [self btnSetImageWithIsIp:YES];
    [self.listControllerView selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.btnCurrentCount inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
}
- (void)btnActionWithCount:(NSInteger)count{
    [self btnSetImageWithIsIp:NO];
    self.btnCurrentCount = count;
    [self btnSetImageWithIsIp:YES];

}
- (void)btnSetImageWithIsIp:(BOOL)isIp{
    CHRJListToolBarContentModel * model = (CHRJListToolBarContentModel *)self.btnDataArray[self.btnCurrentCount];
    NSString * urlStr;
    if (isIp) {
        urlStr = model.ip;
    }else{
        urlStr = model.p;
    }
    UIButton * btn = self.btnArray[self.btnCurrentCount];
    __weak typeof(btn)myBtn = btn;
    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:urlStr] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [myBtn setBackgroundImage:image forState:UIControlStateNormal];
    }];
}
#pragma mark - RequestData
- (void)requestToolBarData{
    NSString * url = @"http://api.meishi.cc/v5/top_new.php?format=json";
    NSDictionary * dic = @{@"lat":@(myLat),@"lon":@(myLon),@"source":@"iphone",@"format":@"json",@"uid":@"",@"st":@"1"};
    __weak typeof(self)mySelf = self;
    [self.afnManger.messageRequest POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
//        CHLog(@"%@",dic[@"navs"]);
        mySelf.btnDataArray= [CHRJListToolBarModel mj_objectWithKeyValues:dic].navs;
        [mySelf btnArrSet];
        [mySelf.listControllerView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
    }];
}

#pragma mark - CHRJListFoodCollectionProtocal
- (void)getShowWebID:(NSNumber *)myID{
    CHRWebViewController * webVC = [[CHRWebViewController alloc]init];
    webVC.webID = myID;
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)getShowSearchName:(NSString *)searchName{
    CHRJSearchDetailViewController * searchVC = [[CHRJSearchDetailViewController alloc]initWithSearchName:searchName];
    [self.navigationController pushViewController:searchVC animated:YES];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CHRJListCollectionViewCell * listCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHRJListCollectionViewCell" forIndexPath:indexPath];
    listCell.typeCount = @(indexPath.row);
    listCell.delegate = self;
    return listCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CHSCREENWIDTH - 20.f, collectionView.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == 54615315) {
        NSInteger currentCount = (scrollView.contentOffset.x + (CHSCREENWIDTH - 20.f) * 1/2) / (CHSCREENWIDTH - 20.f);
        if (currentCount != self.btnCurrentCount) {
            [self btnActionWithCount:currentCount];
        }
    }
    
}

@end
