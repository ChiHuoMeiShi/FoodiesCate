//
//  CHRJAISearchViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJAISearchViewController.h"

@interface CHRJAISearchViewController ()<UITextFieldDelegate>


@end

@implementation CHRJAISearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.afnManger = [CHHTTPRequestManager manager];
    [self.foodTextField becomeFirstResponder];
    self.foodTextField.delegate = self;
    self.foodTextField.returnKeyType = UIReturnKeySearch;
    
    [self.baseFoodTableView registerNib:[UINib nibWithNibName:@"CHAISearchShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHAISearchShowTableViewCell"];
    
    self.dataArray = [[NSMutableArray alloc]initWithCapacity:0];
}

- (IBAction)canelButtonAction:(UIButton *)sender {
    [self.foodTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)finishSetMessage{
    [self.view endEditing:YES];
    [self sendMessageSearch];
}

- (void)sendMessageSearch{
    [self requestData];
}

- (void)requestData{
    NSString * url = @"http://api.meishi.cc/v5/shicaizucai_img.php?format=json";
//    NSDictionary * dic = @{@"lat":@(myLat),@"lon":@(myLon),@"source":@"iphone",@"format":@"json",@"sname":self.foodTextField.text};
    NSDictionary * dic = @{@"lat":@(myLat),@"lon":@(myLon),@"source":@"iphone",@"format":@"json",@"sname":@"茄"};
    __weak typeof(self)mySelf = self;
    [self.afnManger.messageRequest POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
//        CHLog(@"%@",dic[@"obj"]);
        mySelf.dataArray = [CHAISearchFoodTableModel mj_objectArrayWithKeyValuesArray:dic[@"obj"]];
        
        [mySelf.baseFoodTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [self finishSetMessage];
    }else{
        [self sendMessageSearch];
    }
    return YES;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.foodTextField resignFirstResponder];
    CHAISearchFoodTableModel * model = self.dataArray[indexPath.row];
    __weak typeof(self)mySelf = self;
    if (self.delegate && [self.delegate respondsToSelector:@selector(getBaseFood:)]) {
        [mySelf.delegate  getBaseFood:model];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.f;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray) {
        return self.dataArray.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CHAISearchShowTableViewCell * aiSearchCell = [tableView dequeueReusableCellWithIdentifier:@"CHAISearchShowTableViewCell" forIndexPath:indexPath];
    aiSearchCell.foodModel = self.dataArray[indexPath.row];
    
    return aiSearchCell;
}


@end
