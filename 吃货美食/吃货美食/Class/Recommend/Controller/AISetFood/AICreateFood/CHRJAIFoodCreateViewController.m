//
//  CHRJAIFoodCreateViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/20.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJAIFoodCreateViewController.h"

@interface CHRJAIFoodCreateViewController ()

@end

@implementation CHRJAIFoodCreateViewController

- (instancetype)initWithRequestBaseFoodArray:(NSMutableArray *)foodArray
{
    self = [super init];
    if (self) {
        __weak typeof(self)mySelf = self;
        self.requestSidStr = @"";
        self.dataArray = [[NSMutableArray alloc]initWithCapacity:0];
        [foodArray enumerateObjectsUsingBlock:^(CHAISearchFoodTableModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([mySelf.requestSidStr isEqualToString:@""]) {
                mySelf.requestSidStr = [NSString stringWithFormat:@"%@,",obj.myID];
            }else{
                mySelf.requestSidStr = [NSString stringWithFormat:@"%@%@,",mySelf.requestSidStr,obj.myID];
            }
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"智能组菜详情";
    [self.chooseFoodCollectionView registerNib:[UINib nibWithNibName:@"CHRJAICreateCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CHRJAICreateCollectionViewCell"];
    [self requestData];
}

- (void)requestData{
    NSString * url = @"http://api.meishi.cc/v5/shicaizucai_index.php?format=json";
    NSDictionary * dic = @{@"lat":@(myLat),@"lon":@(myLon),@"source":@"iphone",@"sids":self.requestSidStr};
    __weak typeof(self)mySelf = self;
    [self.afnManger.messageRequest POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        mySelf.dataArray = [CHRJAICreateFoodModel mj_objectArrayWithKeyValuesArray:dic[@"obj"]];
        
        [mySelf.chooseFoodCollectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
    }];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CHRJAICreateCollectionViewCell * requestCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHRJAICreateCollectionViewCell" forIndexPath:indexPath];
    requestCell.aiCreateFoodModel = self.dataArray[indexPath.row];
    return requestCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CHSCREENWIDTH, 140.f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CHRJAICreateFoodModel * contentModel = self.dataArray[indexPath.row];
    CHRJSearchDetailViewController * searchDetailVC = [[CHRJSearchDetailViewController alloc]initWithSearchName:contentModel.title];
    
    [self.navigationController pushViewController:searchDetailVC animated:YES];
}


@end
