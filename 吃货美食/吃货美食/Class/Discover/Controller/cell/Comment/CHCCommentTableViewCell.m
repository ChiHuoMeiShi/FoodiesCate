//
//  CHCCommentTableViewCell.m
//  吃货美食
//
//  Created by eric on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCCommentTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation CHCCommentTableViewCell
-(void)setFaxian_list:(CHCfaxian_list *)faxian_list;
{
    _faxian_list=faxian_list;
    if ( [faxian_list
          .type isEqualToString:@"2"] ) {
        _titleLabel.text=faxian_list.title;
        _CommentLabel.text=faxian_list.tag;
        [_CommentImageView sd_setImageWithURL:[NSURL URLWithString:faxian_list.shicai_info.image]];
        _commentMwatLabel.text=faxian_list.shicai_info.title;
        
        _CommentXiaoHuaLabel.text=faxian_list.shicai_info.gongxiao[0];
        _commentHotLabel.text=faxian_list.shicai_info.heat_word;

    }

    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
