//
//  CHCSegment.m
//  吃货美食
//
//  Created by eric on 16/5/16.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCSegment.h"
#import "UIView+JWFrame.h"
@implementation CHCSegment
- (instancetype)initWithFrame:(CGRect)frame withItems:(NSArray *)items{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.perWidth = (self.width)/ 4;
        
        _items = items;
        
        
    }
    return self;
}
#pragma mark-设置背景
- (CALayer *)segmentLayer{
    if (!_segmentLayer) {
        _segmentLayer = [CALayer layer];
        _segmentLayer.backgroundColor = self.underLayerBackgroudColor.CGColor;
        [self.layer addSublayer:_segmentLayer];
    }
    
    return _segmentLayer;
}

- (void)setIndex:(NSInteger)index{
    
    _index = index;
    self.segmentLayer.frame = CGRectMake(self.perWidth * self.index, self.width, self.perWidth, 0);
    //每次重置标签索引，必须重新画线
    [self setNeedsDisplay];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
  
        self.index = point.x / self.perWidth;
    
    self.mycountBlock(self.index);
  }
#pragma mark-设置文字的属性
- (void)drawRect:(CGRect)rect {
    [self.segmentBgColor set];

    
    
    UIRectFill(rect);
    
    [self.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGRect rect = CGRectMake(idx * self.perWidth, 5, self.perWidth, self.frame.size.height);
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        
        
        NSDictionary *attributes =
      @{NSFontAttributeName:idx ==
        self.index?[UIFont systemFontOfSize:18]:[UIFont systemFontOfSize:18 ],NSForegroundColorAttributeName:idx == self.index?self.perColor:self.defaultPerColor,NSParagraphStyleAttributeName:style};
        [obj drawInRect:rect withAttributes:attributes];
    }];
    
}



@end
