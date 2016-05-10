//
//  CHJRecomdSugstFCollectionReusableView.m
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHJRecomdSugstFCollectionReusableView.h"

@implementation CHJRecomdSugstFCollectionReusableView

- (void)awakeFromNib {
    [self.commitButton.layer setBorderWidth:0.8f];
    [self.commitButton.layer setCornerRadius:5.f];
    [self.commitButton.layer setBorderColor:[UIColor orangeColor].CGColor];
    
}

@end
