//
//  CHClickTableViewCell.h
//  吃货美食
//
//  Created by eric on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHCfaxian_list.h"
@interface CHClickTableViewCell : UITableViewCell
@property(nonatomic,strong)CHCfaxian_list *faxian_list;
@property (weak, nonatomic) IBOutlet UILabel *CommentTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentMax;
@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;
@property (weak, nonatomic) IBOutlet UILabel *CommentHongTitle;


@property (weak, nonatomic) IBOutlet UILabel *COmmentStepLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *CommentWeiLabel;

@property (weak, nonatomic) IBOutlet UILabel *ZhengLabel;

-(void)setFaxian_list:(CHCfaxian_list *)faxian_list;
@end
