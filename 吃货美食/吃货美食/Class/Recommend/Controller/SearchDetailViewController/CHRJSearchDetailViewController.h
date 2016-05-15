//
//  CHRJSearchDetailViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"
#import "CHRJSortModel.h"

@interface CHRJSearchDetailViewController : CHRJBasicViewController
//SearchVC push
@property (nonatomic,copy)NSString * searchName;

//SortVC push
@property (nonatomic,strong)NSArray * choosedTypeArr;
@property (nonatomic,assign)NSInteger choosedListCount;

@property (weak, nonatomic) IBOutlet UIButton *hotButton;
@property (weak, nonatomic) IBOutlet UIButton *hardButton;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;

@property (weak, nonatomic) IBOutlet UIImageView *showTopImageView;
@property (weak, nonatomic) IBOutlet UIImageView *showBomImageView;
@property (weak, nonatomic) IBOutlet UITableView *showTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *showColectionView;

- (instancetype)initWithChoosedTypeArr:(NSArray *)choosedTypeArr withChoosedListCount:(NSInteger)choosedListCount withSearchName:(NSString *)searchName;

@end
