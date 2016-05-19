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
@interface CHCCaiDanViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *caiDanTableView;
@property(nonatomic,strong)CHCCaiDandata *data;
@end

@implementation CHCCaiDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(8, 8, 46, 30);
    button.backgroundColor=[UIColor redColor];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTintColor:[UIColor greenColor]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self getUpToDateDataWithSource:@"iphone"];
   _caiDanTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height) style:UITableViewStylePlain];
    _caiDanTableView.dataSource=self;
    _caiDanTableView.delegate=self;
    [self.view addSubview:_caiDanTableView];

}

-(void)getUpToDateDataWithSource:(NSString*)source
{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/caidans_list1.php?format=json";
    NSDictionary *parameters = @{@"lat" : @"34.60519775425116",@"lon" : @"112.4231392332194",@"source" : source,@"format" : @"json", @"t" : @"1",@"page":@"1"};
    __weak typeof(self) myself=self;
    [manger POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CHLog(@"1111%@",responseObject);
        dispatch_async(dispatch_get_main_queue(), ^
          {
            CHCCaiDandata *data=[CHCCaiDandata mj_objectWithKeyValues:responseObject];
              myself.data=data;
              [_caiDanTableView reloadData];
          });
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
