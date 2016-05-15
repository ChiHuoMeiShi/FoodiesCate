//
//  CHJRecomdFucFCollectionReusableView.h
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <UIImageView+WebCache.h>
#import "CHJRTopFunctionModel.h"
#import "CHJRTopListFunctModel.h"
#import "CHRJSortViewController.h"
#import "CHRJSearchDetailViewController.h"
#import "CHRJSortModel.h"

typedef void (^topFunChooseView)(UIViewController *);
@interface CHJRecomdFucFCollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *foodTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *audioFoodButton;
@property (weak, nonatomic) IBOutlet UIButton *breasketFoodButton;
@property (weak, nonatomic) IBOutlet UIButton *aroundFoodButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *audioFoodBtnLeftEndge;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aroundFoodBtnRightEndge;

@property (weak, nonatomic) IBOutlet UIButton *listButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listButtonWidth;

@property (weak, nonatomic) IBOutlet UIButton *composeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *composeButtonWIdth;


@property (nonatomic,strong)NSArray * functionArr;
@property (nonatomic,strong)CHJRTopListFunctModel * list;
@property (nonatomic,strong)CHJRTopListFunctModel * compose;
@property (nonatomic,copy)topFunChooseView topFunChoosePush;

- (void)buttonSettingFun;

@end
