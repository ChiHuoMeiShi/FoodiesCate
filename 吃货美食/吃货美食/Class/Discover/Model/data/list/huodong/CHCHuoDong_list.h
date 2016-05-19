//
//  CHCHuoDong_list.h
//  吃货美食
//
//  Created by eric on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHCHuoDongimag_list.h"
@interface CHCHuoDong_list : NSObject
@property(nonatomic,strong)NSString *huodong_type;
@property(nonatomic,strong)NSString *huodong_id;
@property(nonatomic,strong)CHCHuoDongimag_list *img;
@end

