//
//  CHCActivityTableViewCell.m
//  吃货美食
//
//  Created by eric on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCActivityTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation CHCActivityTableViewCell

-(void)setFaxian_list:(CHCfaxian_list *)faxian_list
{
    _faxian_list=faxian_list;
    _titleLabel.text=faxian_list.title;
    _tagLabel.text=faxian_list.tag;
    [_ActivityimageView sd_setImageWithURL:[NSURL URLWithString:faxian_list.huodong.img.small] ];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
