//
//  CHCArticalCell.m
//  吃货美食
//
//  Created by eric on 16/5/12.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCArticalCell.h"
#import <UIImageView+WebCache.h>
@implementation CHCArticalCell
-(void)setFaxian_list:(CHCfaxian_list *)faxian_list
{
    _faxian_list=faxian_list;
    _titleLabel.text=faxian_list.title;
    _tagLabel.text=faxian_list.tag;
    _artTitleLabel.text=faxian_list.article_info.title;
    [_titlepicImageVIew sd_setImageWithURL:[NSURL URLWithString:faxian_list.article_info.titlepic]];
    _samlltextLabel.text=faxian_list.article_info.smalltext;
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
