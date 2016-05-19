//
//  CHCCommentTableViewCell.h
//  吃货美食
//
//  Created by eric on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHCfaxian_list.h"


@interface CHCCommentTableViewCell : UITableViewCell

@property(nonatomic,strong)CHCfaxian_list *faxian_list;
-(void)setFaxian_list:(CHCfaxian_list *)faxian_list;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *CommentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *CommentImageView;
@property (weak, nonatomic) IBOutlet UILabel *commentMwatLabel;
@property (weak, nonatomic) IBOutlet UILabel *CommentXiaoHuaLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentHotLabel;

@end
