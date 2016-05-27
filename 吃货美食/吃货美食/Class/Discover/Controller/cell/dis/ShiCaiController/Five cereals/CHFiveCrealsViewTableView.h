//
//  CHFiveCrealsViewTableView.h
//  吃货美食
//
//  Created by eric on 16/5/27.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHCShiCaiData.h"
@interface CHFiveCrealsViewTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)CHCShiCaiData *data2;
@end
