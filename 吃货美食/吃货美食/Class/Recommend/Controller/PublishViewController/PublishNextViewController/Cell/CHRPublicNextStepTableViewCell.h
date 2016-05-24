//
//  CHRPublicNextStepTableViewCell.h
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHRPublishFoodMainFoodModel.h"
@interface CHRPublicNextStepTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *showFoodLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showFoodLabelWidth;


@property (weak, nonatomic) IBOutlet UILabel *showCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showCountLabelWidth;

@property (nonatomic,strong)CHRPublishFoodMainFoodModel * foodModel;


@end
