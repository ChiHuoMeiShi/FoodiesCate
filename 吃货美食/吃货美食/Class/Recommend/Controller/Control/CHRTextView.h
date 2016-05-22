//
//  CHRTextView.h
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHRTextView : UITextView

@property(nonatomic, assign)BOOL isDrawPlaceholder;

@property(nonatomic, strong)NSString *placeholder;

@property(nonatomic, strong)UIColor *placeholderColor;

@end
