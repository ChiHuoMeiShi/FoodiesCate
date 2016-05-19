//
//  CHRJListFoodBaseTableViewCell.h
//  吃货美食
//
//  Created by scjy on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHRJListFoodAndTypeModel.h"
#import <UIImageView+WebCache.h>
#import "CHRJListFoodTableProtocal.h"
@interface CHRJListFoodBaseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;
@property (nonatomic,strong)NSArray * imageViewArr;


- (IBAction)chooseButtonAction:(UIButton *)sender;
@property (nonatomic,assign)NSNumber * myID;
@property (nonatomic,strong)CHRJListFoodAndTypeModel * myFoodTypeModel;

@property (nonatomic,assign)BOOL isChoosed;
@property (nonatomic,weak)id<CHRJListFoodTableProtocal> delegate;

- (void)foodTypeModelSetLayer;

@end
