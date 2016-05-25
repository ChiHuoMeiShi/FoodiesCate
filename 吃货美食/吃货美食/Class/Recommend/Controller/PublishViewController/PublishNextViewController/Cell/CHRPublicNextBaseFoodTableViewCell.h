//
//  CHRPublicNextBaseFoodTableViewCell.h
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHRImageButton.h"
#import "CHRPublishFoodStepModel.h"

@interface CHRPublicNextBaseFoodTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *orderButton;

@property (weak, nonatomic) IBOutlet UITextField *namedTextField;
@property (weak, nonatomic) IBOutlet UITextField *stepTextField;

@property (weak, nonatomic) IBOutlet CHRImageButton *takephotoButton;

@property (nonatomic,strong)CHRPublishFoodStepModel * publishModel;

@end
