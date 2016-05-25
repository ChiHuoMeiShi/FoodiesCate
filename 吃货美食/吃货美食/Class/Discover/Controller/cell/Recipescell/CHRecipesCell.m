//
//  CHRecipesCell.m
//  吃货美食
//
//  Created by eric on 16/5/12.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRecipesCell.h"
#import <UIImageView+WebCache.h>
@implementation CHRecipesCell
-(void)setFaxian_list:(CHCfaxian_list *)faxian_list
{
    _faxian_list=faxian_list;
    _titleLabel.text=faxian_list.title;
    _tagLabel.text=faxian_list.tag;
    _Arr=[NSMutableArray array];
    for (CHCrecipes_list *model in faxian_list.gongyi_info.recipes) {
        [self.Arr addObject:model.titlepic];
    }
        [_oneImageView sd_setImageWithURL:[NSURL URLWithString:self.Arr[0]]];
 [_twoImageView sd_setImageWithURL:[NSURL URLWithString:self.Arr[1]]];
     [_threeImageVIew sd_setImageWithURL:[NSURL URLWithString:self.Arr[2]]];
    
//    [_oneImageView sd_setImageWithURL:[NSURL URLWithString:((CHCrecipes_list*)faxian_list.gongyi_info.recipes[2]).titlepic]];
   //    [_bagImagView sd_setImageWithURL:[NSURL URLWithString:((CHCimages_list *)faxian_list.topic_info.imgs[1]).big]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self setSelectedBackgroundView:bgColorView];
}

@end
