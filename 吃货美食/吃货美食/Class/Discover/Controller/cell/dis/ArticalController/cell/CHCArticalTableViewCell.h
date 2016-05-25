//
//  CHCArticalTableViewCell.h
//  吃货美食
//
//  Created by eric on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHCTableVIewData_list.h"
@interface CHCArticalTableViewCell : UITableViewCell
@property(nonatomic,strong)CHCTableVIewData_list *TableVIewData_list;
-(void)setTableVIewData_list:(CHCTableVIewData_list *)TableVIewData_list;
@property (weak, nonatomic) IBOutlet UIImageView *tabelViewimageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *detalieLabel;
@end
