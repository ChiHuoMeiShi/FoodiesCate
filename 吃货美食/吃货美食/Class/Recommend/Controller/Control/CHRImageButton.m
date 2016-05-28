//
//  CHRImageButton.m
//  吃货美食
//
//  Created by scjy on 16/5/22.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRImageButton.h"

@implementation CHRImageButton

- (void)setMyImagePath:(NSString *)myImagePath{
    if (!myImagePath)return;
    _myImagePath = myImagePath;
    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    UIImage * photoIMG = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",docs[0],myImagePath]];
    [self setBackgroundImage:photoIMG forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
