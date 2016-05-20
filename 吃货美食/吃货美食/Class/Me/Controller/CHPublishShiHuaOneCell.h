//
//  CHPublishShiHuaOneCell.h
//  吃货美食
//
//  Created by 赵天 on 16/5/20.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShiHuaModel.h"
#import "SHData.h"
@interface CHPublishShiHuaOneCell : UITableViewCell

@property (nonatomic,strong) ShiHuaModel * shihuaModel;

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *createLabel;

@end
