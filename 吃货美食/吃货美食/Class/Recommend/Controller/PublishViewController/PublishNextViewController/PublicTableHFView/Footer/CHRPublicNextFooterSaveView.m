//
//  CHRPublicNextFooterSaveView.m
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublicNextFooterSaveView.h"

@implementation CHRPublicNextFooterSaveView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [self.saveButton.layer setBorderWidth:0.8f];
    [self.saveButton.layer setCornerRadius:5.f];
    [self.saveButton.layer setBorderColor:[UIColor redColor].CGColor];
}

@end
