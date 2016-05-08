//
//  UIBarButtonItem+SettingCustom.m
//  JW百思
//
//  Created by scjy on 16/3/23.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "UIBarButtonItem+SettingCustom.h"

@implementation UIBarButtonItem (SettingCustom)

#pragma mark - UIBarButtonItemSetting

/**
 *  设置UIBarButtonItem（只有图片）
 *
 *  @param imageName   imageName
 *  @param selectImage selectImage
 *  @param alignment   控件水平方向靠拢模式
 *  @param target       UIBarButtonItem添加点击事件
 *  @param action       UIBarButtonItem添加点击事件
 *  @param controlEvent UIBarButtonItem添加点击事件9
 *
 *  @return 自定义的barButtonItem
 */
+ (UIBarButtonItem *)barItemWithImageName:(NSString *)imageName withSelectImage:(NSString *)selectImage withHorizontalAlignment:(UIControlContentHorizontalAlignment)alignment withTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvent{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (imageName) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (selectImage) {
        [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    }
    
    btn.frame = CGRectMake(0.f, 0.f, 20.f, 30.f);
    
    btn.contentHorizontalAlignment = alignment;
    
    [btn addTarget:target action:action forControlEvents:controlEvent];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

/**
 *  设置UIBarButtonItem（图片&文字）
 *
 *  @param imageName   imageName
 *  @param selectImage selectImage
 *  @param alignment   控件水平方向靠拢模式
 *  @param itemTittle   item文本
 *  @param tittleColor  item文字颜色
 *  @param target       UIBarButtonItem添加点击事件
 *  @param action       UIBarButtonItem添加点击事件
 *  @param controlEvent UIBarButtonItem添加点击事件9
 *
 *  @return 自定义的barButtonItem
 */
+ (UIBarButtonItem *)barItemWithImageName:(NSString *)imageName withSelectImage:(NSString *)selectImage withHorizontalAlignment:(UIControlContentHorizontalAlignment)alignment withTittle:(NSString *)itemTittle withTittleColor:(UIColor *)tittleColor withTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvent{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (imageName) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (selectImage) {
        [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    }
    [btn setTitle:itemTittle forState:UIControlStateNormal];
    [btn setTitleColor:tittleColor forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(0.f, 0.f, 60.f, 30.f);
    
    btn.contentHorizontalAlignment = alignment;
    
    [btn addTarget:target action:action forControlEvents:controlEvent];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [item setBarItemWithColor:tittleColor];
    
    return item;
}


#pragma mark - PropertySetting
/**
 *  修改UIBarButtonItem文字颜色
 *
 *  @param color 文本颜色
 *
 *  @return 修改是否成功
 */
- (BOOL)setBarItemWithColor:(UIColor *)color{
    NSDictionary * attributes = @{NSForegroundColorAttributeName:color};
    [self setTitleTextAttributes:attributes forState:UIControlStateNormal];
    return YES;
}


@end
