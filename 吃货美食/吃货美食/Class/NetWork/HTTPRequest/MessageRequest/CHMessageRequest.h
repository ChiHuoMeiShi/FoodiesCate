//
//  CHMessageRequest.h
//  吃货美食
//
//  Created by 赵天 on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHHTTPSessionManager.h"
@interface CHMessageRequest : CHHTTPSessionManager
- (void)messageGetRequestWithUrlPath:(NSString *)urlPath parameter:(NSDictionary *)param success:(void(^)(id responObject))success failure:(void(^)(NSError *error))failure;
@end
