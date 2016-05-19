//
//  CHRJListCollectionViewCell.h
//  吃货美食
//
//  Created by scjy on 16/5/16.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHHTTPRequestManager.h"
#import "CHRJBasicViewController.h"
#import "CHRJSearchContentModel.h"
#import "CHRJListSearchFoodModel.h"
#import "CHRJListFoodAndTypeModel.h"
#import "CHHTTPRequestManager.h"
#import "CHRJListFoodTableProtocal.h"

#import "CHRJListFoodSearchTableViewCell.h"
#import "CHRJListFoodBaseTableViewCell.h"
#import "CHRJListFoodTableViewCell.h"
#import "CHRJListFoodCollectionProtocal.h"
#import <MJRefresh.h>

@interface CHRJListCollectionViewCell : UICollectionViewCell<CHRJListFoodTableProtocal>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic,strong)NSNumber * typeCount;
@property (nonatomic,strong)Class dataClass;
@property (nonatomic,strong)Class cellClass;
@property (nonatomic,strong)NSString * cellReName;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)CHHTTPRequestManager * afnManger;
@property(nonatomic, assign)int page;

@property (nonatomic,weak)id<CHRJListFoodCollectionProtocal> delegate;

@end
