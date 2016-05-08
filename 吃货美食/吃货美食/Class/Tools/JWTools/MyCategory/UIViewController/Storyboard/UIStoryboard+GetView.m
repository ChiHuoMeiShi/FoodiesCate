//
//  UIStoryboard+GetView.m
//  JW百思
//
//  Created by scjy on 16/3/23.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "UIStoryboard+GetView.h"

@implementation UIStoryboard (GetView)

/**
 *  利用storyboard来加载对应的VC
 *
 *  @param storyBoardName storyBoardName
 *  @param identifierName 加载VC的identifier
 *
 *  @return 获取的VC
 */
+ (UIViewController *)VCWithStoryBoardNmae:(NSString *)storyBoardName withIdentifierNmae:(NSString *)identifierName{
    
    UIStoryboard * storyBoard = [self storyboardWithName:storyBoardName bundle:nil];
    UIViewController * vc = [storyBoard instantiateViewControllerWithIdentifier:identifierName];
    return vc;
}


@end
