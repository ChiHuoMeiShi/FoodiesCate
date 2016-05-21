//
//  CHRPublishChooseTypeViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"
#import "CHRPublishObjData.h"
#import "CHRPublishChooseTypeCell.h"
#import "CHRPublicChooseTypeProtocol.h"

@interface CHRPublishChooseTypeViewController : CHRJBasicViewController

@property (nonatomic,strong)NSArray * dataArray;
@property (nonatomic,strong)NSString * name;
@property (weak, nonatomic) IBOutlet UICollectionView *chooseFoodCollectionView;
@property (nonatomic,weak)id<CHRPublicChooseTypeProtocol> delegate;

- (IBAction)backButtonAction:(UIButton *)sender;


- (instancetype)initWithChoosedType:(CHRPublishFoodArrType)foodType withTittleName:(NSString *)tittleName;

@end
