//
//  CHRPublicNextHeaderTopView.m
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublicNextHeaderTopView.h"

@implementation CHRPublicNextHeaderTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showLabel = [[UILabel alloc]init];
        self.showLabel.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
    }
    return self;
}

- (void)layoutSubviews{
    self.showLabel.frame = CGRectMake(0.f, (self.frame.size.height - 21.f)/2, CHSCREENWIDTH - 20.f, 21.f);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
