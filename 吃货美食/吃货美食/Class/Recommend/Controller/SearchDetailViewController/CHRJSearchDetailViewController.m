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
#define CHRSearchImageX (CHSCREENWIDTH/6 + 18.f)
@interface CHRJSearchDetailViewController ()
@property (nonatomic,strong)UIButton * chooseButton;
@property (nonatomic,strong)CHRJSearchModel * searchModel;
@property (nonatomic,copy)NSString * currentSort;
@property (nonatomic,assign)NSInteger pageCount;

@end

@implementation CHRJSearchDetailViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.showTopImageView.x = CHRSearchImageX;
    self.showTopImageView.hidden = NO;
    self.showBomImageView.x = CHRSearchImageX;
    self.showBomImageView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.searchName;
    [self buttonSetFun];
    self.currentSort = @"default";
    self.pageCount = 1;
    [self.showTableView registerNib:[UINib nibWithNibName:@"CHRJSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHRJSearchTableViewCell"];
    [self requestDataWithSort:self.currentSort];
    __weak typeof(self) mySelf = self;
    self.showTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [mySelf requestDataWithSort:mySelf.currentSort];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSDictionary * dic = @{@"lat":@(myLat),@"lon":@(myLon),@"source":@"iphone",@"format":@"json",@"step":@"",@"kw":@"",@"page":@(self.pageCount),@"q":self.searchName,@"sort_sc":@"desc",@"sort":sort,@"gy":@"",@"mt":@""};
    __weak typeof(self)mySelf = self;
    [manger POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [mySelf.showTableView.mj_footer endRefreshing];
        NSDictionary * dic = (NSDictionary *)responseObject;
//        CHLog(@"%@",dic[@"obj"]);
        if (mySelf.pageCount == 1) {
            mySelf.searchModel = [CHRJSearchModel mj_objectWithKeyValues:dic[@"obj"]];
        }else{
            CHRJSearchModel * tempModel = [CHRJSearchModel mj_objectWithKeyValues:dic[@"obj"]];
            [mySelf.searchModel.data addObjectsFromArray:tempModel.data];
        }
        mySelf.pageCount++;
        [mySelf.showTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
        [mySelf.showTableView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CHRJSearchTableViewCell * searchCell = [tableView dequeueReusableCellWithIdentifier:@"CHRJSearchTableViewCell"];
    searchCell.searchModel = self.searchModel.data[indexPath.row];
    return searchCell;
}
@end
