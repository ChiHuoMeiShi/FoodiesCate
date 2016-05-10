//
//  CHJRecomdFucFCollectionReusableView.m
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHJRecomdFucFCollectionReusableView.h"

@implementation CHJRecomdFucFCollectionReusableView

- (void)awakeFromNib {
    CGFloat endge = (self.aroundFoodButton.x - CGRectGetMaxX(self.foodTypeButton.frame) - self.audioFoodButton.width * 2)/2;
    CHLog(@"%f",CGRectGetMaxX(self.foodTypeButton.frame));
    self.audioFoodBtnLeftEndge.constant = endge;
    self.aroundFoodBtnRightEndge.constant = endge;
    [self setNeedsLayout];
}

@end
