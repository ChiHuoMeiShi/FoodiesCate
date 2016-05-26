//
//  CHRCommitCollectionViewCell.h
//  吃货美食
//
//  Created by scjy on 16/5/26.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHRCommitCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (nonatomic,assign)BOOL btnIsSelect;
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@end
