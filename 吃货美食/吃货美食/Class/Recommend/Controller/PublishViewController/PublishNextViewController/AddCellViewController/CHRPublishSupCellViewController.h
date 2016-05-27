//
//  CHRPublishSupCellViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/24.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"
#import "CHRPubAddSupFood.h"
@interface CHRPublishSupCellViewController : CHRJBasicViewController

@property (nonatomic,weak)id<CHRPubAddSupFood> delegate;
@property (weak, nonatomic) IBOutlet UITextField *addNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addCountTextField;

@end
