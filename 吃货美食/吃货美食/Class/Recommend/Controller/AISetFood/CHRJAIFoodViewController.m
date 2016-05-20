//
//  CHRJAIFoodViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJAIFoodViewController.h"

@interface CHRJAIFoodViewController ()

@end

@implementation CHRJAIFoodViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#6ec95e"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self listVCNavBarSet];
    [self.aiCollectionView registerNib:[UINib nibWithNibName:@"CHRAIFoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"JWRAIFoodCollectionViewCell"];
    
    self.baseFood = [CHRAIBAseFoodDefault shareSelectedBaseFood];
    self.dataArray = self.baseFood.baseFoodArray;
    
    self.chooseFoodArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    [self.choosedButton addTarget:self action:@selector(choosedFoodAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)listVCNavBarSet{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#6ec95e"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTittle:@"编辑" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(editMyFood) forControlEvents:UIControlEventTouchUpInside];
    UILabel * showTittleLabel = [[UILabel alloc]initWithFrame:CGRectMake((CHSCREENWIDTH - 80.f)/2, self.navigationItem.titleView.y, 80.f, 30.f)];
    showTittleLabel.textColor = [UIColor whiteColor];
    showTittleLabel.textAlignment = NSTextAlignmentCenter;
    showTittleLabel.text = @"智能组菜";
    showTittleLabel.font = [UIFont systemFontOfSize:20.f];
    self.navigationItem.titleView = showTittleLabel;
}
- (void)editMyFood{
    self.isDelete = YES;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTittle:@"完成" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(finishEditMyFood) forControlEvents:UIControlEventTouchUpInside];
}
- (void)finishEditMyFood{
    self.isDelete = NO;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTittle:@"编辑" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(editMyFood) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)chooseFoodAction:(UIButton *)sender {
    CHRJAISearchViewController * aiSearchVC = [[CHRJAISearchViewController alloc]init];
    aiSearchVC.delegate = self;
    [self presentViewController:aiSearchVC animated:NO completion:nil];
}

- (void)choosedFoodAction{
    if (self.chooseFoodArray.count <= 0)return;
    CHRJAIFoodCreateViewController * createVC = [[CHRJAIFoodCreateViewController alloc]initWithRequestBaseFoodArray:self.chooseFoodArray];
    [self.navigationController pushViewController:createVC animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CHRAIFoodCollectionViewCell * aiCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JWRAIFoodCollectionViewCell" forIndexPath:indexPath];
    aiCell.foodModel = (CHAISearchFoodTableModel *)self.dataArray[indexPath.row];
    aiCell.delegate = self;
    return aiCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidth = CHSCREENWIDTH/3 - 20.f;
    return CGSizeMake(cellWidth, 118.f);
}

#pragma mark - CHRAIGetBaseFoodProtocol
- (void)getBaseFood:(CHAISearchFoodTableModel *)baseFood{
    if (self.dataArray.count == 0) {
        [self.dataArray addObject:baseFood];
        [self.aiCollectionView reloadData];
        return;
    }
    __block NSUInteger foodCount = 1;
    __weak typeof(self)mySelf = self;
    [self.dataArray enumerateObjectsUsingBlock:^(CHAISearchFoodTableModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![baseFood.myID isEqual:obj.myID]) {
            if (foodCount >= mySelf.dataArray.count) {
                [mySelf.dataArray addObject:baseFood];
                [mySelf.aiCollectionView reloadData];
                return;
            }
            foodCount++;
        }else{
            return;
        }
    }];
}
- (void)getCellBaseFood:(CHAISearchFoodTableModel *)baseFood{
    if (self.isDelete) {
        [self.dataArray removeObject:baseFood];
        [self.aiCollectionView reloadData];
        return;
    }else{
        [self.chooseFoodArray addObject:baseFood];
    }
}

@end
