//
//  CHCaiDanCell.h
//  吃货美食
//
//  Created by eric on 16/5/12.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHCfaxian_list.h"
@interface CHCaiDanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIImageView *oneImageVIew;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageVIew;
@property (weak, nonatomic) IBOutlet UIImageView *threeImageVIew;
@property(nonatomic,strong)CHCfaxian_list *faxian_list;
-(void)setFaxian_list:(CHCfaxian_list *)faxian_list;
@end
