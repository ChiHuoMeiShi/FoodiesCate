//
//  CHMeViewController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHMeViewController.h"
#import "CHUserDefaults.h"
#import "CHMeHeaderView.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import <UIImage+GIF.h>
@interface CHMeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_headerView;
    CGRect _originHeaderFrame;
}

@property(nonatomic,strong)UITableView *mTableView;
//header的背景
@property(nonatomic,strong)UIImageView *backgroundView;
//头像按钮
@property(nonatomic,strong)UIButton *iconBtn;
//名字
@property(nonatomic,strong)UILabel *nameLabel;

@end

@implementation CHMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, CHSCREENWIDTH, CHSCREENHEIGH) style:UITableViewStylePlain];
//    CHMeHeaderView *mHeader = (CHMeHeaderView *)[[NSBundle mainBundle] loadNibNamed:@"CHMeHeaderView" owner:self options:nil];
//    self.mTableView.tableHeaderView = mHeader;
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self addHeaderView];
    [self.view addSubview:self.mTableView];
    
    
    
    [self login];
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    CHLog(@"用户昵称:%@ 用户id:%@ 用户头像:%@ 性别:%@",userDefault.user_name,userDefault.user_id,userDefault.photo,userDefault.sex);
}
- (void)login{
    CHHTTPRequestManager *myManager = [CHHTTPRequestManager manager];
    myManager.userRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [myManager.userRequest.requestSerializer setAuthorizationHeaderFieldWithUsername:@"13007551820" password:@"zt123456"];
    NSString *url = @"http://api.meishi.cc/v5/login.php?format=json";
    NSDictionary *parameter = @{@"lat" : @"34.6049907522264",@"lon" : @"112.4229875834745",@"source" : @"iphone",@"format" : @"json"};
    [myManager.userRequest POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        //            CHUserDefaults
        CHLog(@"%@",dic);
        int code = [[dic objectForKey:@"code"] intValue];
        if (code == 1) {
            CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
            [userDefault setUserDict:dic];
        }else{
            CHLog(@"用户名或者密码错误");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ZTCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据------%ld",(long)indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.f;
}
#pragma mark --- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<0) {
        //竖直拉伸的比例
        float scale = scrollView.contentOffset.y*(-1)/_originHeaderFrame.size.height;
        //宽度  需要 拉伸的宽度
        CGFloat headerW = _originHeaderFrame.size.width*scale;
        //高度 需要 拉伸的高度
        CGFloat headerH = _originHeaderFrame.size.height*scale;
        
        _headerView.frame = CGRectMake(-headerW/2, scrollView.contentOffset.y, _originHeaderFrame.size.width+headerW, headerH+_originHeaderFrame.size.height);
    }else if(scrollView.contentOffset.y==0){
        // 重置为原来的Frame
        _headerView.frame = _originHeaderFrame;
    }
}
- (void)addHeaderView{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, CHSCREENWIDTH, 300.f)];
    _originHeaderFrame = _headerView.frame;
    self.backgroundView = [[UIImageView alloc] initWithFrame:_headerView.frame];
    self.backgroundView.image = [UIImage imageNamed:@"meBackground"];
    [_headerView addSubview:self.backgroundView];
    CGFloat btnW = 80.f;
    CGFloat btnH = 80.f;
    CGFloat btnY = 120.f;
    self.iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(CHSCREENWIDTH / 2 - btnW / 2, btnY, btnW ,btnH)];
    CGFloat labelW = 200.f;
    CGFloat labelH = 21.f;
    CGFloat interval = 18.f;
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CHSCREENWIDTH / 2 - labelW / 2, btnH + btnY + interval, labelW, labelH)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:17.f];
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    if (userDefault) {
        typeof(self) mySelf = self;
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:userDefault.photo] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {

        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [mySelf.iconBtn setImage:image forState:UIControlStateNormal];
        }];
        [self.iconBtn addTarget:self action:@selector(gotoUserView) forControlEvents:UIControlEventTouchUpInside];
        self.nameLabel.text = userDefault.user_name;
    }else{
        [self.iconBtn setImage:[UIImage imageNamed:@"unlogintouxiang"] forState:UIControlStateNormal];
        [self.iconBtn addTarget:self action:@selector(gotoLoginView) forControlEvents:UIControlEventTouchUpInside];
        self.nameLabel.text = @"未登录";
    }
    [_headerView addSubview:self.iconBtn];
    [_headerView addSubview:self.nameLabel];
    self.mTableView.tableHeaderView = _headerView;
}
//跳到用户界面
- (void)gotoUserView
{
    
}
//跳到登录界面
- (void)gotoLoginView
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
