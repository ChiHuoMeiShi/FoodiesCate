//
//  CHPublishShiHuaOneCell.m
//  吃货美食
//
//  Created by 赵天 on 16/5/20.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHPublishShiHuaOneCell.h"

@implementation CHPublishShiHuaOneCell

- (void)setShihuaModel:(ShiHuaModel *)shihuaModel
{
    if (shihuaModel == nil) {
        return;
    }
    
    for (SHData *shData in shihuaModel.data) {
        
        self.summaryLabel.text = shData.summary;
        self.createLabel.text = shData.create_time;
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
