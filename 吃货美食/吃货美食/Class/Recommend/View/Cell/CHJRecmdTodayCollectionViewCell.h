//
//  CHJRecmdTodayCollectionViewCell.h
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHJRecomdTodayModel.h"
#import <UIImageView+WebCache.h>
@interface CHJRecmdTodayCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (nonatomic,strong)CHJRecomdTodayModel * todayModel;
@end
