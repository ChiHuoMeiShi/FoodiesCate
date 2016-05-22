//
//  CHRImageButton.m
//  吃货美食
//
//  Created by scjy on 16/5/22.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRImageButton.h"

@implementation CHRImageButton
- (NSString *)myImagePath{
    if (!_myImagePath) {
        _myImagePath = @"";
    }
    return _myImagePath;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
