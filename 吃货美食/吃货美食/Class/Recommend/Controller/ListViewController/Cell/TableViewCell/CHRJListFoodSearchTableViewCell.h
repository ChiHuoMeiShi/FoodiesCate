//
//  CHRJListFoodSearchTableViewCell.h
//  吃货美食
//
//  Created by scjy on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHRJListSearchFoodModel.h"
#import "CHRJListFoodTableProtocal.h"
@interface CHRJListFoodSearchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distenceLabel;
@property (nonatomic,strong)CHRJListSearchFoodModel * searchModel;

- (IBAction)chooseButtonAction:(UIButton *)sender;


@property (nonatomic,assign)BOOL isChoosed;
@property (nonatomic,weak)id<CHRJListFoodTableProtocal> delegate;

@end
