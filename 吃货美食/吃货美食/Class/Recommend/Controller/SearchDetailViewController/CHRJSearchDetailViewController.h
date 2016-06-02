//
//  CHRJSearchDetailViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"
#import "CHRJSortModel.h"
#import "CHRecommendViewController.h"
#import <MJRefresh.h>
#import <MapKit/MapKit.h>
#import "CHRJSearchModel.h"
#import "CHRJSearchTableViewCell.h"
#import "CHRJSearchCollectionViewCell.h"

#define CHRSearchImageX (CHSCREENWIDTH/6 + 18.f)

@interface CHRJSearchDetailViewController : CHRJBasicViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MKMapViewDelegate>
//SearchVC push
@property (nonatomic,copy)NSString * searchName;
//SortVC push
@property (nonatomic,strong)NSArray * choosedTypeArr;
@property (nonatomic,assign)NSInteger choosedListCount;
//Video push
@property (nonatomic,assign)BOOL isVideo;
//Local push
@property (nonatomic,assign)BOOL isLocal;

@property (weak, nonatomic) IBOutlet UIButton *hotButton;
@property (weak, nonatomic) IBOutlet UIButton *hardButton;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;


@property (weak, nonatomic) IBOutlet UITableView *showTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *showColectionView;


@property (nonatomic,strong)UIButton * chooseButton;
@property (nonatomic,strong)CHRJSearchModel * searchModel;
@property (nonatomic,copy)NSString * currentSort;
@property (nonatomic,assign)NSInteger pageCount;
@property (strong, nonatomic)UIImageView *showTopImageView;
@property (strong, nonatomic)UIImageView *showBomImageView;
@property (nonatomic,strong)UISegmentedControl * mineSegmentedControl;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (instancetype)initWithChoosedTypeArr:(NSArray *)choosedTypeArr withChoosedListCount:(NSInteger)choosedListCount withSearchName:(NSString *)searchName;
- (instancetype)initWithIsVideo:(BOOL)isVideo;
- (instancetype)initWithIsLocal:(BOOL)isLocal;
- (instancetype)initWithSearchName:(NSString *)searchName;

@end
