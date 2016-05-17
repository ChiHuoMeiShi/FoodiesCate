//
//  CHHTTPRequestManager.h
//  吃货美食
//
//  Created by 赵天 on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHUserRequest.h"
#import "CHMessageRequest.h"
@interface CHHTTPRequestManager : NSObject
@property (nonatomic, strong) CHMessageRequest *messageRequest;

@property (nonatomic, strong) CHUserRequest *userRequest;

+ (id)manager;
@end
