//
//  UITabBarItem+TextCustom.h
//  JW百思
//
//  Created by scjy on 16/3/23.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (TextCustom)


#pragma mark - UITabBarItem
/**
 *  UITabBarViewController文字取消渲染&自定义
 *
 *  @param attributes 文字设置，如@{NSFontAttributeName:[UIFont systemFontOfSize:13.f],NSForegroundColorAttributeName:[UIColor blackColor]}
 *  @param state      设置显示状态，一般为Normal
 *
 *  @return 返回自定义的tabBarItem，UITabBarViewController需要将返回值赋予tabBarItem即tabBarViewController.tabBarItem = 返回值
 */
+ (UITabBarItem *)tabBarItemWithAttributes:(NSDictionary<NSString *,id> *)attributes withState:(UIControlState)state;


/**
 *  TabBarItem设置
 *
 *  @param tabBarItem        要设置的TabBarItem
 *  @param tittle            tittle
 *  @param imageName         图片名
 *  @param selectedImageName 选中图片名
 *
 *  @return 设置完的UITabBarItem
 */

+ (BOOL)setTabBarItem:(UITabBarItem *)tabBarItem withTittle:(NSString *)tittle withImageName:(NSString *)imageName withSelectedImageName:(NSString *)selectedImageName;


@end
