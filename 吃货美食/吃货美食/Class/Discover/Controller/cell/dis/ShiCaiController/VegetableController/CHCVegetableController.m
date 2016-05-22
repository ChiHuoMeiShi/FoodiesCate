//
//  CHCVegetableController.m
//  吃货美食
//
//  Created by eric on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCVegetableController.h"
#import "UIView+JWFrame.h"
//#import "CHCShiCaiTableView.h"
#import <AFNetworking.h>

#import "CHCShiCaiData.h"
#import <MJExtension.h>
#import "CHCShiCaiTableViewCell.h"
#import "CHRJSearchDetailViewController.h"
@interface CHCVegetableController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_shuCaiTableView;
}
@property(nonatomic,strong)CHCShiCaiData *data;
@end

@implementation CHCVegetableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
//    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
//    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
//    NSString *nsurl=@"http://api.meishi.cc/v5/search_category.php?format=json";
//    NSDictionary * dic =
//    @{@"lat":@"",@"lon":@"",@"source":@"iphone",@"format":@"json",@"step":@"",@"kw":@"",@"page":@"1",@"q":@"西红柿",@"sort_sc":@"desc",@"sort":@"default",@"gy":@"",@"mt":@""};
//    
//    [manger POST:nsurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////        CHLog(@"1111%@",responseObject);
//      
////        dispatch_async(dispatch_get_main_queue(), ^
////           {
////               
////               
////           });
//        [_shuCaiTableView reloadData];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        CHLog(@"%@",error);
//    }];
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    NSString *nsurl=@"http://api.meishi.cc/v5/season_list.php?format=json";
    NSDictionary * dic =
    @{@"lat":@"",@"lon":@"",@"source":@"iphone",@"format":@"json",@"sct":@"2",@"page":@"1"};
    
    [manger POST:nsurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CHLog(@"1111%@",responseObject);
        
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           CHCShiCaiData *data=[CHCShiCaiData mj_objectWithKeyValues:responseObject];
                           self.data=data;
                           [_shuCaiTableView reloadData];
                       });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
    }];

   _shuCaiTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-187+75) style:UITableViewStylePlain];
    _shuCaiTableView.delegate=self;
    _shuCaiTableView.dataSource=self;
    [self.view addSubview:_shuCaiTableView];
    
}
#pragma mark-UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.obj.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHCShiCaiTableViewCell *shicaicell=[tableView dequeueReusableCellWithIdentifier:@"shicaicell"];
    if (!shicaicell)
    {
        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCShiCaiTableViewCell" owner:nil options:nil];
        shicaicell=arr[0];
        
    }
    CHCSHiCaiObjData *shicaiData=(CHCSHiCaiObjData*)self.data.obj[indexPath.section];
    
    shicaicell.shicai=shicaiData;
    return shicaicell;
}
#pragma mark-UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 137;
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
    if (indexPath.section==0) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"西红柿"];
        [self.navigationController pushViewController:seacchView animated:YES];

    }
    if (indexPath.section==1) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"豇豆"];
        [self.navigationController pushViewController:seacchView animated:YES];

    }
    if (indexPath.section==2) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"苦瓜"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }

    if (indexPath.section==3) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"杏鲍菇"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }

    if (indexPath.section==4) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"丝瓜"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }

    if (indexPath.section==5) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"茄子"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }
    if (indexPath.section==6) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"卷心菜"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }
    if (indexPath.section==7) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"黄瓜"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }

    if (indexPath.section==8) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"莴笋"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }

    if (indexPath.section==9) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"油麦菜"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }

    
   
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
