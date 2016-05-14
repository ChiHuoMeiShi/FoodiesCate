//
//  CHRJSearchContentModel.h
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
@interface CHRJSearchContentModel : NSObject
@property (nonatomic,copy)NSString * myID;
@property (nonatomic,copy)NSString * gongyi;
@property (nonatomic,strong)NSNumber * is_video;
@property (nonatomic,copy)NSString * kouwei;
@property (nonatomic,strong)NSNumber * is_see;
@property (nonatomic,copy)NSString * titlepic;
@property (nonatomic,copy)NSString * smalltext;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * md;
@property (nonatomic,strong)NSNumber * is_recipe;
@property (nonatomic,strong)NSNumber * step;
@property (nonatomic,strong)NSNumber * item_type;
@property (nonatomic,strong)NSNumber * rate;
@property (nonatomic,strong)NSNumber * is_fav;
@property (nonatomic,strong)NSString * mt;


@end
