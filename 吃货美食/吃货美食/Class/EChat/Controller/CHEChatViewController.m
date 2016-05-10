//
//  CHEChatViewController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHEChatViewController.h"
#import "PellTableViewSelect.h"
@interface CHEChatViewController ()

@end

@implementation CHEChatViewController

-(void)loadView
{
    //leftBarButtonItem
    UIBarButtonItem *leftItemAdd = [UIBarButtonItem barItemWithImageName:@"umeng_add_photo" withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftItemAdd;
    
    //rightBarButtonItems
    UIBarButtonItem *rightItemMail = [UIBarButtonItem barItemWithImageName:@"ms_mail2" withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTarget:self action:@selector(msMail) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItemSearch = [UIBarButtonItem barItemWithImageName:@"topsearchicon_grey_2" withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightItemSearch,rightItemMail];
}
- (void)msMail
{
    
}
- (void)addClick
{
    // 弹出QQ的自定义视图
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(self.view.bounds.size.width - 100, 64, 150, 200) selectData:@[@"发食话",@"餐桌食光",@"玩转烘焙",@"美食讲堂"] images:@[@"saoyisao.png",@"jiahaoyou.png",@"taolun.png",@"diannao.png"] action:^(NSInteger index) {
        NSLog(@"选择%ld",index);
    } animated:YES];
}
- (void)search
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
