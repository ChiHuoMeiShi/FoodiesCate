//
//  CHCCaiDanTableViewCell.h
//  吃货美食
//
//  Created by eric on 16/5/15.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHCData_list.h"
@interface CHCCaiDanTableViewCell : UITableViewCell
@property(nonatomic,strong)CHCData_list *data_list;
-(void)setData_list:(CHCData_list *)data_list;
@property (weak, nonatomic) IBOutlet UILabel *CaiDanTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *CaiDABCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *caDanImageViewOne;
@property (weak, nonatomic) IBOutlet UIImageView *caiDanTwoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *caiDanThreeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *CaiDanFourImageView;
@property (weak, nonatomic) IBOutlet UIImageView *buttomImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wedth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hight;

@end
