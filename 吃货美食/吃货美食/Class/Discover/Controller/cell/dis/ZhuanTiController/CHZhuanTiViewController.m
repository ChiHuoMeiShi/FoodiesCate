//
//  CHZhuanTiViewController.m
//  吃货美食
//
//  Created by eric on 16/5/12.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHZhuanTiViewController.h"
#import <AFNetworking.h>
#import "CHCZhuanTiTableViewCell.h"
#import <MJExtension.h>
#import "CHCZhuanTiData.h"
#import <MJRefresh.h>
#import "CHCZhuantiWebViewController.h"
#import "CHLocation.h"
@interface CHZhuanTiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_zhuanTiTableView;
}
@property(nonatomic,strong)CHCZhuanTiData *data;
@property (nonatomic,strong)CHLocation * location;
@end

@implementation CHZhuanTiViewController
-(void)RefreshNormalHeader
{
    [_zhuanTiTableView.mj_header beginRefreshing];
    [self getZhuanTiData];
}
- (void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"专题";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];

    [self getZhuanTiData];
    _zhuanTiTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CHSCREENWIDTH,CHSCREENHEIGH) style:UITableViewStylePlain];
   _zhuanTiTableView.dataSource=self;
    _zhuanTiTableView.delegate=self;
    [self.view addSubview:_zhuanTiTableView];
    MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshNormalHeader)];
    _zhuanTiTableView.mj_header=header;
    [_zhuanTiTableView addSubview:header];
   
}
-(void)getZhuanTiData
{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/caidans_list1.php?format=json";
    NSDictionary *parameters = @{@"lat" : @(self.location.lat),@"lon" : @(self.location.lon),@"source" : @"iphone",@"format" : @"json", @"t" : @"3",@"uf":@"0",@"page":@"1"};
    __weak typeof(self) myself=self;
    [manger POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CHLog(@"1111%@",responseObject);
                  [_zhuanTiTableView.mj_header endRefreshing];
           CHCZhuanTiData *data=[CHCZhuanTiData mj_objectWithKeyValues:responseObject];
           myself.data=data;
           [_zhuanTiTableView reloadData];
  
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
#pragma mark-UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.data.data.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHCZhuanTiTableViewCell *zhuanTicell=[tableView dequeueReusableCellWithIdentifier:@"zhuanTicell"];
    if (!zhuanTicell)
    {
        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCZhuanTiTableViewCell" owner:nil options:nil];
        zhuanTicell=arr[0];
        
    }
    CHCZhuanTiData_list *dataList=(CHCZhuanTiData_list*)self.data.data[indexPath.section];
    
    zhuanTicell.zhuanTiData_list=dataList;
    
    return zhuanTicell;
}
#pragma mark-UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 353;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHCZhuantiWebViewController *webView=[[CHCZhuantiWebViewController alloc]init];
    CHCZhuanTiData_list *dataList=(CHCZhuanTiData_list*)self.data.data[indexPath.section];
    webView.f_s_type=dataList.f_s_type;
    [self.navigationController pushViewController:webView animated:YES];
}
-(void)buttonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
