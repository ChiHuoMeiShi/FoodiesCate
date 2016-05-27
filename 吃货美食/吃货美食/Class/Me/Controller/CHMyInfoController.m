//
//  CHMyInfoController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/25.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHMyInfoController.h"
#import "CHUserDefaults.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "CHNameViewCell.h"
#import "CHLoginController.h"
@interface CHMyInfoController () <UITableViewDelegate,UITableViewDataSource>
{
    CGFloat _tableViewY;
}
@property (nonatomic,strong)UIButton *iconBtn;
@property (nonatomic,strong)UITextField *nameTextField;
@property (nonatomic,strong)UITableView *mTableView;



@end

@implementation CHMyInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"个人信息";
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self viewlayout];
    
}
- (void)navBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewlayout{
    CGFloat btnY = 64 + 50.f;
    CGFloat btnW = 120.f;
    CGFloat btnX = CHSCREENWIDTH / 2 - btnW / 2;
    CGFloat btnH = btnW;
    self.iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    
    _tableViewY = btnY + btnW + 70.f;
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:userDefault.photo] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [self.iconBtn setImage:image forState:UIControlStateNormal];
    }];
    [self.iconBtn addTarget:self action:@selector(changeIcon) forControlEvents:UIControlEventTouchUpInside];
    self.iconBtn.layer.masksToBounds = YES;
    self.iconBtn.layer.cornerRadius = self.iconBtn.width * 0.5;
    [self.view addSubview:self.iconBtn];
    //tableView
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, _tableViewY, CHSCREENWIDTH, CHSCREENHEIGH) style:UITableViewStyleGrouped];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"CHNameViewCell" bundle:nil] forCellReuseIdentifier:@"CHNameViewCell"];
    
    [self.view addSubview:self.mTableView];
    
}
- (void)changeIcon{
    
}

#pragma mark - UITableViewDataSource


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (1 == section) {
        return @"设置";
    }else if (2 == section){
        return @"退出当前账号";
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CHNameViewCell *nameCell = [tableView dequeueReusableCellWithIdentifier:@"CHNameViewCell"];
        CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
        nameCell.nameTextField.text = userDefault.user_name;
        
        return nameCell;
    }
    static NSString *ID = @"ZTCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"清除缓存";
    }else if (indexPath.section == 1 && indexPath.row == 1){
        cell.textLabel.text = @"关于我们";
    }else if (indexPath.section == 2){
        UIButton *logout = [[UIButton alloc] initWithFrame:CGRectMake(10.f, 5.f, CHSCREENWIDTH - 20.f, 50.f)];
        [logout setTitle:@"退出登录" forState:UIControlStateNormal];
        [logout setBackgroundColor:[UIColor redColor]];
        [logout addTarget:self action:@selector(logouClick) forControlEvents:UIControlEventTouchUpInside];
        logout.layer.cornerRadius = 16.f;
        cell.contentView.backgroundColor = [[UIColor alloc] initWithRed:239 / 255.f green:239 / 255.f blue:239 / 255.f alpha:1];
        [cell.contentView addSubview:logout];
    }
    return cell;
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50.f;
    }
    return 60.f;
}
- (void)logouClick{
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    [userDefault setUserDict:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
