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
    CGFloat endge = (CHSCREENWIDTH - 2 * CGRectGetMaxX(self.foodTypeButton.frame) - self.audioFoodButton.width * 2 - 20.f)/3;
    self.audioFoodBtnLeftEndge.constant = endge;
    self.aroundFoodBtnRightEndge.constant = endge;
    
    CGFloat width = (CHSCREENWIDTH - 30.f)/2;
    self.listButtonWidth.constant = width;
    self.composeButtonWIdth.constant = width;
    [self setNeedsLayout];
}

- (void)setList:(CHJRTopListFunctModel *)list{
    if (!list)return;
    _list = list;
    [self button:self.composeButton wtihAction:@selector(composeButtonAction) withCount:0 withURL:[NSURL URLWithString:list.image]];
}
- (void)setCompose:(CHJRTopListFunctModel *)compose{
    if (!compose)return;
    _compose = compose;
    [self button:self.listButton wtihAction:@selector(listButtonAction) withCount:0 withURL:[NSURL URLWithString:compose.image]];
}

- (void)buttonSettingFun{
    [self button:self.foodTypeButton wtihAction:@selector(foodTypeButtonAction) withCount:0 withURL:nil];
    [self button:self.audioFoodButton wtihAction:@selector(audioFoodButtonAction) withCount:1 withURL:nil];
    [self button:self.breasketFoodButton wtihAction:@selector(breasketFoodButtonAction) withCount:2 withURL:nil];
    [self button:self.aroundFoodButton wtihAction:@selector(aroundFoodButtonAction) withCount:3 withURL:nil];
}

- (void)button:(UIButton *)btn wtihAction:(SEL)action withCount:(NSInteger)count withURL:(NSURL *)url{
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    if (!url) {
        CHJRTopFunctionModel * model = self.functionArr[count];
        url = [NSURL URLWithString:model.image];
    }
    __weak typeof(btn)setBtn = btn;
    [[SDWebImageManager sharedManager] downloadImageWithURL:url options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (image) {
            [setBtn setBackgroundImage:image forState:UIControlStateNormal];
        }
    }];
}

#pragma mark - ButtonAction
- (void)foodTypeButtonAction{
    self.topFunChoosePush([[CHRJSortViewController alloc]init]);
}
- (void)audioFoodButtonAction{
    self.topFunChoosePush([[CHRJSearchDetailViewController alloc]initWithIsVideo:YES]);
}
- (void)breasketFoodButtonAction{
    NSString * sortDataArrPath = [[NSBundle mainBundle]pathForResource:@"CHRFenLei" ofType:@"plist"];
    NSMutableArray * sortDataArr = [CHRJSortModel mj_objectArrayWithFile:sortDataArrPath];
    CHRJSortModel * sortDataModel = sortDataArr[1];
    self.topFunChoosePush([[CHRJSearchDetailViewController alloc]initWithChoosedTypeArr:sortDataModel.listArr withChoosedListCount:0 withSearchName:@"早餐"]);
}
- (void)aroundFoodButtonAction{
    self.topFunChoosePush([[CHRJSearchDetailViewController alloc]initWithIsLocal:YES]);
}
- (void)listButtonAction{
    self.topFunChoosePush([[CHRJListViewController alloc]init]);
}
- (void)composeButtonAction{
    self.topFunChoosePush([[CHRJAIFoodViewController alloc]init]);
}

@end
