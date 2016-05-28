//
//  CHMyCollectController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHMyCollectController.h"
#import "CHPublishCookBookCell.h"
@interface CHMyCollectController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *mTableView;

@end

@implementation CHMyCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self addBarButtonItem];

    [self.view addSubview:self.mTableView];
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"CHPublishCookBookCell" bundle:nil] forCellReuseIdentifier:@"CHPublishCookBookCell"];
}
- (UITableView *)mTableView{
    if (!_mTableView) {
        _mTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        self.mTableView.delegate = self;
        self.mTableView.dataSource = self;
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
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CHPublishCookBookCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"CHPublishCookBookCell"];
    
    
    
    return myCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 123.f;
}
#pragma mark -- addBarButtonItem
- (void)addBarButtonItem{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
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
