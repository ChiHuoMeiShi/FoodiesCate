//
//  CHJRecomdJumpContentModel.h
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
@interface CHJRecomdJumpContentModel : NSObject<NSCoding>
@property (nonatomic,strong)NSNumber * recipeId;
@property (nonatomic,copy)NSString * urlString;

@end
