//
//  CHCZhuanTiTableViewCell.m
//  吃货美食
//
//  Created by eric on 16/5/15.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCZhuanTiTableViewCell.h"
#include <UIImageView+WebCache.h>
@implementation CHCZhuanTiTableViewCell
-(void)setZhuanTiData_list:(CHCZhuanTiData_list *)zhuanTiData_list
{
   _zhuanTiData_list=zhuanTiData_list;
    [_ZhuanTiImage sd_setImageWithURL:[NSURL URLWithString:zhuanTiData_list.photo]];
    _buttonLabel.text=zhuanTiData_list.title;
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:zhuanTiData_list.user_info.avatar]];
    _lastLabel.text=zhuanTiData_list.user_info.user_name;
    _LabelWidth.constant=CHSCREENWIDTH *260/414;
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
