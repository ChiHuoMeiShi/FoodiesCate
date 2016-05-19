//
//  CHRJAISearchViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJAISearchViewController.h"
#import "CHHTTPRequestManager.h"

@interface CHRJAISearchViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *foodTextField;
@property (weak, nonatomic) IBOutlet UITableView *baseFoodTableView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)CHHTTPRequestManager * afnManger;

@end

@implementation CHRJAISearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.afnManger = [CHHTTPRequestManager manager];
    [self.foodTextField becomeFirstResponder];
    self.foodTextField.delegate = self;
    self.foodTextField.returnKeyType = UIReturnKeySearch;
    
    self.dataArray = [[NSMutableArray alloc]initWithCapacity:0];
}

- (IBAction)canelButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)finishSetMessage{
    [self sendMessageSearch];
    [self.view endEditing:YES];
}

- (void)sendMessageSearch{
    [self requestData];
}

- (void)requestData{
    NSString * url = @"http://api.meishi.cc/v5/shicaizucai_img.php?format=json";
    NSDictionary * dic = @{@"lat":@(myLat),@"lon":@(myLon),@"source":@"iphone",@"format":@"json",@"sname":self.foodTextField.text};
    __weak typeof(self)mySelf = self;
    [self.afnManger.messageRequest POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        CHLog(@"%@",dic);
        
        [mySelf.baseFoodTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        [self finishSetMessage];
    }else{
        [self sendMessageSearch];
    }
    return YES;
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * aiSearchCell = [tableView dequeueReusableCellWithIdentifier:@"CHAISearchTableCell"];
    if (!aiSearchCell) {
        aiSearchCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CHAISearchTableCell"];
    }
    
    return aiSearchCell;
}


@end
