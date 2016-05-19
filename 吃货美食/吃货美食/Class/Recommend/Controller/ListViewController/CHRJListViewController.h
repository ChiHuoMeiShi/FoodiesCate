//
//  CHRJListViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/16.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"
#import <MJExtension.h>

@interface CHRJListViewController : CHRJBasicViewController

@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *foodbutton;
@property (weak, nonatomic) IBOutlet UIButton *foodMakeButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;
@property (nonatomic,strong)NSArray * btnArray;
@property (nonatomic,strong)NSMutableArray * btnDataArray;
@property (nonatomic,assign)NSInteger btnCurrentCount;

@property (weak, nonatomic) IBOutlet UICollectionView *listControllerView;

@end
