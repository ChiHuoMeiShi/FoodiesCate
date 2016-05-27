//
//  CHRPublicAddCellViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/22.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"
#import "CHRPubAddMainFood.h"
@interface CHRPublicAddCellViewController : CHRJBasicViewController

@property (nonatomic,weak)id<CHRPubAddMainFood> delegate;

@property (weak, nonatomic) IBOutlet UITextField *addNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *addCountTextField;


@end
