//
//  CHCShiCaiTableViewCell.h
//  吃货美食
//
//  Created by eric on 16/5/14.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHCSHiCaiObjData.h"

@interface CHCShiCaiTableViewCell : UITableViewCell
@property(nonatomic,strong)CHCSHiCaiObjData *shicai;
@property (weak, nonatomic) IBOutlet UIImageView *ShiCaiImageView;
@property (weak, nonatomic) IBOutlet UILabel *ShicaiNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *SHicaiGongxiaoLeftLabel;
//@property (weak, nonatomic) IBOutlet UILabel *ShicaiGongxiaoRightLabel;

@property (weak, nonatomic) IBOutlet UILabel *SHICaiHotLAbel;

-(void)setShicai:(CHCSHiCaiObjData *)shicai;
@end
