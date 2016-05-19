//
//  CHFruitViewController.m
//  吃货美食
//
//  Created by eric on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHFruitViewController.h"
#import "UIView+JWFrame.h"
//#import "CHCShiCaiTableView.h"
#import <AFNetworking.h>

#import "CHCShiCaiData.h"
#import <MJExtension.h>
#import "CHCShiCaiTableViewCell.h"
@interface CHFruitViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_fruitTableView;
}
@property(nonatomic,strong)CHCShiCaiData *data1;

@end

@implementation CHFruitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blueColor];
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    NSString *nsurl=@"http://api.meishi.cc/v5/season_list.php?format=json";
    NSDictionary * dic =
    @{@"lat":@"",@"lon":@"",@"source":@"iphone",@"format":@"json",@"sct":@"1",@"page":@"1"};
    
    [manger POST:nsurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CHLog(@"1111%@",responseObject);
        
        dispatch_async(dispatch_get_main_queue(), ^
           {
               CHCShiCaiData *data3=[CHCShiCaiData mj_objectWithKeyValues:responseObject];
               self.data1=data3;
           [_fruitTableView reloadData];
           });
      
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
    }];

    _fruitTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-187+210) style:UITableViewStylePlain];
    _fruitTableView.delegate=self;
    _fruitTableView.dataSource=self;
    [self.view addSubview:_fruitTableView];
}
#pragma mark-UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data1.obj.count;
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
    CHCSHiCaiObjData *shicaiData=(CHCSHiCaiObjData*)self.data1.obj[indexPath.section];
    
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
