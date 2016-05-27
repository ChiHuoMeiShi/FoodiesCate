//
//  CHFruitViewTableVIew.m
//  吃货美食
//
//  Created by eric on 16/5/27.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHFruitViewTableVIew.h"
#import "CHCShiCaiTableViewCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "CHRJSearchDetailViewController.h"
@implementation CHFruitViewTableVIew
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self=[super initWithFrame:frame style:style];
    if (self)
    {
        self.delegate=self;
        self.dataSource=self;
        
        
    }
    return self;
}
#pragma mark-UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data2.obj.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHCShiCaiTableViewCell *shicaicell=[tableView dequeueReusableCellWithIdentifier:@"shicaicell"];
    if (!shicaicell)
    {
        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCShiCaiTableViewCell" owner:nil options:nil];
        shicaicell=arr[0];
        
    }
    CHCSHiCaiObjData *shicaiData=(CHCSHiCaiObjData*)self.data2.obj[indexPath.row];
    
    shicaicell.shicai=shicaiData;
    return shicaicell;
}
#pragma mark-UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"芒果"];
        [[self getSupVC].navigationController  pushViewController:seacchView animated:YES];
        
    }
    if (indexPath.row==1) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"哈密瓜"];
        [[self getSupVC].navigationController  pushViewController:seacchView animated:YES];
        
    }
    if (indexPath.row==2) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"火龙果"];
        [[self getSupVC].navigationController  pushViewController:seacchView animated:YES];

        
    }
    
    if (indexPath.row==3) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"甜瓜"];
        [[self getSupVC].navigationController  pushViewController:seacchView animated:YES];
        
    }
    
    if (indexPath.row==4) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"香蕉"];
        [[self getSupVC].navigationController  pushViewController:seacchView animated:YES];
        
    }
    
    if (indexPath.row==5) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"西瓜"];
        [[self getSupVC].navigationController  pushViewController:seacchView animated:YES];
    }
    if (indexPath.row==6) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"油桃"];
        [[self getSupVC].navigationController  pushViewController:seacchView animated:YES];

        
    }
    if (indexPath.row==7) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"桑葚"];
        [[self getSupVC].navigationController  pushViewController:seacchView animated:YES];
        
    }
    
    if (indexPath.row==8) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"苹果"];
        [[self getSupVC].navigationController  pushViewController:seacchView animated:YES];
        
    }
    
    if (indexPath.row==9) {
        CHRJSearchDetailViewController *seacchView=[[CHRJSearchDetailViewController alloc]initWithSearchName:@"葡萄"];
        [[self getSupVC].navigationController  pushViewController:seacchView animated:YES];
        
    }
}
//获得当前的UIViewController
- (UIViewController *)getSupVC
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
