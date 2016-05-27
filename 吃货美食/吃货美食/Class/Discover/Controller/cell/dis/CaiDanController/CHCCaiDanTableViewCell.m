//
//  CHCCaiDanTableViewCell.m
//  吃货美食
//
//  Created by eric on 16/5/15.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCCaiDanTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation CHCCaiDanTableViewCell
-(void)setData_list:(CHCData_list *)data_list
{
    _data_list=data_list;
    _CaiDanTitleLabel.text=data_list.title;
    if (data_list.recipe_num) {
        NSString * countLabelStr=data_list.recipe_num;
        NSString *Str=[NSString stringWithFormat:@"%@篇菜谱",countLabelStr];
     _CaiDABCountLabel.text=Str;
    }
    
    
    
    
    [_caDanImageViewOne sd_setImageWithURL:[NSURL URLWithString:data_list.photos[0]]];
    [_caiDanTwoImageView sd_setImageWithURL:[NSURL URLWithString:data_list.photos[1]]];
    [_caiDanThreeImageView sd_setImageWithURL:[NSURL URLWithString:data_list.photos[2]]];
    [_CaiDanFourImageView sd_setImageWithURL:[NSURL URLWithString:data_list.photos[3]]];
    [_buttomImageView sd_setImageWithURL:[NSURL URLWithString:data_list.user_info.avatar]];
    CGFloat W=(CHSCREENWIDTH-11*2-5*3)/4;
    _wedth.constant=W;
    _hight.constant=W;
    
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
