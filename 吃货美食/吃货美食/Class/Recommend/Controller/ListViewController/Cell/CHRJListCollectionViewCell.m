//
//  CHRJListCollectionViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/16.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJListCollectionViewCell.h"

@implementation CHRJListCollectionViewCell

- (void)awakeFromNib {
    self.afnManger = [CHHTTPRequestManager manager];
}
- (void)setTypeCount:(NSNumber *)typeCount{
    if (!typeCount)return;
    _typeCount = typeCount;
    self.page = 1;
    __weak typeof(self) mySelf = self;
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [mySelf requestTableViewData];
    }];
    self.listTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [mySelf requestFootTableViewData];
    }];
    [self requestTableViewData];
}
- (NSMutableDictionary *)requestDic{
    NSDictionary * dicTemp = @{@"lat":@(self.location.lat),@"lon":@(self.location.lon),@"source":@"iphone",@"format":@"json",@"st":@"0",@"t":@"7",@"page":@"1",};
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:dicTemp];
    switch ([self.typeCount intValue]) {
        case 0:
            [dic setValue:@(7) forKey:@"t"];
            [self cellSetModelClass:[CHRJSearchContentModel class] withCellClass:[CHRJListFoodTableViewCell class] withReName:@"CHRJListFoodTableViewCell"];
            break;
        case 1:
            [dic setValue:@(1) forKey:@"t"];
            [self cellSetModelClass:[CHRJSearchContentModel class] withCellClass:[CHRJListFoodTableViewCell class] withReName:@"CHRJListFoodTableViewCell"];
            break;
        case 2:
            [dic setValue:@(2) forKey:@"t"];
            [self cellSetModelClass:[CHRJListFoodAndTypeModel class] withCellClass:[CHRJListFoodBaseTableViewCell class] withReName:@"CHRJListFoodBaseTableViewCell"];
            break;
        case 3:
            [dic setValue:@(3) forKey:@"t"];
            [self cellSetModelClass:[CHRJListSearchFoodModel class] withCellClass:[CHRJListFoodSearchTableViewCell class] withReName:@"CHRJListFoodSearchTableViewCell"];
            break;
        case 4:
            [dic setValue:@(4) forKey:@"t"];
            [self cellSetModelClass:[CHRJListFoodAndTypeModel class] withCellClass:[CHRJListFoodBaseTableViewCell class] withReName:@"CHRJListFoodBaseTableViewCell"];
            break;
            
        default:
            break;
    };
    return dic;
}
- (void)requestTableViewData{
    NSString * url = @"http://api.meishi.cc/v5/top.php?format=json";
    NSMutableDictionary * dic = [self requestDic];
    __weak typeof(self)mySelf = self;
    [self.afnManger.messageRequest POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [mySelf.listTableView.mj_header endRefreshing];
        NSDictionary * dicData = (NSDictionary *)responseObject;
//      CHLog(@"%@",dicData[@"d"]);
        mySelf.dataArray = [mySelf.dataClass mj_objectArrayWithKeyValuesArray:dicData[@"d"]];
        [mySelf.listTableView reloadData];
        [mySelf.listTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
        [mySelf.listTableView.mj_header endRefreshing];
    }];
}

- (void)requestFootTableViewData{
    NSString * url = @"http://api.meishi.cc/v5/top.php?format=json";
    NSMutableDictionary * dic = [self requestDic];
    self.page++;
    [dic setObject:@(self.page) forKey:@"page"];
    __weak typeof(self)mySelf = self;
    [self.afnManger.messageRequest POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [mySelf.listTableView.mj_footer endRefreshing];
        NSDictionary * dicData = (NSDictionary *)responseObject;
        //      CHLog(@"%@",dicData[@"d"]);
        [mySelf.dataArray addObjectsFromArray:[mySelf.dataClass mj_objectArrayWithKeyValuesArray:dicData[@"d"]]];
        [mySelf.listTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
        [mySelf.listTableView.mj_footer endRefreshing];
    }];
}

- (void)cellSetModelClass:(Class)modelClass withCellClass:(Class)cellClass withReName:(NSString *)reName{
    self.dataClass = modelClass;
    self.cellClass = cellClass;
    self.cellReName = reName;
    [self.listTableView registerNib:[UINib nibWithNibName:reName bundle:nil] forCellReuseIdentifier:reName];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.typeCount intValue] == 0) {
        return 124.f;
    }else if ([self.typeCount intValue] == 1){
        return 124.f;
    }else if ([self.typeCount intValue] == 2){
        return 70.f;
    }else if ([self.typeCount intValue] == 3){
        return 50.f;
    }else{
        return 70.f;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.typeCount intValue] == 0) {
        CHRJListFoodTableViewCell * listCell = [tableView dequeueReusableCellWithIdentifier:self.cellReName];
        listCell.searchModel = self.dataArray[indexPath.row];
        listCell.delegate = self;
        return listCell;
    }else if ([self.typeCount intValue] == 1){
        CHRJListFoodTableViewCell * listCell = [tableView dequeueReusableCellWithIdentifier:self.cellReName];
        listCell.locationImageView.image = [UIImage imageNamed:@"ph_icon1"];
        listCell.searchModel = self.dataArray[indexPath.row];
        listCell.delegate = self;
        return listCell;
    }else if ([self.typeCount intValue] == 2){
        CHRJListFoodBaseTableViewCell * listCell = [tableView dequeueReusableCellWithIdentifier:@"CHRJListFoodBaseTableViewCell"];
        listCell.myFoodTypeModel = self.dataArray[indexPath.row];
        [listCell foodTypeModelSetLayer];
        listCell.delegate = self;
        return listCell;
    }else if ([self.typeCount intValue] == 3){
        CHRJListFoodSearchTableViewCell * listCell = [tableView dequeueReusableCellWithIdentifier:self.cellReName];
        listCell.searchModel = self.dataArray[indexPath.row];
        listCell.delegate = self;
        return listCell;
    }else{
        CHRJListFoodBaseTableViewCell * listCell = [tableView dequeueReusableCellWithIdentifier:@"CHRJListFoodBaseTableViewCell"];
        listCell.myFoodTypeModel = self.dataArray[indexPath.row];
        [listCell foodTypeModelSetLayer];
        listCell.delegate = self;
        return listCell;
    }
}

#pragma mark - CHRJListFoodTableProtocal
- (void)getShowWebID:(NSNumber *)myID{
    if (self.delegate && [self.delegate respondsToSelector:@selector(getShowWebID:)]) {
        [self.delegate  getShowWebID:myID];
    }
}
- (void)getShowSearchName:(NSString *)searchName{
    if (self.delegate && [self.delegate respondsToSelector:@selector(getShowSearchName:)]) {
        [self.delegate  getShowSearchName:searchName];
    }
}
@end
