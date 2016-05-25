//
//  CHLocation.h
//  吃货美食
//
//  Created by scjy on 16/5/25.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHLocation : NSObject

@property (nonatomic,assign)CGFloat lat;
@property (nonatomic,assign)CGFloat lon;

+ (instancetype)shareLocation;

@end
