//
//  CHCateShowController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/15.
//  Copyright © 2016年 赵天. All rights reserved.
//
#import "CHEChatViewController.h"
#import "CHZSendEChatController.h"
#import "Hot_topocModel.h"
#import <AFNetworking.h>
#import "CHEChatCell.h"
#import "CHEChatDetailController.h"
#import <MJRefresh.h>
#import "CHCateShowController.h"
#import "CHCateShowController.h"
#import "CHDBHelper.h"
@interface CHCateShowController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UITableView *eChatTableView;

@property(strong,nonatomic)NSMutableArray *dataArr;

@end

@implementation CHCateShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addHeader];
    [self getEchatDataWithSort:@"new"];
    
    self.eChatTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self getEchatDataWithSort:@"time"];
    __weak typeof(self) mSelf = self;
    //下拉刷新
    mSelf.eChatTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [mSelf getEchatDataWithSort:@"time"];
    }];
    //上拉刷新
    mSelf.eChatTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [mSelf upRequestDataWithSort:@"time"];
    }];
    self.eChatTableView.delegate = self;
    self.eChatTableView.dataSource = self;
    self.eChatTableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.eChatTableView];
    [self registReuseCell];
}
- (void)registReuseCell
{
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHEChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatCellReuse"];
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHTwoChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatTwoCellReuse"];
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHThreeChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatThreeCellReuse"];
    
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHTFourChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatFourCellReuse"];
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHFiveChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatFiveCellReuse"];
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHSixChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatSixCellReuse"];
    
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHSevenChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatSevenCellReuse"];
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHEightChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatEightCellReuse"];
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHNineChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatNineCellReuse"];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.echatModel.hot_topic.count;
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    Hot_topocModel *hotModel = self.dataArr[indexPath.row];
    Topic_List *topicList = self.dataArr[indexPath.row];
    if ([topicList.img_num intValue] == 1) {
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatCellReuse"];
        //        eChatCell.showhottopic = self.echatModel.hot_topic[indexPath.row];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    } else if ([topicList.img_num intValue] == 2){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatTwoCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    } else if ([topicList.img_num intValue] == 3){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatThreeCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    } else if ([topicList.img_num intValue] == 4){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatFourCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    } else if ([topicList.img_num intValue] == 5){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatFiveCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    } else if ([topicList.img_num intValue] == 6){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatSixCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    } else if ([topicList.img_num intValue] == 7){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatSevenCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    } else if ([topicList.img_num intValue] == 8){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatEightCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    }else if ([topicList.img_num intValue] == 9)
    {
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatNineCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    }
    CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatCellReuse"];
    eChatCell.showhottopic = self.dataArr[indexPath.row];
    return eChatCell;
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //最好写一个非常大的值，不然数据会做一些干扰
    return 10000;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Topic_List *topicList = self.dataArr[indexPath.row];
    if ([topicList.img_num intValue] == 1) {
        return 369.f;
    }else if ([topicList.img_num intValue] > 1 && [topicList.img_num intValue] < 4){
        return 247.f;
    }else if ([topicList.img_num intValue] >= 4 && [topicList.img_num intValue] < 7){
        return 335.f;
    }
    return 427.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHEChatDetailController *targetVC = [[CHEChatDetailController alloc] init];
    Topic_List *topicList = self.cateModel.topic_list[indexPath.row];
    targetVC.tid = topicList.tid;
    targetVC.gid = topicList.gid;
    [self.navigationController pushViewController:targetVC animated:YES];
}

- (void)addHeader{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 46.f)];
    //tableView的headerview是  V
    _eChatTableView.tableHeaderView = v;
    //segment
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"最新",@"最热",nil];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    CGFloat segmentW = 200.f;//segment的宽度
    CGFloat segmentH = 30.f;//高度
    segmentControl.frame = CGRectMake(CHSCREENWIDTH / 2 - segmentW/2, 8, segmentW, segmentH);
    //设置默认索引序列
    segmentControl.selectedSegmentIndex = 0;
    segmentControl.tintColor = [UIColor redColor];
    
    [segmentControl addTarget:self action:@selector(segmentItenAction:) forControlEvents:UIControlEventValueChanged];
    [v addSubview:segmentControl];
    [self.view addSubview:self.eChatTableView];
}
- (void)segmentItenAction:(UISegmentedControl *)segment
{
    NSInteger index = segment.selectedSegmentIndex;
    //最新
    if (0 == index)
    {
        [self getEchatDataWithSort:@"new"];
        __weak typeof(self) mSelf = self;
        //下拉刷新
        mSelf.eChatTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [mSelf getEchatDataWithSort:@"new"];
        }];
        //上拉刷新
        mSelf.eChatTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [mSelf upRequestDataWithSort:@"new"];
        }];
    }
    //最热
    else if (1 == index){
        [self getEchatDataWithSort:@"hot"];
        __weak typeof(self) mSelf = self;
        //下拉刷新
        mSelf.eChatTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self getEchatDataWithSort:@"hot"];
        }];
        //上拉刷新
        mSelf.eChatTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [mSelf upRequestDataWithSort:@"hot"];
        }];
    }
    
}
#pragma mark -- 请求数据(上下拉刷新)
//请求数据(下拉刷新)
- (void)getEchatDataWithSort:(NSString *)sort
{
    CHHTTPRequestManager *myManager = [CHHTTPRequestManager manager];
    
    myManager.messageRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/topic_list3.php?format=json";
    NSDictionary *parameters = @{@"lat" : @"34.60513495876783",@"lon" : @"112.4112401412381",@"source" : @"iphone",@"format" : @"json",@"gid":@"20", @"page":@"1",@"order" : sort,@"from":@"0"};
    __weak typeof(self) mySelf = self;
    [myManager.messageRequest POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [mySelf.eChatTableView.mj_header endRefreshing];
        NSDictionary * dic = (NSDictionary *)responseObject;
        mySelf.cateModel = [CateShowModel mj_objectWithKeyValues:dic];
        
        dispatch_queue_t q1 = dispatch_queue_create("queue1", NULL);
        dispatch_async(q1, ^{
            [mySelf.cateModel save];
        });
        
        
        mySelf.dataArr = [[NSMutableArray alloc] initWithArray:mySelf.cateModel.topic_list];
        
        [mySelf.eChatTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"失败原因%@",error);
        [mySelf.eChatTableView.mj_header endRefreshing];
    }];
}
//上拉刷新
- (void)upRequestDataWithSort:(NSString *)sort
{
    self.page = 1;
    self.page = self.page + 1;
    //    self.page +=1;
    CHHTTPRequestManager *myManager = [CHHTTPRequestManager manager];
    
    myManager.messageRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/topic_list3.php?format=json";
    NSDictionary *parameters = @{@"lat" : @"34.60513495876783",@"lon" : @"112.4112401412381",@"source" : @"iphone",@"format" : @"json",@"gid":@"20", @"page":@(self.page),@"order" : sort,@"from":@"0"};
    __weak typeof(self) mySelf = self;
    [myManager.messageRequest POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [mySelf.eChatTableView.mj_footer endRefreshing];
        NSDictionary * dic = (NSDictionary *)responseObject;
        mySelf.cateModel = [CateShowModel mj_objectWithKeyValues:dic];
        [mySelf.dataArr addObjectsFromArray:mySelf.cateModel.topic_list];
        [mySelf.eChatTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"失败原因%@",error);
        [mySelf.eChatTableView.mj_footer endRefreshing];
    }];
}
- (void)navBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
@end
