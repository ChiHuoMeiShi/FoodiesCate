//
//  CHRPublicNextBaseFoodTableViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublicNextBaseFoodTableViewCell.h"

@implementation CHRPublicNextBaseFoodTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self setSelectedBackgroundView:bgColorView];
}

- (void)setTakephotoButton:(CHRImageButton *)takephotoButton{
    if (!takephotoButton)return;
    _takephotoButton = takephotoButton;
    if (_takephotoButton.myImagePath) {
        self.publishModel.photoPath = _takephotoButton.myImagePath;
    }
}



@end
