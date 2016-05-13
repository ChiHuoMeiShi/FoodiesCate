//
//  CHRecommendViewController.h
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"
extern const CGFloat myLat;
extern const CGFloat myLon;
@interface CHRecommendViewController : CHRJBasicViewController

@property (weak, nonatomic) IBOutlet UIButton *backToTopButton;

- (void)getCollectionViewData;
@end
