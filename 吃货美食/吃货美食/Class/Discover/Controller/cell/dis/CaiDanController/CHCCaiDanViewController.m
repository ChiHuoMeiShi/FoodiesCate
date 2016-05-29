//
//  CHCCaiDanViewController.m
//  吃货美食
//
//  Created by eric on 16/5/12.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCCaiDanViewController.h"
#import "UIView+JWFrame.h"
#import <AFNetworking.h>
#import "CHCCaiDanTableViewCell.h"
#import "CHCCaiDandata.h"
#import <MJRefresh.h>
#import "CHCCaiDanWebViewController.h"
#import "CHLocation.h"
@interface CHCCaiDanViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *caiDanTableView;
@property(nonatomic,strong)CHCCaiDandata *data;
@property (nonatomic,strong)CHLocation * location;
@end

@implementation CHCCaiDanViewController
- (void)headerRefreshAction
{
    //    刷新
    [self.caiDanTableView.mj_header beginRefreshing];
    [self getUpToDateDataWithSource:@"iphone"];
    
}
- (void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"菜单";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];

    [self getUpToDateDataWithSource:@"iphone"];
       _caiDanTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,CHSCREENWIDTH, CHSCREENHEIGH) style:UITableViewStylePlain];
    _caiDanTableView.dataSource=self;
    _caiDanTableView.delegate=self;
    [self.view addSubview:_caiDanTableView];
    MJRefreshStateHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction)];
    self.caiDanTableView.mj_header=header;
    [self.caiDanTableView addSubview:header];

}

-(void)getUpToDateDataWithSource:(NSString*)source
{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/caidans_list1.php?format=json";
    NSDictionary *parameters = @{@"lat" : @(self.location.lat),@"lon" : @(self.location.lon),@"source" : source,@"format" : @"json", @"t" : @"1",@"page":@"1"};
    __weak typeof(self) myself=self;
    [manger POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CHLog(@"1111%@",responseObject);
     
     
              [self.caiDanTableView.mj_header endRefreshing];
            CHCCaiDandata *data=[CHCCaiDandata mj_objectWithKeyValues:responseObject];
              myself.data=data;
              [_caiDanTableView reloadData];
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
#pragma mark-UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.data.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHCCaiDanTableViewCell *caiDancell=[tableView dequeueReusableCellWithIdentifier:@"caiDancell"];
    if (!caiDancell)
    {
        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCCaiDanTableViewCell" owner:nil options:nil];
        caiDancell=arr[0];
        
    }
    CHCData_list *dataList=(CHCData_list*)self.data.data[indexPath.section];
    
    caiDancell.data_list=dataList;
    return caiDancell;
}
#pragma mark-UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 229;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHCCaiDanWebViewController *webview=[[CHCCaiDanWebViewController alloc]init];
    
//    
    CHCData_list *dataList=(CHCData_list*)self.data.data[indexPath.section];
    webview.rid=dataList.myid;
        [self presentViewController:webview animated:YES completion:nil];
}
//-(void)buttonClick:(id)sender
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

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
