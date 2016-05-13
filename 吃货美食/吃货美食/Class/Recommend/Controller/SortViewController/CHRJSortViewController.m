//
//  CHRJSortViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/12.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJSortViewController.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import "CHRJSortModel.h"
#import "CHRJSortTableViewCell.h"
#import "CHRJSortCollectionViewCell.h"
@interface CHRJSortViewController ()
@property (weak, nonatomic) IBOutlet UITableView *sortTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *sortCollectionView;
@property (nonatomic,strong)NSMutableArray * sortDataArr;
@property (nonatomic,strong)CHRJSortModel * selectedModel;
@end

@implementation CHRJSortViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.sortTableView) {
        NSIndexPath *selectedIndexPath =[NSIndexPath indexPathForRow:2 inSection:0];
        [self.sortTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
    NSString * sortDataArrPath = [[NSBundle mainBundle]pathForResource:@"CHRFenLei" ofType:@"plist"];
    self.sortDataArr = [CHRJSortModel mj_objectArrayWithFile:sortDataArrPath];
    [self.sortTableView registerNib:[UINib nibWithNibName:@"CHRJSortTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHRJSortTableViewCell"];
    
    
    [self.sortCollectionView registerNib:[UINib nibWithNibName:@"CHRJSortCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CHRJSortCollectionViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedModel = self.sortDataArr[indexPath.row];
    [self.sortCollectionView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sortDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CHRJSortTableViewCell * sortTableCell = [tableView dequeueReusableCellWithIdentifier:@"CHRJSortTableViewCell"];
    CHRJSortModel * sortModel = self.sortDataArr[indexPath.row];
    sortTableCell.showLabel.text = sortModel.name;
    sortTableCell.showImageView.image = [UIImage imageNamed:sortModel.imageName];
    return sortTableCell;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger selectedCount = self.sortTableView.indexPathForSelectedRow.row;
    self.selectedModel = self.sortDataArr[selectedCount];
    return self.selectedModel.listArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CHRJSortCollectionViewCell * sortCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHRJSortCollectionViewCell" forIndexPath:indexPath];
    CHRJSortContentModel * choosedModel = self.selectedModel.listArr[indexPath.row];
    NSString * imageURLString = [NSString stringWithFormat:@"http://static.meishij.net/images/get3/fenlei/fl_%@_%zi.png",self.selectedModel.urlName,indexPath.row + 1];
    __weak typeof(sortCollectionCell)mySortCell = sortCollectionCell;
    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:imageURLString] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        mySortCell.showImageView.image = image;
    }];
    sortCollectionCell.showLabel.text = choosedModel.name;
    return sortCollectionCell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidth = CHSCREENWIDTH - 100.f;
    return CGSizeMake(cellWidth/3, 80.f);
}
@end
