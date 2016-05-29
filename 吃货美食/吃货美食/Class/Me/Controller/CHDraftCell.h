//
//  CHDraftCell.h
//  吃货美食
//
//  Created by 赵天 on 16/5/28.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHDraftCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *draftImage;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic,strong) NSDictionary * foodDic;

@end
