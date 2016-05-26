//
//  CHFiveCrealsViewController.m
//  吃货美食
//
//  Created by eric on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHFiveCrealsViewController.h"
//#import "CHCShiCaiTableView.h"
#import <AFNetworking.h>

#import "CHCShiCaiData.h"
#import <MJExtension.h>
#import "CHCShiCaiTableViewCell.h"
#import "CHRJSearchDetailViewController.h"
#import "CHRJSearchDetailViewController.h"
@interface CHFiveCrealsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_fiveCerealsTableView;
}
@property(nonatomic,strong)CHCShiCaiData *data;
@end

@implementation CHFiveCrealsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    NSString *nsurl=@"http://api.meishi.cc/v5/season_list.php?format=json";
    NSDictionary * dic =
    @{@"lat":@"",@"lon":@"",@"source":@"iphone",@"format":@"json",@"sct":@"4",@"page":@"1"};
    
    [manger POST:nsurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CHLog(@"1111%@",responseObject);
        
        dispatch_async(dispatch_get_main_queue(), ^
       {
           CHCShiCaiData *data=[CHCShiCaiData mj_objectWithKeyValues:responseObject];
           self.data=data;
           [_fiveCerealsTableView reloadData];
       });
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
    }];
    

   _fiveCerealsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-187+210) style:UITableViewStylePlain];
    _fiveCerealsTableView.scrollEnabled=YES;
    _fiveCerealsTableView.dataSource=self;
    _fiveCerealsTableView.delegate=self;
    [self.view addSubview:_fiveCerealsTableView];
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
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"枣(干)"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }
    if (indexPath.section==1) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"花生"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }
    if (indexPath.section==2) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"燕麦"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }
    
    if (indexPath.section==3) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"赤小豆"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }
    
    if (indexPath.section==4) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"玉米(鲜)"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }
    
    if (indexPath.section==5) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"绿豆"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }
    if (indexPath.section==6) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"小米"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }
    if (indexPath.section==7) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"黑豆"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }
    
    if (indexPath.section==8) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"开心果"];
        [self.navigationController pushViewController:seacchView animated:YES];
        
    }
    
    if (indexPath.section==9) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"黄豆"];
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
