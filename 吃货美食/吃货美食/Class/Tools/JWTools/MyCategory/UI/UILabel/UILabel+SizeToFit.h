//
//  UILabel+SizeToFit.h
//  JW百思
//
//  Created by scjy on 16/3/23.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SizeToFit)

#pragma mark - UILabel
/**
 *  Label自适应行高
 *
 *  @param label      要修改的Label
 *  @param text       文本
 *  @param fontSize   字体大小
 *  @param labelWidth 文本宽度，最大为屏幕2/3宽
 *
 *  @return 自适应行高后的Label
 */
+ (UILabel *)labelWithSizeToFit:(UILabel *)label withText:(NSString *)text withFontSize:(CGFloat)fontSize withLabelWith:(CGFloat)labelWidth;

@end
