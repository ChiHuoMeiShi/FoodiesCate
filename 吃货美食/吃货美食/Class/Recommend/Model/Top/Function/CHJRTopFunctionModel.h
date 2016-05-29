//
//  CHJRTopFunctionModel.h
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
#import "CHJRecommendJumpModel.h"
@interface CHJRTopFunctionModel : NSObject<NSCoding>

@property (nonatomic,copy)NSString * click_obj;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,strong)NSNumber * click_type;
@property (nonatomic,copy)NSString * image;
@property (nonatomic,strong)CHJRecommendJumpModel * jump;

@end
