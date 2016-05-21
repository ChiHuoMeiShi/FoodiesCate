
//
//  CHRPublicChooseTypeProtocol.h
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CHRPublicChooseTypeProtocol <NSObject>

- (void)choosedFoodDic:(NSDictionary *)dic withName:(NSString *)tittleName;

@end
