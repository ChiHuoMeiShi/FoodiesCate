//
//  CHRJListFoodTableViewCell.h
//  吃货美食
//
//  Created by scjy on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
#import "CHRJSearchContentModel.h"
//Protorol
@interface CHRJListFoodTableViewCell : UITableViewCell
@property (nonatomic,assign)BOOL isLocal;
@property (nonatomic,strong)CHRJSearchContentModel * searchModel;

@property (weak, nonatomic) IBOutlet UIImageView *firstStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *forthStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fifthStarImageView;
@property (nonatomic,strong)NSArray * starImageViewArr;

@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *hardLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderLabel;

@end
