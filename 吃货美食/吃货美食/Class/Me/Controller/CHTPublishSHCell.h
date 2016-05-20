//
//  CHTPublishSHCell.h
//  吃货美食
//
//  Created by 赵天 on 16/5/19.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShiHuaModel.h"
@interface CHTPublishSHCell : UITableViewCell

@property (nonatomic,strong) ShiHuaModel * shihuaModel;

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *createLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWidth;

@end
