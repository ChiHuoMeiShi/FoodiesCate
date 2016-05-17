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
    [self requestTableViewData];
}

- (void)requestTableViewData{
    NSString * url = @"http://api.meishi.cc/v5/top.php?format=json";
    NSDictionary * dicTemp = @{@"lat":@(myLat),@"lon":@(myLon),@"source":@"iphone",@"format":@"json",@"st":@"0",@"t":@"7",@"page":@"1",};
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
            [self cellSetModelClass:[CHRJListFoodBaseModel class] withCellClass:[CHRJListFoodBaseTableViewCell class] withReName:@"CHRJListFoodBaseTableViewCell"];
            break;
        case 3:
            [dic setValue:@(3) forKey:@"t"];
            [self cellSetModelClass:[CHRJListSearchFoodModel class] withCellClass:[CHRJListFoodTableViewCell class] withReName:@"CHRJListFoodTableViewCell"];
            break;
        case 4:
            [dic setValue:@(4) forKey:@"t"];
            [self cellSetModelClass:[CHRJListFoodTypeModel class] withCellClass:[CHRJListFoodSearchTableViewCell class] withReName:@"CHRJListFoodSearchTableViewCell"];
            break;
            
        default:
            break;
    }
    __weak typeof(self)mySelf = self;
    [self.afnManger.messageRequest POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dicData = (NSDictionary *)responseObject;
        //        CHLog(@"%@",dicData[@"d"]);
        mySelf.dataArray = [mySelf.dataClass mj_objectArrayWithKeyValuesArray:dicData[@"d"]];
        [mySelf.listTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
    }];
}

- (void)cellSetModelClass:(Class)modelClass withCellClass:(Class)cellClass withReName:(NSString *)reName{
    self.dataClass = modelClass;
    self.cellClass = cellClass;
    self.cellReName = reName;
    [self.listTableView registerNib:[UINib nibWithNibName:reName bundle:nil] forCellReuseIdentifier:reName];
}
#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.typeCount intValue] == 0) {
        CHRJListFoodTableViewCell * listCell = [tableView dequeueReusableCellWithIdentifier:self.cellReName];
        
        return listCell;
    }else if ([self.typeCount intValue] == 1){
        CHRJListFoodTableViewCell * listCell = [tableView dequeueReusableCellWithIdentifier:self.cellReName];
        
        return listCell;
    }else if ([self.typeCount intValue] == 2){
        CHRJListFoodBaseTableViewCell * listCell = [tableView dequeueReusableCellWithIdentifier:self.cellReName];
        
        return listCell;
    }else if ([self.typeCount intValue] == 3){
        CHRJListFoodTableViewCell * listCell = [tableView dequeueReusableCellWithIdentifier:self.cellReName];
        
        return listCell;
    }else{
        CHRJListFoodSearchTableViewCell * listCell = [tableView dequeueReusableCellWithIdentifier:self.cellReName];
        
        return listCell;
    }
}
@end
