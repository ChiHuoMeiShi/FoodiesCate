//
//  CHMyPublishController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHMyPublishController.h"
#import "CHUserDefaults.h"
#import "ZTCookBookModel.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "CHPublishCookBookCell.h"
#import "CHTPublishSHCell.h"
#import "CHPublishShiHuaOneCell.h"
#import "CBData.h"
#import "ShiHuaModel.h"
#import "SHData.h"
#import "SHImgs.h"
#import <UIImageView+WebCache.h>
@interface CHMyPublishController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _selectIndex;
}

@property(nonatomic,strong)ZTCookBookModel *cookBookModel;

@property (nonatomic,strong)ShiHuaModel *shihuaModel;
@property(nonatomic,strong)UITableView *mTableView;



@end

@implementation CHMyPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];

    
    //注册cell
    [self.mTableView registerNib:[UINib nibWithNibName:@"CHPublishCookBookCell" bundle:nil] forCellReuseIdentifier:@"CHPublishCookBookCell"];
    [self.mTableView registerNib:[UINib nibWithNibName:@"CHTPublishSHCell" bundle:nil] forCellReuseIdentifier:@"CHTPublishSHCell"];
    [self.mTableView registerNib:[UINib nibWithNibName:@"CHPublishShiHuaOneCell" bundle:nil] forCellReuseIdentifier:@"CHPublishShiHuaOneCell"];
    [self addHeader];
    [self getPublishCBData];
    [self getPublishSHData];
    
}
- (UITableView *)mTableView
{
    if (!_mTableView) {
        _mTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
//        _mTableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _mTableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    if (0 == _selectIndex) {
        //用菜单模型的data.count
        return self.cookBookModel.data.count;
    }else
        //食话模型的count
        return self.shihuaModel.data.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (0 == _selectIndex) {
        //加载菜单的cell
        CHPublishCookBookCell *cbCell = [tableView dequeueReusableCellWithIdentifier:@"CHPublishCookBookCell"];
        ZTCookBookModel *cbModel = self.cookBookModel;
        cbCell.cookBookModel = cbModel;
        return cbCell;
    }
    
    SHData *shData = self.shihuaModel.data[indexPath.row];
        //加载食话的cell
    if ([shData.img_num intValue] == 0) {
        CHPublishShiHuaOneCell *shCell = [tableView dequeueReusableCellWithIdentifier:@"CHPublishShiHuaOneCell"];
        shCell.summaryLabel.text = shData.summary;
        shCell.createLabel.text = shData.create_time;
        return shCell;
    }
    
    SHImgs *imgs = shData.imgs[0];
    CHTPublishSHCell *shCell = [tableView dequeueReusableCellWithIdentifier:@"CHTPublishSHCell"];
    shCell.summaryLabel.text = shData.summary;
    shCell.createLabel.text = shData.create_time;
    [shCell.imgView sd_setImageWithURL:[NSURL URLWithString:imgs.small]];
    return shCell;

}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHData *shData = self.shihuaModel.data[indexPath.row];
    if (0 == _selectIndex) {
        return 124.f;
    }
    if ([shData.img_num intValue] == 0) {
        return 81.f;
    }
    return 406.f;
}

#pragma mark -- GetPublishData
- (void)getPublishCBData{
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    CHHTTPRequestManager *myManager = [CHHTTPRequestManager manager];
    myManager.userRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [myManager.userRequest.requestSerializer setAuthorizationHeaderFieldWithUsername:userDefault.email password:userDefault.password];
    NSString *url = kPublishCBUrl;
    NSDictionary *parameter = @{@"lat" : @"34.6049907522264",@"lon" : @"112.4229875834745",@"source" : @"iphone" ,@"format" : @"json",@"uid" : userDefault.user_id ,@"page":@"1"};
    __weak typeof(self) mySelf = self;
    [myManager.userRequest POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        CHLog(@"%@",dic);
        mySelf.cookBookModel = [ZTCookBookModel mj_objectWithKeyValues:dic];
        [mySelf.mTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (void)getPublishSHData{
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    CHHTTPRequestManager *myManager = [CHHTTPRequestManager manager];
    myManager.userRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [myManager.userRequest.requestSerializer setAuthorizationHeaderFieldWithUsername:userDefault.email password:userDefault.password];
    NSString *url = kPublishSHUrl;
    NSDictionary *parameter = @{@"lat" : @"34.6049907522264",@"lon" : @"112.4229875834745",@"source" : @"iphone" ,@"format" : @"json",@"uid" : userDefault.user_id ,@"page":@"1"};
    __weak typeof(self) mySelf = self;
    [myManager.userRequest POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        CHLog(@"%@",dic);
        mySelf.shihuaModel = [ShiHuaModel mj_objectWithKeyValues:dic];
        [mySelf.mTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
#pragma mark -- AddHeaderView
- (void)addHeader{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, CHSCREENWIDTH, 59.f)];
    CGFloat interval = 12.f;
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"菜谱",@"食话",nil];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    CGFloat segmentW = 300.f;//segment的宽度
    CGFloat segmentH = 35.f;//高度
    segmentControl.frame = CGRectMake(CHSCREENWIDTH / 2 - segmentW/2, interval, segmentW, segmentH);
    //设置默认索引序列
    segmentControl.selectedSegmentIndex = 0;
    segmentControl.tintColor = [UIColor redColor];
    [segmentControl addTarget:self action:@selector(segmentItenAction:) forControlEvents:UIControlEventValueChanged];
    //字体
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]};
    [segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [headerView addSubview:segmentControl];
    self.mTableView.tableHeaderView = headerView;
    [self.view addSubview:self.mTableView];

}
- (void)segmentItenAction:(UISegmentedControl *)segment{
    
    _selectIndex = segment.selectedSegmentIndex;
    if (0 == _selectIndex) {
        //加载我发布的菜单
        
        
        [self.mTableView reloadData];
    }else if (1 == _selectIndex){
        //加载我发布的食话
        
        
        [self.mTableView reloadData];
    }
}
- (void)navBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
