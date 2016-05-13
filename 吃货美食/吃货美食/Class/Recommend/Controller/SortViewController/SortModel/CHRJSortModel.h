//
//  CHRJSortModel.h
//  吃货美食
//
//  Created by scjy on 16/5/12.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

#import "CHRJSortContentModel.h"
@interface CHRJSortModel : NSObject
@property (nonatomic,copy)NSString * urlName;
@property (nonatomic,copy)NSString * imageName;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,strong)NSMutableArray * listArr;

@end
