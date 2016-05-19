//
//  CHCShiCaiTableView.h
//  吃货美食
//
//  Created by eric on 16/5/14.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHCShiCaiData.h"

@interface CHCShiCaiTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)CHCShiCaiData *data2;

@end
