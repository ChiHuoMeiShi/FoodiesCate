//
//  CHJRecmdUpdateCollectionViewCell.h
//  吃货美食
//
//  Created by scjy on 16/5/10.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
#import "CHRJSearchContentModel.h"
@interface CHJRecmdUpdateCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@property (nonatomic,strong)CHRJSearchContentModel * searchMdodel;
@end
