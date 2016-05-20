//
//  CHCArticalTableViewCell.m
//  吃货美食
//
//  Created by eric on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCArticalTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation CHCArticalTableViewCell
-(void)setTableVIewData_list:(CHCTableVIewData_list *)TableVIewData_list
{
    _TableVIewData_list=TableVIewData_list;
    [_tabelViewimageView sd_setImageWithURL:[NSURL URLWithString:TableVIewData_list.titlepic]];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
