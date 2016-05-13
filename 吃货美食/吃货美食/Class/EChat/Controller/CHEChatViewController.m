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
@interface CHEChatViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UITableView *eChatTableView;

@property(strong,nonatomic)CHEChatHeaderView *headerView;



@end

@implementation CHEChatViewController
- (void)returnTopicModel:(ReturnHotBlock)block
{
    self.hotBlock = block;
}
//
- (void)segmentItenAction:(UISegmentedControl *)segment
{
    NSInteger index = segment.selectedSegmentIndex;
    switch (index)
    {
        case 0:
            [self getEchatDataWithSort:@"time"];
            break;
        case 1:
            [self getEchatDataWithSort:@"hot"];
            
            break;
            
        default:
            break;
    }
}
//加载最新
- (void)loadNew{
    
}
//加载最热
- (void)loadHot{
    
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
//请求数据
- (void)getEchatDataWithSort:(NSString *)sort
{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/meishiquan_index4.php?format=json";
    NSDictionary *parameters = @{@"lat" : @"34.6049907522264",@"lon" : @"112.4229875834745",@"source" : @"iphone",@"format" : @"json", @"sort" : sort};
    [manger POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        self.echatModel = [EChatModel mj_objectWithKeyValues:dic];
        
        [self.eChatTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"失败原因%@",error)
    }];
    
}

//
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationItem];
    [self getEchatDataWithSort:@"time"];
    self.eChatTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];

    self.eChatTableView.delegate = self;
    self.eChatTableView.dataSource = self;
    self.eChatTableView.rowHeight = UITableViewAutomaticDimension;
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHEChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatCellReuse"];
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHTwoChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatTwoCellReuse"];
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHThreeChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatThreeCellReuse"];
    
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHTFourChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatFourCellReuse"];
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHFiveChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatFiveCellReuse"];
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHSixChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatSixCellReuse"];
    
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHSevenChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatSevenCellReuse"];
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHEightChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatEightCellReuse"];
    [self.eChatTableView registerNib:[UINib nibWithNibName:@"CHNineChatCell" bundle:nil] forCellReuseIdentifier:@"CHEChatNineCellReuse"];
    [self addHeaderView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.echatModel.hot_topic.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Hot_topocModel *hotModel = self.echatModel.hot_topic[indexPath.row];
    
    if ([hotModel.img_num intValue] == 1) {
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatCellReuse"];
        eChatCell.showhottopic = self.echatModel.hot_topic[indexPath.row];
        return eChatCell;
    } else if ([hotModel.img_num intValue] == 2){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatTwoCellReuse"];
        eChatCell.showhottopic = self.echatModel.hot_topic[indexPath.row];
        return eChatCell;
    } else if ([hotModel.img_num intValue] == 3){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatThreeCellReuse"];
        eChatCell.showhottopic = self.echatModel.hot_topic[indexPath.row];
        return eChatCell;
    } else if ([hotModel.img_num intValue] == 4){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatFourCellReuse"];
        eChatCell.showhottopic = self.echatModel.hot_topic[indexPath.row];
        return eChatCell;
    } else if ([hotModel.img_num intValue] == 5){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatFiveCellReuse"];
        eChatCell.showhottopic = self.echatModel.hot_topic[indexPath.row];
        return eChatCell;
    } else if ([hotModel.img_num intValue] == 6){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatSixCellReuse"];
        eChatCell.showhottopic = self.echatModel.hot_topic[indexPath.row];
        return eChatCell;
    } else if ([hotModel.img_num intValue] == 7){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatSevenCellReuse"];
        eChatCell.showhottopic = self.echatModel.hot_topic[indexPath.row];
        return eChatCell;
    } else if ([hotModel.img_num intValue] == 8){
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatEightCellReuse"];
        eChatCell.showhottopic = self.echatModel.hot_topic[indexPath.row];
        return eChatCell;
    }else if ([hotModel.img_num intValue] == 9)
    {
        CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatNineCellReuse"];
        eChatCell.showhottopic = self.echatModel.hot_topic[indexPath.row];
        return eChatCell;
    }
    CHEChatCell *eChatCell = [tableView dequeueReusableCellWithIdentifier:@"CHEChatCellReuse"];
    eChatCell.showhottopic = self.echatModel.hot_topic[indexPath.row];
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
    Hot_topocModel *hotModel = self.echatModel.hot_topic[indexPath.row];
    if ([hotModel.img_num intValue] == 1) {
        return 369.f;
    }else if ([hotModel.img_num intValue] > 1 && [hotModel.img_num intValue] < 4){
        return 247.f;
    }else if ([hotModel.img_num intValue] >= 4 && [hotModel.img_num intValue] < 7){
        return 335.f;
    }
    return 427.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- 添加headerView
- (void)addHeaderView
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    CGFloat btnWidth = 80.f;
    CGFloat btnHeight = 80.f;
    //中间
    UIButton *goodCook = [[UIButton alloc] initWithFrame:CGRectMake(CHSCREENWIDTH / 2 - btnWidth / 2, 8.f , btnWidth, btnHeight)];
    [goodCook setImage:[UIImage imageNamed:@"bake1"] forState:UIControlStateNormal];
    [goodCook addTarget:self action:@selector(googCookClick) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:goodCook];
    //左边
    UIButton *cateShow = [[UIButton alloc] initWithFrame:CGRectMake((CHSCREENWIDTH - btnWidth * 3) / 4, 8.f, btnWidth, btnHeight)];
    [cateShow addTarget:self action:@selector(cateShowClick) forControlEvents:UIControlEventTouchUpInside];
    [cateShow setImage:[UIImage imageNamed:@"zhms1"] forState:UIControlStateNormal];
    [v addSubview:cateShow];
    //右边
    UIButton *foodClass = [[UIButton alloc] initWithFrame:CGRectMake(CHSCREENWIDTH / 2 + btnWidth / 2 + (CHSCREENWIDTH - btnWidth * 3) / 4, 8.f, btnWidth, btnHeight)];
    [foodClass addTarget:self action:@selector(foodClassClick) forControlEvents:UIControlEventTouchUpInside];
    [foodClass setImage:[UIImage imageNamed:@"question1"] forState: UIControlStateNormal];
    [v addSubview:foodClass];
    
    //tableView的headerview是  V
    _eChatTableView.tableHeaderView = v;
    
    //segment
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"最新",@"最热",nil];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    CGFloat segmentW = 200.f;//segment的宽度
    CGFloat segmentH = 30.f;//高度
    
    
    segmentControl.frame = CGRectMake(CHSCREENWIDTH / 2 - segmentW/2, btnHeight + 18.f + 8.f, segmentW, segmentH);
    //设置默认索引序列
    segmentControl.selectedSegmentIndex = 0;
    segmentControl.tintColor = [UIColor redColor];
    
    [segmentControl addTarget:self action:@selector(segmentItenAction:) forControlEvents:UIControlEventValueChanged];
    [v addSubview:segmentControl];
    [self.view addSubview:self.eChatTableView];
}
- (void)googCookClick
{
    CHLog(@"点击了玩转烘焙");
}
- (void)cateShowClick
{
   CHLog(@"点击了餐桌时光");
}
- (void)foodClassClick
{
    CHLog(@"点击了美食课堂");
}
@end
