//
//  CHJRecommendMyLikeModel.h
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
@interface CHJRecommendMyLikeModel : NSObject<NSCoding>
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * time;
@property (nonatomic,copy)NSString * total;
@property (nonatomic,strong)NSArray * data;

@end
