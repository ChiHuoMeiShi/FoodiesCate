//
//  CHJRecommendJumpModel.h
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHJRecomdJumpContentModel.h"
#import <MJExtension.h>
@interface CHJRecommendJumpModel : NSObject
@property (nonatomic,strong)NSNumber * type;
@property (nonatomic,copy)NSString * class_name;
@property (nonatomic,strong)CHJRecomdJumpContentModel * property;
@end
