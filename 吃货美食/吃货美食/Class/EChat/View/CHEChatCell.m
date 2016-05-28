//
//  CHEChatCell.m
//  吃货美食
//
//  Created by 赵天 on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHEChatCell.h"

@implementation CHEChatCell

- (void)setShowhottopic:(Hot_topocModel *)showhottopic
{
    if (showhottopic == nil) {
        return;
    }
    _showhottopic = showhottopic;
    NSMutableArray *imageArr = showhottopic.imgs;
    
    if (imageArr.count == 1) {
        ImgsModel *imgModel = imageArr[0];
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imgModel.small] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    //改变约束
                    self.imagesHeight.constant = 200.f;
                    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
                    imgView.frame = CGRectMake(0.f, 0.f, 150.f, 200.f);
                    [self.iamges addSubview:imgView];
                    imgView = nil;
                }];
        [self setNeedsLayout];
    }
    [self.iconIamgeView sd_setImageWithURL:[NSURL URLWithString:showhottopic.user_info.avatar]];
    
    self.nameLabel.text = showhottopic.user_info.user_name;
    
    self.contentLabel.text = showhottopic.summary;
    
    self.timeLabel.text = showhottopic.time;
    
//    self.fromLabel.text = showhottopic.recipe_info.title;
    
    [self.dingBtn setTitle:showhottopic.ding_num forState:UIControlStateNormal];
    
    [self.commentBtn setTitle:showhottopic.comment_num forState:UIControlStateNormal];

}
- (void)setTopicList:(Topic_List *)topicList
{
    if (topicList == nil) {
        return;
    }
    _topicList = topicList;
    NSMutableArray *imageArr = topicList.imgs;
    
    if (imageArr.count == 1) {
        ImgsModel *imgModel = imageArr[0];
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imgModel.small] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            //改变约束
            self.imagesHeight.constant = 200.f;
            UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
            imgView.frame = CGRectMake(0.f, 0.f, 150.f, 200.f);
            [self.iamges addSubview:imgView];
            imgView = nil;
        }];
        [self setNeedsLayout];
        
        [self.iconIamgeView sd_setImageWithURL:[NSURL URLWithString:topicList.user_info.avatar]];
        
        self.nameLabel.text = topicList.user_info.user_name;
        
        self.contentLabel.text = topicList.summary;
        
        self.timeLabel.text = topicList.time;
        
//        self.fromLabel.text = topicList.recipe_info.title;
        
        [self.dingBtn setTitle:topicList.ding_num forState:UIControlStateNormal];
        
        [self.commentBtn setTitle:topicList.comment_num forState:UIControlStateNormal];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self setSelectedBackgroundView:bgColorView];
}

@end
