//
//  CHRJAIFoodCreateViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/20.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "CHAISearchFoodTableModel.h"
#import "CHRJAICreateFoodModel.h"
#import "CHRJAICreateCollectionViewCell.h"
#import "CHRJSearchDetailViewController.h"
@interface CHRJAIFoodCreateViewController : CHRJBasicViewController

@property (weak, nonatomic) IBOutlet UICollectionView *chooseFoodCollectionView;

@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)NSString * requestSidStr;

- (instancetype)initWithRequestBaseFoodArray:(NSMutableArray *)foodArray;

@end
