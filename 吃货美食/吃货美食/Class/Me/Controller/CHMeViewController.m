//
//  CHMeViewController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHMeViewController.h"
#import "CHUserDefaults.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "CHMyDraftController.h"
#import "CHMyCollectController.h"
#import "CHMyPublishController.h"
#import "CHMyInfoController.h"
#import "CHRegisterController.h"
#import "CHLoginController.h"


@interface CHMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mTableView;
//header的背景
@property(nonatomic,strong)UIImageView *backgroundView;
//头像按钮
@property(nonatomic,strong)UIButton *iconBtn;
//名字
@property(nonatomic,strong)UILabel *nameLabel;

@property (nonatomic,strong)CHMyInfoController *myInfoController;

@property (nonatomic,strong)CHUserDefaults *userDefault;

@end

@implementation CHMeViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.userDefault = [CHUserDefaults shareUserDefault];
    
    [self.mTableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, CHSCREENWIDTH, CHSCREENHEIGH) style:UITableViewStyleGrouped];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.showsVerticalScrollIndicator = NO;
    self.mTableView.showsHorizontalScrollIndicator = NO;
    [self.mTableView reloadData];
    [self.view addSubview:self.mTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ZTCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (0 == indexPath.row) {
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.text = @"我的发布";
        cell.textLabel.font = [UIFont systemFontOfSize:28.f];
        cell.imageView.image= [UIImage imageNamed:@"fabu"];
        cell.backgroundColor = [[UIColor alloc] initWithRed:247.f/255.f green:255.f/157.f blue:221.f/255.f alpha:1];

        return cell;
    }

    else if (1 == indexPath.row){
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:28.f];
        cell.imageView.image= [UIImage imageNamed:@"caogao"];
        cell.textLabel.text = @"草稿箱";
        cell.backgroundColor = [[UIColor alloc] initWithRed:237.f/255.f green:220.f/255.f blue:221.f/255.f alpha:1];
        return cell;
    }else if (2 == indexPath.row){
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:28.f];
        cell.textLabel.text = @"个人设置";
        cell.imageView.image= [UIImage imageNamed:@"shezhi"];
        cell.backgroundColor = [[UIColor alloc] initWithRed:222.f/255.f green:255.f/255.f blue:218.f/255.f alpha:1];
        return cell;
    }
    return nil;
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (0 == indexPath.row) {
        if (userDefault.user_name) {
            CHMyPublishController *targetVC = [[CHMyPublishController alloc] init];
            [self.navigationController pushViewController:targetVC animated:YES];
        }else{
            [self gotoLoginView];
        }
    }

    if (1 == indexPath.row){
        
        if (userDefault.user_name) {
            CHMyDraftController *targetVC = [[CHMyDraftController alloc] init];
            [self.navigationController pushViewController:targetVC animated:YES];
        }else{
            [self gotoLoginView];
        }

    }
    if (2 == indexPath.row){
        
        if (userDefault.user_name) {
            CHMyInfoController *targetVC = [[CHMyInfoController alloc] init];
            [self.navigationController pushViewController:targetVC animated:YES];
        }else{
            [self gotoLoginView];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 250.f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, CHSCREENWIDTH, 250.f)];
    self.backgroundView = [[UIImageView alloc] initWithFrame:headerView.frame];
    self.backgroundView.image = [UIImage imageNamed:@"meBackground"];
    [headerView addSubview:self.backgroundView];
    CGFloat btnW = 80.f;
    CGFloat btnH = 80.f;
    CGFloat btnY = 120.f;
    self.iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(CHSCREENWIDTH / 2 - btnW / 2, btnY, btnW ,btnH)];
    CGFloat labelW = 200.f;
    CGFloat labelH = 21.f;
    CGFloat interval = 18.f;
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CHSCREENWIDTH / 2 - labelW / 2, btnH + btnY + interval, labelW, labelH)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:20.f];
    self.nameLabel.textColor = [UIColor orangeColor];
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    if (userDefault.user_id) {
        typeof(self) mySelf = self;
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:userDefault.photo] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [mySelf.iconBtn setImage:image forState:UIControlStateNormal];
        }];
        [self.iconBtn addTarget:self action:@selector(gotoUserView) forControlEvents:UIControlEventTouchUpInside];
        self.iconBtn.layer.masksToBounds = YES;
        self.iconBtn.layer.cornerRadius = self.iconBtn.width * 0.5;
        self.iconBtn.layer.borderWidth = 5.0;
        self.iconBtn.layer.borderColor = [UIColor yellowColor].CGColor;
        self.nameLabel.text = userDefault.user_name;
    }else{
        [self.iconBtn setImage:[UIImage imageNamed:@"unlogintouxiang"] forState:UIControlStateNormal];
        [self.iconBtn addTarget:self action:@selector(gotoLoginView) forControlEvents:UIControlEventTouchUpInside];
        self.nameLabel.text = @"未登录";
    }
    [headerView addSubview:self.iconBtn];
    [headerView addSubview:self.nameLabel];
    
    return headerView;
}

//跳到用户界面
- (void)gotoUserView
{
    self.myInfoController = [[CHMyInfoController alloc] init];
    [self.navigationController pushViewController:self.myInfoController animated:YES];
}
//跳到登录界面
- (void)gotoLoginView
{
    CHLoginController *targetVC = [[CHLoginController alloc] init];
    [self.navigationController pushViewController:targetVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}
@end
