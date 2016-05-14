//
//  CHRJSortTableViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/12.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJSortTableViewCell.h"

@implementation CHRJSortTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    [self setSelectedBackgroundView:bgColorView];
}

@end
