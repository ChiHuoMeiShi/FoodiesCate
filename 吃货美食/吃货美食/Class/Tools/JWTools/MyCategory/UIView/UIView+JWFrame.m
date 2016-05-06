//
//  UIView+JWFrame.m
//  JW百思
//
//  Created by scjy on 16/3/19.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "UIView+JWFrame.h"

@implementation UIView (JWFrame)


- (CGFloat)x{
    return self.origin.x;
}

- (CGFloat)y{
    return self.origin.y;
}

- (CGFloat)width{
    return self.size.width;
}

- (CGFloat)height{
    return self.size.height;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (CGSize)size{
    return self.frame.size;
}

- (CGPoint)centerPoint{
    return (CGPoint){self.x + self.width/2, self.y + self.height/2};
}

- (void)setX:(CGFloat)x{
    self.origin = CGPointMake(x, self.y);
}

- (void)setY:(CGFloat)y{
    self.origin = CGPointMake(self.x, y);
}

- (void)setWidth:(CGFloat)width{
    self.size = CGSizeMake(width, self.height);
}

- (void)setHeight:(CGFloat)height{
    self.size = CGSizeMake(self.width, height);
}

- (void)setOrigin:(CGPoint)origin{
    self.frame = CGRectMake(origin.x, origin.y, self.width, self.height);
}

- (void)setCenterPoint:(CGPoint)centerPoint{
    self.frame = CGRectMake(centerPoint.x - self.width/2, centerPoint.y - self.height/2, self.width, self.height);
}

- (void)setSize:(CGSize)size{
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

@end
