//
//  CHJRTopBannerTittleModel.h
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

@interface CHJRTopBannerTittleModel : NSObject<NSCoding>
@property (nonatomic,copy)NSString * click_trackingURL;
@property (nonatomic,copy)NSString * sub_title;
@property (nonatomic,copy)NSString * titlepic;
@property (nonatomic,strong)NSNumber * click_type;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * pv_trackingURL;
@property (nonatomic,copy)NSString * click_obj;


@end
