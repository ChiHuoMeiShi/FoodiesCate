//
//  CHCFindData.h
//  吃货美食
//
//  Created by eric on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
#import "CHCfaxian_list.h"
@interface CHCFindData : NSObject
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *faxian_region;
@property(nonatomic,strong)NSMutableArray*faxian_list;

@end
