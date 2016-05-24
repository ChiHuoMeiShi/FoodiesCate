//
//  CHRPublishNextViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"
#import "CHRTextView.h"
#import "CHRPublishSave.h"
#import "CHUserDefaults.h"
#import "CHRPublicNextFooterSaveView.h"
#import "CHRPublicNextFooterStoryView.h"
#import "CHRPublicNextFooterAddStepView.h"
#import "CHRPublicNextFooterAddBaseFoodView.h"
#import "CHRPublicNextHeaderTopView.h"
#import "CHRPublicNextHeaderDetailView.h"
#import "CHRPublicNextHeaderTittleView.h"
#import "CHRPublicNextHeaderAddStepView.h"

#import "CHRPublicNextBaseFoodTableViewCell.h"
#import "CHRPublicNextStepTableViewCell.h"
@interface CHRPublishNextViewController : CHRJBasicViewController<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong)NSDictionary * foodDataDic;
@property (nonatomic,copy)NSString * foodName;

@property (nonatomic,strong)NSMutableArray * mainFoodArray;
@property (nonatomic,strong)NSMutableArray * supFoodArray;
@property (nonatomic,strong)NSMutableArray * stepFoodArray;

@property (nonatomic,assign)BOOL stepIsEdit;
@property (nonatomic,strong)UIButton * editButton;

@property (nonatomic,strong)CHRTextView * storyTextView;
@property (nonatomic,strong)CHRTextView * shareTextView;


@property (nonatomic,strong)CHRPublicNextHeaderTopView * headerViewTop;
@property (nonatomic,strong)CHRPublicNextHeaderTittleView * headerViewSecond;
@property (nonatomic,strong)CHRPublicNextHeaderTittleView * headerViewTopThird;
@property (nonatomic,strong)CHRPublicNextHeaderAddStepView * headerViewTopForth;
@property (nonatomic,strong)CHRPublicNextHeaderDetailView * headerViewTopLast;

@property (nonatomic,strong)CHUserDefaults * userDefault;

@property (weak, nonatomic) IBOutlet UITableView *publicTableView;

- (instancetype)initWithFoodDic:(NSDictionary *)foodDic withFoodName:(NSString *)foodName;

@end
