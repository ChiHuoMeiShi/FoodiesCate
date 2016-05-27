//
//  CHRCommitCollectionViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/26.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRCommitCollectionViewCell.h"

@implementation CHRCommitCollectionViewCell

- (void)awakeFromNib {
    [self.selectButton.layer setBorderWidth:0.8f];
    [self.selectButton.layer setCornerRadius:5.f];
    [self.selectButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.selectButton addTarget:self action:@selector(showIMG) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showIMG{
    self.btnIsSelect = !self.btnIsSelect;
    self.showImageView.hidden = self.btnIsSelect;
}

@end
