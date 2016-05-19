//
//  CHRAIFoodCollectionViewCell.h
//  吃货美食
//
//  Created by scjy on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
#import "CHAISearchFoodTableModel.h"

@interface CHRAIFoodCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)CHAISearchFoodTableModel * foodModel;
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

- (IBAction)deleButtonAction:(UIButton *)sender;

@end
