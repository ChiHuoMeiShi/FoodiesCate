//
//  CHCShiCaiTableViewCell.m
//  吃货美食
//
//  Created by eric on 16/5/14.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCShiCaiTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "CHCSHiCaiObjData.h"
@implementation CHCShiCaiTableViewCell
-(void)setShicai:(CHCSHiCaiObjData *)shicai
{
    _shicai=shicai;
    _ShicaiNameLabel.text=shicai.title;
    [_ShiCaiImageView  sd_setImageWithURL:[NSURL URLWithString:shicai.myimage]];
    _SHicaiGongxiaoLeftLabel.text=shicai.gongxiao[0];
//    _ShicaiGongxiaoRightLabel.text=shicai.gongxiao[1];
    _SHICaiHotLAbel.text=shicai.heat_word;
    
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self setSelectedBackgroundView:bgColorView];
}

@end
