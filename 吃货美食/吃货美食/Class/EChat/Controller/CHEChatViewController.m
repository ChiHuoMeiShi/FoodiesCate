//
//  CHEChatViewController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHEChatViewController.h"
#import "CHZSendEChatController.h"
#import <UIImageView+WebCache.h>
#import "CHEChatHeaderView.h"
#import "Hot_topocModel.h"
#import <AFNetworking.h>
#import "CHEChatCell.h"
#import "CHEChatDetailController.h"
#import <MJRefresh.h>
#import "CHCateShowController.h"
#import "CHGoodCookViewController.h"
#import "CHFoodClassViewController.h"
@interface CHEChatViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UITableView *eChatTableView;
/**
 *  用来上下拉刷新处理
 */
@property(strong,nonatomic)NSMutableArray *dataArr;

@end

@implementation CHEChatViewController
//
- (void)segmentItenAction:(UISegmentedControl *)segment
{
    NSInteger index = segment.selectedSegmentIndex;
    //最新
    if (0 == index)
    {
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
- (void)msMail
{
    
}
- (void)addClick
{
    CHZSendEChatController *targetVC = [[CHZSendEChatController alloc] init];
    [self.navigationController pushViewController:targetVC animated:YES];
    
}
- (void)search
{

}
#pragma mark -- 请求数据(上下拉刷新)
//请求数据(下拉刷新)
- (void)getEchatDataWithSort:(NSString *)sort
{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/meishiquan_index4.php?format=json";
    NSDictionary *parameters = @{@"lat" : @"34.6049907522264",@"lon" : @"112.4229875834745",@"source" : @"iphone",@"format" : @"json", @"sort" : sort};
    __weak typeof(self) mySelf = self;
    
    [manger POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [mySelf.eChatTableView.mj_header endRefreshing];
        NSDictionary * dic = (NSDictionary *)responseObject;
        mySelf.echatModel = [EChatModel mj_objectWithKeyValues:dic];
        mySelf.dataArr = [[NSMutableArray alloc] initWithArray:mySelf.echatModel.hot_topic];
        
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
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/meishiquan_index4.php?format=json";
    NSDictionary *parameters = @{@"lat" : @"34.6049907522264",@"lon" : @"112.4229875834745",@"source" : @"iphone",@"format" : @"json", @"page":@(self.page),@"sort" : sort};
    __weak typeof(self) mySelf = self;
    [manger POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [mySelf.eChatTableView.mj_footer endRefreshing];
        NSDictionary * dic = (NSDictionary *)responseObject;
        mySelf.echatModel = [EChatModel mj_objectWithKeyValues:dic];
        [mySelf.dataArr addObjectsFromArray:mySelf.echatModel.hot_topic];
        [mySelf.eChatTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"失败原因%@",error);
        [mySelf.eChatTableView.mj_footer endRefreshing];
        
    }];
}

//添加barButtonitem
- (void)addNavigationItem
{
    //leftBarButtonItem
    UIBarButtonItem *leftItemAdd = [UIBarButtonItem barItemWithImageName:@"umeng_add_photo" withSelectImage:@"umeng_add_photo" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftItemAdd;
    //rightBarButtonItems
    UIBarButtonItem *rightItemMail = [UIBarButtonItem barItemWithImageName:@"ms_mail2" withSelectImage:@"ms_mail2" withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTarget:self action:@selector(msMail) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItemSearch = [UIBarButtonItem barItemWithImageName:@"topsearchicon_grey_2" withSelectImage:@"topsearchicon_grey_2" withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[rightItemSearch,rightItemMail];
}
#pragma mark -- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationItem];
    //先加载数据
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
    self.eChatTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.eChatTableView.delegate = self;
    self.eChatTableView.dataSource = self;
    self.eChatTableView.rowHeight = UITableViewAutomaticDimension;
    [self registReuseCell];
    [self addHeaderView];
}
#pragma mark -- 注册Cell
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
    
//    Hot_topocModel *hotModel = self.echatModel.hot_topic[indexPath.row];
    Hot_topocModel *hotModel = self.dataArr[indexPath.row];
    
    if ([hotModel.img_num intValue] == 1) {
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatCellReuse"];
//        eChatCell.showhottopic = self.echatModel.hot_topic[indexPath.row];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    } else if ([hotModel.img_num intValue] == 2){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatTwoCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    } else if ([hotModel.img_num intValue] == 3){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatThreeCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    } else if ([hotModel.img_num intValue] == 4){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatFourCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    } else if ([hotModel.img_num intValue] == 5){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatFiveCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    } else if ([hotModel.img_num intValue] == 6){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatSixCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    } else if ([hotModel.img_num intValue] == 7){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatSevenCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    } else if ([hotModel.img_num intValue] == 8){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatEightCellReuse"];
        eChatCell.showhottopic = self.dataArr[indexPath.row];
        return eChatCell;
    }else if ([hotModel.img_num intValue] == 9)
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
    Hot_topocModel *hotModel = self.dataArr[indexPath.row];
    if ([hotModel.img_num intValue] == 1) {
        return 369.f;
    }else if ([hotModel.img_num intValue] > 1 && [hotModel.img_num intValue] < 4){
        return 247.f;
    }else if ([hotModel.img_num intValue] >= 4 && [hotModel.img_num intValue] < 7){
        return 335.f;
    }
    return 427.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHEChatDetailController *targetVC = [[CHEChatDetailController alloc] init];
    Hot_topocModel *hotModel = self.echatModel.hot_topic[indexPath.row];
    targetVC.tid = hotModel.tid;
    targetVC.gid = hotModel.gid;
    [self.navigationController pushViewController:targetVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- 添加headerView
- (void)addHeaderView
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    CGFloat btnWidth = 70.f;
    CGFloat btnHeight = 70.f;
    //中间
    UIButton *goodCook = [[UIButton alloc] initWithFrame:CGRectMake(CHSCREENWIDTH / 2 - btnWidth / 2, 8.f , btnWidth, btnHeight)];
    [goodCook setImage:[UIImage imageNamed:@"bake1"] forState:UIControlStateNormal];
    [goodCook addTarget:self action:@selector(googCookClick) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:goodCook];
    CGFloat interval = 5.f;//label和btn的间距
    UILabel *goodLabel = [[UILabel alloc] initWithFrame:CGRectMake(goodCook.x, goodCook.y + btnHeight + interval, btnWidth, 21.f)];
    goodLabel.text = @"玩转烘焙";
    goodLabel.font = [UIFont systemFontOfSize:16.f];
    goodLabel.textAlignment = NSTextAlignmentCenter;
    [v addSubview:goodLabel];
    //左边
    UIButton *cateShow = [[UIButton alloc] initWithFrame:CGRectMake((CHSCREENWIDTH - btnWidth * 3) / 4, 8.f, btnWidth, btnHeight)];
    [cateShow addTarget:self action:@selector(cateShowClick) forControlEvents:UIControlEventTouchUpInside];
    [cateShow setImage:[UIImage imageNamed:@"zhms1"] forState:UIControlStateNormal];
    [v addSubview:cateShow];
    UILabel *cateLabel = [[UILabel alloc] initWithFrame:CGRectMake(cateShow.x, cateShow.y + btnHeight + interval, btnWidth, 21.f)];
    cateLabel.text = @"餐桌食光";
    cateLabel.font = [UIFont systemFontOfSize:16.f];
    cateLabel.textAlignment = NSTextAlignmentCenter;
    [v addSubview:cateLabel];
    //右边
    UIButton *foodClass = [[UIButton alloc] initWithFrame:CGRectMake(CHSCREENWIDTH / 2 + btnWidth / 2 + (CHSCREENWIDTH - btnWidth * 3) / 4, 8.f, btnWidth, btnHeight)];
    [foodClass addTarget:self action:@selector(foodClassClick) forControlEvents:UIControlEventTouchUpInside];
    [foodClass setImage:[UIImage imageNamed:@"question1"] forState: UIControlStateNormal];
    [v addSubview:foodClass];
    UILabel *classLabel = [[UILabel alloc] initWithFrame:CGRectMake(foodClass.x, foodClass.y + btnHeight + interval, btnWidth, 21.f)];
    classLabel.text = @"美食课堂";
    classLabel.font = [UIFont systemFontOfSize:16.f];
    classLabel.textAlignment = NSTextAlignmentCenter;
    [v addSubview:classLabel];
    
    //tableView的headerview是  V
    _eChatTableView.tableHeaderView = v;
    
    //segment
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"最新",@"最热",nil];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    CGFloat segmentW = 200.f;//segment的宽度
    CGFloat segmentH = 30.f; //高度
    
    CGFloat labelSegInterval = 12.f;
    segmentControl.frame = CGRectMake(CHSCREENWIDTH / 2 - segmentW/2, goodLabel.y + goodLabel.height + labelSegInterval, segmentW, segmentH);
    //设置默认索引序列
    segmentControl.selectedSegmentIndex = 0;
    segmentControl.tintColor = [UIColor redColor];
    
    [segmentControl addTarget:self action:@selector(segmentItenAction:) forControlEvents:UIControlEventValueChanged];
    [v addSubview:segmentControl];
    [self.view addSubview:self.eChatTableView];
}
- (void)googCookClick
{
    CHGoodCookViewController *goodCookVC = [[CHGoodCookViewController alloc] init];
    [self.navigationController pushViewController:goodCookVC animated:YES];
}
- (void)cateShowClick
{
    CHCateShowController *cateShowVC = [[CHCateShowController alloc] init];
    [self.navigationController pushViewController:cateShowVC animated:YES];
}
- (void)foodClassClick
{
    CHFoodClassViewController *foodClassVC = [[CHFoodClassViewController alloc] init];
    [self.navigationController pushViewController:foodClassVC animated:YES];
}
@end
