//
//  CHCaiDanCell.m
//  吃货美食
//
//  Created by eric on 16/5/12.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCaiDanCell.h"
#import <UIImageView+WebCache.h>
@implementation CHCaiDanCell
-(void)setFaxian_list:(CHCfaxian_list *)faxian_list
{
    _faxian_list=faxian_list;
    _titleLabel.text=faxian_list.title;
    _tagLabel.text=faxian_list.tag;
    [_oneImageVIew sd_setImageWithURL:[NSURL URLWithString:faxian_list.caidan_info.photos[0]]];
    [_twoImageVIew sd_setImageWithURL:[NSURL URLWithString:faxian_list.caidan_info.photos[1]]];

    [_threeImageVIew sd_setImageWithURL:[NSURL URLWithString:faxian_list.caidan_info.photos[2]]];

    CGFloat W= (CHSCREENWIDTH - 4*11.f)/3;
   _imageWidth.constant=W;
    _imagehight.constant=W;
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
