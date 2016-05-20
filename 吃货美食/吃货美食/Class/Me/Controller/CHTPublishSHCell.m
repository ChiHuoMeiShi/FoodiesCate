//
//  CHTPublishSHCell.m
//  吃货美食
//
//  Created by 赵天 on 16/5/19.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHTPublishSHCell.h"
#import "SHData.h"
#import "SHImgs.h"
#import <UIImageView+WebCache.h>
@implementation CHTPublishSHCell

- (void)setShihuaModel:(ShiHuaModel *)shihuaModel
{
    if (shihuaModel == nil) {
        return;
    }
    
    _shihuaModel = shihuaModel;
    
    for (SHData *shData in shihuaModel.data) {
        
        self.summaryLabel.text = shData.summary;
        self.createLabel.text = shData.create_time;
    }
//    for (SHData *shData in shihuaModel.data) {
//        if (shData.imgs) {
//            SHImgs *imgs = [shData.imgs firstObject];
//            self.summaryLabel.text = shData.summary;
//            self.createLabel.text = shData.create_time;
//            [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgs.small]];
//        }
//    }
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
