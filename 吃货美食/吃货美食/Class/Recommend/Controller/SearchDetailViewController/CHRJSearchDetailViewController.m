//
//  CHRJSearchDetailViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJSearchDetailViewController.h"
#import "CHRecommendViewController.h"
#import <AFHTTPSessionManager.h>
#import <MJRefresh.h>
#import "CHRJSearchModel.h"
#import "CHRJSearchTableViewCell.h"
#import "CHRJSearchCollectionViewCell.h"

#define CHRSearchImageX (CHSCREENWIDTH/6 + 18.f)
@interface CHRJSearchDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UIButton * chooseButton;
@property (nonatomic,strong)CHRJSearchModel * searchModel;
@property (nonatomic,copy)NSString * currentSort;
@property (nonatomic,assign)NSInteger pageCount;

@end

@implementation CHRJSearchDetailViewController
#pragma mark - initFun
- (instancetype)initWithChoosedTypeArr:(NSArray *)choosedTypeArr withChoosedListCount:(NSInteger)choosedListCount withSearchName:(NSString *)searchName{
    self = [super init];
    if (self) {
        if (choosedTypeArr) {
            self.choosedTypeArr = choosedTypeArr;
        }else{
            self.choosedTypeArr = nil;
        }
        
        self.choosedListCount = choosedListCount;
        self.searchName = searchName;
    }
    return self;
}
- (instancetype)initWithSearchName:(NSString *)searchName{
    self = [super init];
    if (self) {
        self.searchName = searchName;
    }
    return self;
}
- (instancetype)initWithIsVideo:(BOOL)isVideo{
    self = [super init];
    if (self) {
        self.isVideo = isVideo;
        self.choosedTypeArr = nil;
        self.searchName = @"热搜菜谱合集";
    }
    return self;
}
- (instancetype)initWithIsLocal:(BOOL)isLocal{
    self = [super init];
    if (self) {
        self.isLocal = isLocal;
        self.choosedTypeArr = nil;
        self.searchName = @"附近菜谱";
    }
    return self;
}
#pragma mark - ViewActivity
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.showTopImageView.x = CHRSearchImageX;
    self.showTopImageView.hidden = NO;
    self.showBomImageView.x = CHRSearchImageX;
    self.showBomImageView.hidden = NO;
    if (self.showColectionView) {
        [self.showColectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.choosedListCount inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.searchName;
    [self buttonSetFun];
    self.currentSort = @"default";
    self.pageCount = 1;
    
    [self searchTableViewSet];
    [self searchCollectionViewSet];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ViewSet
- (void)searchCollectionViewSet{
    if (self.choosedTypeArr) {
        self.showColectionView.x = 100.f;
        self.showColectionView.hidden = NO;
        self.showColectionView.dataSource = self;
        self.showColectionView.delegate = self;
        [self.showColectionView registerNib:[UINib nibWithNibName:@"CHRJSearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CHRJSearchCollectionViewCell"];
    }else{
        [self.showColectionView removeFromSuperview];
        self.showColectionView = nil;
    }
}

- (void)searchTableViewSet{
    [self.showTableView registerNib:[UINib nibWithNibName:@"CHRJSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHRJSearchTableViewCell"];
    [self requestDataWithSort:self.currentSort];
    __weak typeof(self) mySelf = self;
    self.showTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [mySelf requestDataWithSort:mySelf.currentSort];
    }];
}

- (void)buttonSetFun{
    self.chooseButton = self.hotButton;
    [self.hotButton addTarget:self action:@selector(chooseButton:) forControlEvents:UIControlEventTouchUpInside];
    self.hotButton.tag = 320410;
    [self.hardButton addTarget:self action:@selector(chooseButton:) forControlEvents:UIControlEventTouchUpInside];
    self.hardButton.tag = 320411;
    [self.timeButton addTarget:self action:@selector(chooseButton:) forControlEvents:UIControlEventTouchUpInside];
    self.timeButton.tag = 320412;
}

- (void)chooseButton:(UIButton *)btn{
    self.showTopImageView.x = CHRSearchImageX + btn.x;
    self.showBomImageView.x = CHRSearchImageX + btn.x;
    [self.chooseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.chooseButton = btn;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    NSString * sort = @"";
    switch (btn.tag) {
        case 320410:
            sort = @"default";
            break;
        case 320411:
            sort = @"step";
            break;
        case 320412:
            sort = @"time";
            break;
            
        default:
            break;
    }
    self.currentSort = sort;
    self.pageCount = 1;
    [self requestDataWithSort:sort];
    [self.showTableView setContentOffset:CGPointMake(0.f, 0.f) animated:YES];
    [self.showTableView reloadData];
}

- (void)requestDataWithSort:(NSString *)sort{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    NSString * url = @"http://api.meishi.cc/v5/search_category.php?format=json";
    NSDictionary * dicTemp = @{@"lat":@(myLat),@"lon":@(myLon),@"source":@"iphone",@"format":@"json",@"step":@"",@"kw":@"",@"page":@(self.pageCount),@"q":self.searchName,@"sort_sc":@"desc",@"sort":sort,@"gy":@"",@"mt":@""};
    if (self.isLocal) {
        dicTemp = @{@"lat":@(myLat),@"lon":@(myLon),@"source":@"iphone",@"format":@"json",@"page":@(1)};
        url = @"http://api.meishi.cc/v5/lsb_news.php?format=json";
    }
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:dicTemp];
    if (self.isVideo) {
        url = @"http://api.meishi.cc/v5/zt1.php?format=json";
        [dic removeObjectForKey:@"q"];
        [dic setObject:@(20001) forKey:@"cid"];
    }
    __weak typeof(self)mySelf = self;
    [manger POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [mySelf.showTableView.mj_footer endRefreshing];
        NSDictionary * dic = (NSDictionary *)responseObject;
//        CHLog(@"%@",dic[@"obj"]);
        
        if (mySelf.pageCount == 1) {
            if (self.isLocal) {
                mySelf.searchModel = [[CHRJSearchModel alloc]init];
                mySelf.searchModel.data = [CHRJSearchContentModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            }else{
                mySelf.searchModel = [CHRJSearchModel mj_objectWithKeyValues:dic[@"obj"]];
            }
        }else{
            if (self.isLocal) {
                [mySelf.searchModel.data addObjectsFromArray:[CHRJSearchContentModel mj_objectArrayWithKeyValuesArray:dic[@"data"]]];
            }else{
                CHRJSearchModel * tempModel = [CHRJSearchModel mj_objectWithKeyValues:dic[@"obj"]];
                [mySelf.searchModel.data addObjectsFromArray:tempModel.data];
            }
        }
        mySelf.pageCount++;
        [mySelf.showTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
        [mySelf.showTableView.mj_footer endRefreshing];
    }];
}
- (void)showHud{
    CHLog(@"HudSuccess");
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CHRJSearchContentModel * searchMdodel = self.searchModel.data[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushToWebViewWithID:searchMdodel.myID withUrlString:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchModel.data.count%10 != 0) {
        [self.searchModel.data removeObjectAtIndex:0];
    }
    return self.searchModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CHRJSearchTableViewCell * searchCell = [tableView dequeueReusableCellWithIdentifier:@"CHRJSearchTableViewCell"];
    searchCell.searchModel = self.searchModel.data[indexPath.row];
    __weak typeof(self) mySelf = self;
    
    searchCell.isLike = ^(BOOL islike){
        if (islike) {
            [mySelf showHUDWithText:@"品味真棒!" withTextFont:[UIFont systemFontOfSize:15.f] withTextColor:[UIColor blackColor] withTextSize:CGSizeMake(MAXFLOAT, 0.f) withAction:@selector(showHud) withIsAnimated:YES];
        }else{
            [mySelf showHUDWithText:@"已记住您的喜好!" withTextFont:[UIFont systemFontOfSize:15.f] withTextColor:[UIColor blackColor] withTextSize:CGSizeMake(MAXFLOAT, 0.f) withAction:@selector(showHud) withIsAnimated:YES];
        }
    };
    return searchCell;
}

#pragma mark - UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CHRJSortContentModel * searchNameModel = self.choosedTypeArr[indexPath.row];
    self.title = searchNameModel.name;
    self.searchName = searchNameModel.name;
    self.choosedListCount = indexPath.row;
    [self.showColectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    self.pageCount = 1;
    [self requestDataWithSort:self.currentSort];
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.choosedTypeArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CHRJSearchCollectionViewCell * searchCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHRJSearchCollectionViewCell" forIndexPath:indexPath];
    CHRJSortContentModel * searchNameModel = self.choosedTypeArr[indexPath.row];
    searchCollectionCell.showLabel.text = searchNameModel.name;
    
    return searchCollectionCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * attributes = [NSDictionary dicOfTextAttributeWithFont:[UIFont systemFontOfSize:16.f] withTextColor:[UIColor lightGrayColor]];
    CHRJSortContentModel * searchNameModel = self.choosedTypeArr[indexPath.row];
    CGRect myRect = [searchNameModel.name boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.f) options:NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    return CGSizeMake(myRect.size.width, 50.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    CGFloat rowMinWidth = 20.f;
    if (self.choosedTypeArr.count <= 6) {
        rowMinWidth = (CHSCREENWIDTH - 20.f)/(self.choosedTypeArr.count + 1) - 20.f;
    }
    return rowMinWidth;
}

@end
