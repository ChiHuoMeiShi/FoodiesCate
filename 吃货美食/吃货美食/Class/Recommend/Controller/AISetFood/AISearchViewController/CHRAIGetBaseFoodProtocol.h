//
//  CHRAIGetBaseFoodProtocol.h
//  吃货美食
//
//  Created by scjy on 16/5/19.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHAISearchFoodTableModel.h"
@protocol CHRAIGetBaseFoodProtocol <NSObject>

@optional
- (void)getBaseFood:(CHAISearchFoodTableModel *)baseFood;

- (void)getCellBaseFood:(CHAISearchFoodTableModel *)baseFood;

@end
