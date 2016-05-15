//
//  CHNineChatCell.m
//  吃货美食
//
//  Created by 赵天 on 16/5/14.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHNineChatCell.h"

@implementation CHNineChatCell

- (void)setShowhottopic:(Hot_topocModel *)showhottopic
{
    if (showhottopic == nil) {
        return;
    }
    _showhottopic = showhottopic;
    [self.iconIamgeView sd_setImageWithURL:[NSURL URLWithString:showhottopic.user_info.avatar]];
    self.nameLabel.text = showhottopic.user_info.user_name;
    
    self.contentLabel.text = showhottopic.summary;
    
    self.timeLabel.text = showhottopic.time;
    
//    self.fromLabel.text = showhottopic.recipe_info.title;
    
    [self.dingBtn setTitle:showhottopic.ding_num forState:UIControlStateNormal];
    
    [self.commentBtn setTitle:showhottopic.comment_num forState:UIControlStateNormal];
    
    NSMutableArray *imageArr = showhottopic.imgs;
    ImgsModel *imgModel0 = imageArr[0];
    [self.oneImageView sd_setImageWithURL:[NSURL URLWithString:imgModel0.small]];
    ImgsModel *imgModel1 = imageArr[1];
    [self.twoImageView sd_setImageWithURL:[NSURL URLWithString:imgModel1.small]];
    ImgsModel *imgModel2 = imageArr[2];
    [self.threeImageView sd_setImageWithURL:[NSURL URLWithString:imgModel2.small]];
    ImgsModel *imgModel3 = imageArr[3];
    [self.fourImageView sd_setImageWithURL:[NSURL URLWithString:imgModel3.small]];
    ImgsModel *imgModel4 = imageArr[4];
    [self.fiveImageView sd_setImageWithURL:[NSURL URLWithString:imgModel4.small]];
    ImgsModel *imgModel5 = imageArr[5];
    [self.sixImageView sd_setImageWithURL:[NSURL URLWithString:imgModel5.small]];
    ImgsModel *imgModel6 = imageArr[6];
    [self.sevenImageView sd_setImageWithURL:[NSURL URLWithString:imgModel6.small]];
    ImgsModel *imgModel7 = imageArr[7];
    [self.eigthImageView sd_setImageWithURL:[NSURL URLWithString:imgModel7.small]];
    ImgsModel *imgModel8 = imageArr[8];
    [self.nineImageView sd_setImageWithURL:[NSURL URLWithString:imgModel8.small]];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setTopicList:(Topic_List *)topicList
{
    if (topicList == nil) {
        return;
    }
    _topicList = topicList;
    [self.iconIamgeView sd_setImageWithURL:[NSURL URLWithString:topicList.user_info.avatar]];
    self.nameLabel.text = topicList.user_info.user_name;
    
    self.contentLabel.text = topicList.summary;
    
    self.timeLabel.text = topicList.time;
    
//    self.fromLabel.text = topicList.recipe_info.title;
    
    [self.dingBtn setTitle:topicList.ding_num forState:UIControlStateNormal];
    
    [self.commentBtn setTitle:topicList.comment_num forState:UIControlStateNormal];
    
    NSMutableArray *imageArr = topicList.imgs;
    ImgsModel *imgModel0 = imageArr[0];
    [self.oneImageView sd_setImageWithURL:[NSURL URLWithString:imgModel0.small]];
    ImgsModel *imgModel1 = imageArr[1];
    [self.twoImageView sd_setImageWithURL:[NSURL URLWithString:imgModel1.small]];
    ImgsModel *imgModel2 = imageArr[2];
    [self.threeImageView sd_setImageWithURL:[NSURL URLWithString:imgModel2.small]];
    ImgsModel *imgModel3 = imageArr[3];
    [self.fourImageView sd_setImageWithURL:[NSURL URLWithString:imgModel3.small]];
    ImgsModel *imgModel4 = imageArr[4];
    [self.fiveImageView sd_setImageWithURL:[NSURL URLWithString:imgModel4.small]];
    ImgsModel *imgModel5 = imageArr[5];
    [self.sixImageView sd_setImageWithURL:[NSURL URLWithString:imgModel5.small]];
    ImgsModel *imgModel6 = imageArr[6];
    [self.sevenImageView sd_setImageWithURL:[NSURL URLWithString:imgModel6.small]];
    ImgsModel *imgModel7 = imageArr[7];
    [self.eigthImageView sd_setImageWithURL:[NSURL URLWithString:imgModel7.small]];
    ImgsModel *imgModel8 = imageArr[8];
    [self.nineImageView sd_setImageWithURL:[NSURL URLWithString:imgModel8.small]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
