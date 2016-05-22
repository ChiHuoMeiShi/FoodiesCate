//
//  CHRPublishNextViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"
#import "CHRTextView.h"
#import "CHRPublicNextFooterSaveView.h"
#import "CHRPublicNextFooterStoryView.h"
#import "CHRPublicNextFooterAddStepView.h"
#import "CHRPublicNextFooterAddBaseFoodView.h"
#import "CHRPublicNextHeaderTopView.h"
#import "CHRPublicNextHeaderDetailView.h"
#import "CHRPublicNextHeaderTittleView.h"
#import "CHRPublicNextHeaderAddStepView.h"

#import "CHRPublicNextBaseFoodTableViewCell.h"
@interface CHRPublishNextViewController : CHRJBasicViewController

@property (nonatomic,strong)NSDictionary * foodDataDic;
@property (nonatomic,copy)NSString * foodName;

- (instancetype)initWithFoodDic:(NSDictionary *)foodDic withFoodName:(NSString *)foodName;

@end
