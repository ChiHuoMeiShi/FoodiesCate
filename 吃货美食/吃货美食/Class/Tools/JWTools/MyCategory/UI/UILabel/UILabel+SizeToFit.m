//
//  UILabel+SizeToFit.m
//  JW百思
//
//  Created by scjy on 16/3/23.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "UILabel+SizeToFit.h"

@implementation UILabel (SizeToFit)

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
+ (UILabel *)labelWithSizeToFit:(UILabel *)label withText:(NSString *)text withFontSize:(CGFloat)fontSize withLabelWith:(CGFloat)labelWidth{
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.text = text;
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)];
    if (labelWidth > [UIScreen mainScreen].bounds.size.width * 2 / 3) {
        labelWidth = [UIScreen mainScreen].bounds.size.width * 2 / 3;
    }
    label.frame =CGRectMake(label.frame.origin.x, label.frame.origin.y, labelWidth, size.height);
    label.font = [UIFont systemFontOfSize:fontSize];
    
    return label;
}

@end
