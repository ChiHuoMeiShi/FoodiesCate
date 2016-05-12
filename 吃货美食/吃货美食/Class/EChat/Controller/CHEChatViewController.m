//
//  CHEChatViewController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHEChatViewController.h"
#import "CHZSendEChatController.h"

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

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    CGFloat btnWidth = 80.f;
    CGFloat btnHeight = 80.f;
    UIButton *goodCook = [[UIButton alloc] initWithFrame:CGRectMake(CHSCREENWIDTH / 2 - btnWidth / 2, 8.f , btnWidth, btnHeight)];
    
    
//    [self.view addSubview:goodCook];
    _eChatTableView.tableHeaderView = v;

    [self.view addSubview:self.eChatTableView];
    //segment
//    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"最新",@"最热",nil];
//    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
//    CGFloat segmentW = 200.f;//segment的宽度
//    CGFloat segmentH = 40.f;//高度
//    
//    
//    segmentControl.frame = CGRectMake(CHSCREENHEIGH / 2 - segmentW, 64 + 8.f, segmentW, segmentH);
//    //设置默认索引序列
//    segmentControl.selectedSegmentIndex = 0;
//    segmentControl.tintColor = [UIColor redColor];
//    
//    [segmentControl addTarget:self action:@selector(segmentItenAction:) forControlEvents:UIControlEventValueChanged];
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


@end
