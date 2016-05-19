//
//  CHCShiCaiTableView.m
//  吃货美食
//
//  Created by eric on 16/5/14.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCShiCaiTableView.h"
#import "CHCShiCaiTableViewCell.h"
#import <AFNetworking.h>

#import <MJExtension.h>
@implementation CHCShiCaiTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self=[super initWithFrame:frame style:style];
    if (self)
    {
        self.delegate=self;
        self.dataSource=self;
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
                       self.data2=data;
                   [self reloadData];
                   });
        
        
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                CHLog(@"%@",error);
            }];

    }
    return self;
}
#pragma mark-UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data2.obj.count;
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
    CHCSHiCaiObjData *shicaiData=(CHCSHiCaiObjData*)self.data2.obj[indexPath.section];
    
    shicaicell.shicai=shicaiData;
    return shicaicell;
}
#pragma mark-UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
@end
