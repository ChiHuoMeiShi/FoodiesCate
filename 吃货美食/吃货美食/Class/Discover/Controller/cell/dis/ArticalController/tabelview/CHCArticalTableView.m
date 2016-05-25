//
//  CHCArticalTableView.m
//  吃货美食
//
//  Created by eric on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCArticalTableView.h"
#import "CHCArticalTableViewCell.h"
#import "UIView+JWFrame.h"
#import "CHCArticalWebViewView.h"
@implementation CHCArticalTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerNib:[UINib nibWithNibName:@"CHCArticalTableViewCell" bundle:nil]forCellReuseIdentifier:@"CHCArticalCell"];

        
    }
    return self;
}
#pragma mark -- UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     NSLog(@"hhhhhhhhhhhh%ld",_aData.list.count);
    return _aData.list.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CHCArticalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CHCArticalCell"];
    CHCTableVIewData_list *TableVIewData_list= (CHCTableVIewData_list*)self.aData.list[indexPath.section];
    cell.TableVIewData_list=TableVIewData_list;
        return cell;
}
#pragma mark --  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 200;
    }
     return 123;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHCTableVIewData_list * list  = (CHCTableVIewData_list*)self.aData.list[indexPath.section];
    CHCArticalWebViewView *view=[[CHCArticalWebViewView alloc]init];
    view.myid=list.myid;
    
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:view animated:YES completion:nil];

    
    
}
@end











//        [self getArTicalData];
//        [self reloadData];
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    //最好写一个非常大的值，不然数据会做一些干扰
//    return 1000;
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 200;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.00001;
//}

//-(void)getArTicalData
//{
//    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
//    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
//    NSString *kUrl = @"http://api.meishi.cc/v5/health_main.php?format=json";
//    NSDictionary *parameters = @{@"lat" : @"34.60519775425116",@"lon" : @"112.4231392332194",@"source" : @"iphone",@"format" : @"json", @"cid" : @"",@"page":@"2"};
//
//    [manger POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        CHLog(@"1111%@",responseObject);
//
//        CHCArticalData *data=[CHCArticalData mj_objectWithKeyValues:responseObject];
//        self.aData=data;
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
//
//}
//
