//
//  CHNameViewCell.m
//  吃货美食
//
//  Created by 赵天 on 16/5/25.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHNameViewCell.h"

@implementation CHNameViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self setSelectedBackgroundView:bgColorView];
}

@end
