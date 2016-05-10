//
//  CHJRecomdTodayModel.h
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHJRecommendJumpModel.h"
#import <MJExtension.h>
@interface CHJRecomdTodayModel : NSObject

@property (nonatomic,strong)NSNumber * myID;
@property (nonatomic,copy)NSString * f_s_type;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * descr;
@property (nonatomic,strong)NSNumber * tj_type;
@property (nonatomic,strong)NSNumber * type;
@property (nonatomic,copy)NSString * photo;
@property (nonatomic,strong)CHJRecommendJumpModel * jump;

@end
