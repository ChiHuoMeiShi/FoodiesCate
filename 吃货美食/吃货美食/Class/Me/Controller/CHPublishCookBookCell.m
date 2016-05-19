//
//  CHPublishCookBookCell.m
//  吃货美食
//
//  Created by 赵天 on 16/5/19.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHPublishCookBookCell.h"
#import "CBData.h"
#import <UIImageView+WebCache.h>
@implementation CHPublishCookBookCell

- (void)setCookBookModel:(ZTCookBookModel *)cookBookModel
{
    if (cookBookModel == nil) {
        return;
    }
    _cookBookModel = cookBookModel;
    
    for (CBData *data in cookBookModel.data) {
        
        int starCount = [data.rate intValue];
        if (starCount > 5) {
            starCount = 5;
        }
        for (int i = 0; i < starCount; i++) {
            UIImageView * starImageView= self.starImageViewArr[i];
            starImageView.image = [UIImage imageNamed:@"ms_caipu_level"];
        }
        
        [self.showImageView sd_setImageWithURL:[NSURL URLWithString:data.titlepic]];
        
        self.nameLabel.text = data.titlepic;
        
        NSString *hardString = [NSString stringWithFormat:@"%@步",data.step];
        
        if (![data.make_time isEqualToString:@""]) {
            hardString = [NSString stringWithFormat:@"%@/%@",hardString,data.make_time];
        }
        self.hardLabel.text = hardString;
        
        NSString * typeString = [NSString stringWithFormat:@"%@/%@",data.kouwei,data.gongyi];
        self.typeLabel.text = typeString;

    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self setSelectedBackgroundView:bgColorView];
    // Configure the view for the selected state
}

@end
