//
//  CHUserRequest.m
//  吃货美食
//
//  Created by 赵天 on 16/5/17.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHUserRequest.h"

@implementation CHUserRequest
- (void)loginPostRequestWithUrlPath:(NSString *)urlPath parameter:(NSDictionary *)param success:(void(^)(id responObject))success failure:(void(^)(NSError *error))failure{
    [self POST:urlPath parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
@end
