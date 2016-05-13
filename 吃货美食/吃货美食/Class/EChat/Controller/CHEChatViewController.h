//
//  CHEChatViewController.h
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EChatModel.h"
#import "Hot_topocModel.h"
typedef void(^ReturnHotBlock)(Hot_topocModel *topicModel);

@interface CHEChatViewController : UIViewController

@property(nonatomic,copy)ReturnHotBlock hotBlock;

@property(strong,nonatomic)EChatModel *echatModel;

- (void)returnTopicModel:(ReturnHotBlock)block;

@end
