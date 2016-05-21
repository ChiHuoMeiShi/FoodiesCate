//
//  CHRPublishChooseTypeViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublishChooseTypeViewController.h"

@interface CHRPublishChooseTypeViewController ()

@end

@implementation CHRPublishChooseTypeViewController



- (instancetype)initWithChoosedType:(CHRPublishFoodArrType)foodType withTittleName:(NSString *)tittleName
{
    self = [super init];
    if (self) {
        self.dataArray = [CHRPublishObjData publishDataWithType:foodType];
        self.name = tittleName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.name;
    [self.chooseFoodCollectionView registerNib:[UINib nibWithNibName:@"CHRPublishChooseTypeCell" bundle:nil] forCellWithReuseIdentifier:@"CHRPublishChooseTypeCell"];
}
- (IBAction)backButtonAction:(UIButton *)sender {
    [self navBackAction];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CHRPublishChooseTypeCell * publishCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHRPublishChooseTypeCell" forIndexPath:indexPath];
    NSDictionary * dataDIc = self.dataArray[indexPath.row];
    publishCell.showLabel.text = dataDIc[@"tittle"];
    if (self.dataArray.count > 10) {
        publishCell.showLabel.textAlignment = NSTextAlignmentCenter;
        publishCell.showLabel.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
    }
    return publishCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self)mySelf = self;
    if (self.delegate && [self.delegate respondsToSelector:@selector(choosedFoodDic: withName:)]) {
        [mySelf.delegate choosedFoodDic:mySelf.dataArray[indexPath.row] withName:mySelf.name];
    }
    [self navBackAction];
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count <= 10) {
        return CGSizeMake(CHSCREENWIDTH - 20.f, 44.f);
    }
    if (indexPath.section == 0) {
        CGFloat cellWidth = (CHSCREENWIDTH - 10.f * 6)/5;
        return CGSizeMake(cellWidth, 30.f);
    }else if (indexPath.section == 0){
        CGFloat cellWidth = (CHSCREENWIDTH - 10.f * 5)/4;
        return CGSizeMake(cellWidth, 30.f);
    }
    return CGSizeZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (self.dataArray.count <= 10) {
        return 0.f;
    }
    return 10.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (self.dataArray.count <= 10) {
        return 0.f;
    }
    return 10.f;
}

@end
