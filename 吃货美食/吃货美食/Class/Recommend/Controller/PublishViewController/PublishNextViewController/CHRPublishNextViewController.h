//
//  CHRPublishNextViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"
#import "CHRTextView.h"

@interface CHRPublishNextViewController : CHRJBasicViewController


@property (weak, nonatomic) IBOutlet CHRTextView *showTextView;


@property (nonatomic,strong)NSDictionary * foodDataDic;
@property (nonatomic,copy)NSString * foodName;


- (instancetype)initWithFoodDic:(NSDictionary *)foodDic withFoodName:(NSString *)foodName;

@end
