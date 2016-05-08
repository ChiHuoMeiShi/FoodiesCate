//
//  UIImage+Draught.m
//  QQ聊天界面
//
//  Created by scjy on 15/11/6.
//  Copyright © 2015年 scjy. All rights reserved.
//

#import "UIImage+Draught.h"

@implementation UIImage (Draught)

- (UIImage *)draughtImage{
    
    float resizableH = self.size.height / 2;
    
    float resizableW = self.size.width / 2;
    
    UIEdgeInsets edge = UIEdgeInsetsMake(resizableH, resizableW, resizableH, resizableW);
    
    //图片拉伸
    UIImage *resultImage = [self resizableImageWithCapInsets:edge];
    
    return resultImage;
}

@end
