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
    CGFloat endge = (CHSCREENWIDTH - 2 * CGRectGetMaxX(self.foodTypeButton.frame) - self.audioFoodButton.width * 2)/3;
    self.audioFoodBtnLeftEndge.constant = endge;
    self.aroundFoodBtnRightEndge.constant = endge;
    
    CGFloat width = (CHSCREENWIDTH - 3 * 15.f)/2;
    self.listButtonWidth.constant = width;
    self.composeButtonWIdth.constant = width;
    
    [self setNeedsLayout];
}

@end
