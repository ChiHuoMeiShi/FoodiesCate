//
//  CHVGoods_infoTableViewCell.m
//  吃货美食
//
//  Created by eric on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHVGoods_infoTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation CHVGoods_infoTableViewCell
-(void)setFaxian_list:(CHCfaxian_list *)faxian_list
{
    if ([faxian_list.type isEqualToString:@"4"]) {
        _faxian_list=faxian_list;
        _tagLabel.text=faxian_list.tag;
        _titleLabel.text=faxian_list.title;
        [_goodImageView sd_setImageWithURL:[NSURL URLWithString:faxian_list.goods_info.image]];
        _imageTitleLabel.text=faxian_list.goods_info.title;
    }
    
    
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
