//
//  CHTopInfoCell.m
//  吃货美食
//
//  Created by eric on 16/5/12.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHTopInfoCell.h"
#import <UIImageView+WebCache.h>
#import "CHCimages_list.h"

@implementation CHTopInfoCell
-(void)setFaxian_list:(CHCfaxian_list *)faxian_list
{
    _faxian_list=faxian_list;
    _titleLabel.text=faxian_list.title;
    _tagLabel.text=faxian_list.tag;
    [_avatarImageVIew sd_setImageWithURL:[NSURL URLWithString:faxian_list.topic_info.user_info.avatar]];
    _use_namelabe.text=faxian_list.topic_info.user_info.user_name;
    _summaryLabel.text=faxian_list.topic_info.summary;
    for (CHCimages_list *model in faxian_list.topic_info.imgs) {
        [_smallImageVIew sd_setImageWithURL:[NSURL URLWithString:model.small]];
    }
    
    
    
    [_bagImagView sd_setImageWithURL:[NSURL URLWithString:((CHCimages_list *)faxian_list.topic_info.imgs[1]).big]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self setSelectedBackgroundView:bgColorView];}

@end
