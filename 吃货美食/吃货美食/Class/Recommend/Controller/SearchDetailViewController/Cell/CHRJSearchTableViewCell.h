//
//  CHRJSearchTableViewCell.h
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
#import "CHRJSearchContentModel.h"
@interface CHRJSearchTableViewCell : UITableViewCell

@property (nonatomic,strong)CHRJSearchContentModel * searchModel;

@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (IBAction)selectLikeButtton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *hateButton;

@property (weak, nonatomic) IBOutlet UILabel *hardLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *firstStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *forthStarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fifthStarImageView;
@property (nonatomic,strong)NSArray * starImageViewArr;


@end
