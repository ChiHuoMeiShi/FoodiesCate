//
//  CHRPublicNextFooterAddStepView.m
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublicNextFooterAddStepView.h"

@implementation CHRPublicNextFooterAddStepView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [self.editButton.layer setBorderWidth:0.8f];
    [self.editButton.layer setCornerRadius:5.f];
    [self.editButton.layer setBorderColor:[UIColor redColor].CGColor];
    [self.addButton.layer setBorderWidth:0.8f];
    [self.addButton.layer setCornerRadius:5.f];
    [self.addButton.layer setBorderColor:[UIColor redColor].CGColor];
    
}


@end
