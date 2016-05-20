//
//  CHRJAICreateCollectionViewCell.h
//  吃货美食
//
//  Created by scjy on 16/5/20.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHRJAICreateFoodModel.h"
#import <UIImageView+WebCache.h>
@interface CHRJAICreateCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)CHRJAICreateFoodModel * aiCreateFoodModel;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@property (weak, nonatomic) IBOutlet UILabel *showCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showCountLabelWidth;



@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstImageViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondImageViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdImageViewWidth;



@end
