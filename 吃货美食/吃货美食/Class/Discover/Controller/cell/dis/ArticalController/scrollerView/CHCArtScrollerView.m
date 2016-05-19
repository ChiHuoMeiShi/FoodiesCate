//
//  CHCArtScrollerView.m
//  吃货美食
//
//  Created by eric on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCArtScrollerView.h"

@implementation CHCArtScrollerView
+(id)addScrollView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"CHCArtScrollerView" owner:nil options:nil] lastObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
