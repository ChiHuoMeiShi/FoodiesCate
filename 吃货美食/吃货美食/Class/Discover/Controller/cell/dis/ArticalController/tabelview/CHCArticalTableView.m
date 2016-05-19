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
@implementation CHCArticalTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
   
//        _tableViewTopScrollview=[[UIScrollView alloc]init];
//        _tableViewTopScrollview.backgroundColor=[UIColor purpleColor];
//        _tableViewTopScrollview.frame=CGRectMake(0, 0, self.width, 200);
//        _tableViewTopScrollview.contentSize=CGSizeMake(self.width*4, 0);
//         _tableViewTopScrollview.showsHorizontalScrollIndicator = YES;
//        _tableViewTopScrollview.pagingEnabled=YES;
//        [self.tableHeaderView addSubview:_tableViewTopScrollview];
//        [self addSubview:_tableViewTopScrollview ];

        [self registerNib:[UINib nibWithNibName:@"CHCArticalTableViewCell" bundle:nil]forCellReuseIdentifier:@"CHCArticalCell"];
    }
    return self;
}
#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CHCArticalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CHCArticalCell"];
        return cell;
}
#pragma mark --  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return 200;
}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    //最好写一个非常大的值，不然数据会做一些干扰
//    return 1000;
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 200;
//}


@end
