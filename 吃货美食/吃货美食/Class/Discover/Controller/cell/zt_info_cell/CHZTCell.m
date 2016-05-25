//
//  CHZTCell.m
//  吃货美食
//
//  Created by eric on 16/5/12.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHZTCell.h"
#import <UIImageView+WebCache.h>
@implementation CHZTCell
-(void)setFaxian_list:(CHCfaxian_list *)faxian_list
{
    _faxian_list=faxian_list;
    _titleLabel.text=faxian_list.title;
    _tagLanel.text=faxian_list.tag;
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:faxian_list.zt_info.photo]];
    _use_nameLabel.text=faxian_list.zt_info.user_info.user_name;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self setSelectedBackgroundView:bgColorView];
}

@end
