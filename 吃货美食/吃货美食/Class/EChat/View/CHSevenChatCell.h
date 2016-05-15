//
//  CHSevenChatCell.h
//  吃货美食
//
//  Created by 赵天 on 16/5/14.
//  Copyright © 2016年 赵天. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "EChatModel.h"
#import "Hot_topocModel.h"
#import <UIImageView+WebCache.h>
#import "ImgsModel.h"
#import <UIKit/UIKit.h>
#import "Topic_List.h"
@interface CHSevenChatCell : UITableViewCell
@property (nonatomic,strong) Hot_topocModel * showhottopic;
@property (nonatomic,strong) Topic_List * topicList;
@property (weak, nonatomic) IBOutlet UIImageView *iconIamgeView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fourImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fiveImageView;

@property (weak, nonatomic) IBOutlet UIImageView *sixImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sevenImageView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *fromLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingBtn;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@end
