//
//  CHCZhuanTiTableViewCell.h
//  吃货美食
//
//  Created by eric on 16/5/15.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHCZhuanTiData_list.h"
@interface CHCZhuanTiTableViewCell : UITableViewCell
@property(nonatomic,strong)CHCZhuanTiData_list *zhuanTiData_list;
-(void)setZhuanTiData_list:(CHCZhuanTiData_list *)zhuanTiData_list;
@property (weak, nonatomic) IBOutlet UIImageView *ZhuanTiImage;
@property (weak, nonatomic) IBOutlet UILabel *buttonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *lastLabel;
@end
