//
//  CHCArticalTableView.h
//  吃货美食
//
//  Created by eric on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHCArticalData.h"
@interface CHCArticalTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
@property(nonatomic,strong)CHCArticalData *data;

@end
