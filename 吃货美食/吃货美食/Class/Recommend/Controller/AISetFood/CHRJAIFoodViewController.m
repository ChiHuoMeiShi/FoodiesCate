//
//  CHRJAIFoodViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJAIFoodViewController.h"
#import "CHRAIFoodCollectionViewCell.h"
#import "CHRJAISearchViewController.h"

@interface CHRJAIFoodViewController ()<CHRAIGetBaseFoodProtocol>

@property (weak, nonatomic) IBOutlet UICollectionView *aiCollectionView;
@property (nonatomic,strong)NSMutableArray * dataArray;

@property (weak, nonatomic) IBOutlet UIButton *choosedButton;


@end

@implementation CHRJAIFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self listVCNavBarSet];
    [self.aiCollectionView registerNib:[UINib nibWithNibName:@"CHRAIFoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CHRAIFoodCollectionViewCell"];
    if (!self.dataArray) {
        self.dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
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
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTittle:@"完成" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(finishEditMyFood) forControlEvents:UIControlEventTouchUpInside];
}
- (void)finishEditMyFood{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTittle:@"编辑" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(editMyFood) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)chooseFoodAction:(UIButton *)sender {
    CHRJAISearchViewController * aiSearchVC = [[CHRJAISearchViewController alloc]init];
    aiSearchVC.delegate = self;
    [self presentViewController:aiSearchVC animated:NO completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CHRAIFoodCollectionViewCell * aiCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHRAIFoodCollectionViewCell" forIndexPath:indexPath];
    aiCell.foodModel = self.dataArray[indexPath.row];
    return aiCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidth = CHSCREENWIDTH/3 - 20.f;
    return CGSizeMake(cellWidth, 118.f);
}

#pragma mark - CHRAIGetBaseFoodProtocol
- (void)getBaseFood:(CHAISearchFoodTableModel *)baseFood{
    [self.dataArray addObject:baseFood];
    [self.aiCollectionView reloadData];
}

@end
