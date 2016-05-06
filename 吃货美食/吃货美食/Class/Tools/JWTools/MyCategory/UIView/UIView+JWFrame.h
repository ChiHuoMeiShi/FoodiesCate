//
//  UIView+JWFrame.h
//  JW百思
//
//  Created by scjy on 16/3/19.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JWFrame)
/**
 *  缩减x,y,width,height的获取代码量
 */
@property (nonatomic,assign)CGFloat x,y,width,height;
//类别只能扩充方法，此处为添加getter和setter方法
@property (nonatomic,assign)CGSize size;
@property (nonatomic,assign)CGPoint origin;
@property (nonatomic,assign)CGPoint centerPoint;

@end
