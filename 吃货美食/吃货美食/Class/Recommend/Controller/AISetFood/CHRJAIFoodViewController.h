//
//  CHRJAIFoodViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"
#import "CHRAIFoodCollectionViewCell.h"
#import "CHRJAISearchViewController.h"
#import "CHRAIBAseFoodDefault.h"

@interface CHRJAIFoodViewController : CHRJBasicViewController<CHRAIGetBaseFoodProtocol>
- (IBAction)chooseFoodAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *aiCollectionView;
@property (nonatomic,strong)NSMutableArray * chooseFoodArray;

@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)CHRAIBAseFoodDefault * baseFood;

@property (weak, nonatomic) IBOutlet UIButton *choosedButton;

@end
