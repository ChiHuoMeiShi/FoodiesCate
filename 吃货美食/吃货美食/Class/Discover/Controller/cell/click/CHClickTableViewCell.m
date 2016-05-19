//
//  CHClickTableViewCell.m
//  吃货美食
//
//  Created by eric on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHClickTableViewCell.h"
#import "CHCfaxian_list.h"
#import <UIImageView+WebCache.h>
@implementation CHClickTableViewCell
-(void)setFaxian_list:(CHCfaxian_list *)faxian_list
{
    _faxian_list=faxian_list;
    if ([faxian_list.type isEqualToString:@"1"]) {
        _CommentTitleLabel.text=faxian_list.title;
        _commentMax.text=faxian_list.tag;
        
        [_commentImageView sd_setImageWithURL:[NSURL URLWithString:faxian_list.recipe_info.titlepic]];
        _CommentHongTitle.text=faxian_list.recipe_info.title;
        _COmmentStepLabel.text=faxian_list.recipe_info.step;
        _timeLabel.text=faxian_list.recipe_info.make_time;
        _CommentWeiLabel.text=faxian_list.recipe_info.kouwei;
        _ZhengLabel.text=faxian_list.recipe_info.gongyi;
    }

    
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
unsigned int numIvars; //成员变量个数
//Ivar *vars = class_copyIvarList(NSClassFromString(@"CHCfaxian_list"), &numIvars);
//
//NSString *key=nil;
//for(int i = 0; i < numIvars; i++)
//{
//    
//    Ivar thisIvar = vars[i];
//    key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
//    if ([key isEqualToString:@"shicai_info"])
//    {
//        _CommentTitleLabel.text=faxian_list.title;
//        _commentMax.text=faxian_list.tag;
//        
//    }
//    
//}
//free(vars);
