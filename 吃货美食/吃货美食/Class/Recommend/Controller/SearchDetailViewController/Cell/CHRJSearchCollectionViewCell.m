//
//  CHRJSearchCollectionViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/14.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJSearchCollectionViewCell.h"

@implementation CHRJSearchCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    UIView *bgColorView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.width, self.height)];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self setSelectedBackgroundView:bgColorView];
}

- (void)setSelectedBackgroundView:(UIView *)selectedBackgroundView{
    [super setSelectedBackgroundView:selectedBackgroundView];
    UIView * addBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0.f, selectedBackgroundView.height - 5.f, selectedBackgroundView.width, 5.f)];
    
    addBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#ff4c39"];
    [selectedBackgroundView addSubview:addBackgroundView];
}

@end
