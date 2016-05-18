//
//  CHRJListFoodCollectionProtocal.h
//  吃货美食
//
//  Created by scjy on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol CHRJListFoodCollectionProtocal <NSObject>

- (void)getShowWebID:(NSNumber *)myID;
- (void)getShowSearchName:(NSString *)searchName;

@end
