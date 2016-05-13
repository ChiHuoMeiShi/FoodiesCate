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

@interface CHEChatViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UITableView *eChatTableView;

@property(strong,nonatomic)CHEChatHeaderView *headerView;

@end

@implementation CHEChatViewController

//
- (void)segmentItenAction:(UISegmentedControl *)segment
{
    NSInteger index = segment.selectedSegmentIndex;
    switch (index)
    {
        case 0:
            [self loadNew];
            break;
        case 1:
            [self loadHot];
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
    self.eChatTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];

    self.eChatTableView.delegate = self;
    self.eChatTableView.dataSource = self;

    [self addHeaderView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
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
#pragma mark -- UITableViewDelegate

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
    CGFloat segmentH = 40.f;//高度
    
    
    segmentControl.frame = CGRectMake(CHSCREENWIDTH / 2 - segmentW/2, btnHeight + 8.f + 8.f, segmentW, segmentH);
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
