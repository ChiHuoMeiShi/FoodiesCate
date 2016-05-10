//
//  CHJRecomdFucFCollectionReusableView.h
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHJRecomdFucFCollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *foodTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *audioFoodButton;
@property (weak, nonatomic) IBOutlet UIButton *breasketFoodButton;
@property (weak, nonatomic) IBOutlet UIButton *aroundFoodButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *audioFoodBtnLeftEndge;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aroundFoodBtnRightEndge;

@property (weak, nonatomic) IBOutlet UIButton *listButton;

@property (weak, nonatomic) IBOutlet UIButton *composeButton;


@end
