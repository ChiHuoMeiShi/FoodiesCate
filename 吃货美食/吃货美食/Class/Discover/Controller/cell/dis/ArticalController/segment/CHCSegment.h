//
//  CHCSegment.h
//  吃货美食
//
//  Created by eric on 16/5/16.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SegmentBlock)(NSInteger a);

@interface CHCSegment : UIControl
@property (nonatomic,copy)SegmentBlock mycountBlock;
@property (nonatomic,assign)CGFloat perWidth;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,strong)CALayer *segmentLayer;
@property (nonatomic,strong)NSArray *items;
@property (nonatomic,strong)UIColor *underLayerBackgroudColor;
//自身背景颜色
@property(nonatomic, strong)UIColor *segmentBgColor;

//选中每块标签的字体颜色
@property(nonatomic, strong)UIColor *perColor;

//默认每块标签的字体颜色
@property(nonatomic, strong)UIColor *defaultPerColor;

- (instancetype)initWithFrame:(CGRect)frame withItems:(NSArray *)items;
@end
