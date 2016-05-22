//
//  CHRPublishViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublishViewController.h"
#import "CHRPublishChooseTypeViewController.h"
#import "CHRPublicChooseTypeProtocol.h"
#import "CHRPublicShowTableViewCell.h"
#import "CHRPublishNextViewController.h"

@interface CHRPublishViewController ()<UITextFieldDelegate,CHRPublicChooseTypeProtocol>
@property (nonatomic,strong)NSArray * publishArray;
@property (nonatomic,strong)NSMutableDictionary * publishDic;
@property (nonatomic,strong)UITextField * nameTextField;

@property (weak, nonatomic) IBOutlet UITableView *publicTableView;

@end

@implementation CHRPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布菜谱";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTittle:@"下一步" withTittleColor:[UIColor redColor] withTarget:self action:@selector(publishNextAction) forControlEvents:UIControlEventTouchUpInside];
    self.publishArray = @[@"制作工艺",@"口味",@"难度",@"准备时间",@"烹饪时间",@"人数"];
    self.publishDic = [NSMutableDictionary dictionaryWithDictionary:@{@"制作工艺":@"",@"口味":@"",@"难度":@"",@"准备时间":@"",@"烹饪时间":@"",@"人数":@""}];
    [self.publicTableView registerNib:[UINib nibWithNibName:@"CHRPublicShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHRPublicShowTableViewCell"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)publishNextAction{
    if ([self.nameTextField.text isEqualToString:@""]) {
        [self showHUDWithText:@"抱歉,请完善数据" withTextFont:[UIFont systemFontOfSize:16.f] withTextColor:[UIColor whiteColor] withTextSize:CGSizeMake(MAXFLOAT, 0.f) withAction:@selector(testHud) withIsAnimated:YES];
        return;
    }
    [self.publishDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqual:@""]) {
            [self showHUDWithText:@"抱歉,请完善数据" withTextFont:[UIFont systemFontOfSize:16.f] withTextColor:[UIColor whiteColor] withTextSize:CGSizeMake(MAXFLOAT, 0.f) withAction:@selector(testHud) withIsAnimated:YES];
            return ;
        }
    }];
    [self.view endEditing:YES];
    CHRPublishNextViewController * nextVC = [[CHRPublishNextViewController alloc]initWithFoodDic:self.publishDic withFoodName:self.nameTextField.text];
    [self.navigationController pushViewController:nextVC animated:YES];
//    dispatch_after(0.5, dispatch_get_main_queue(), ^{
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy"]];
//        
//    });
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.publishArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CHRPublicShowTableViewCell * publishCell = [tableView dequeueReusableCellWithIdentifier:@"CHRPublicShowTableViewCell"];
    NSString * publicStr = self.publishArray[indexPath.row];
    publishCell.nameLabel.text = publicStr;
    NSDictionary * dataDic = [self.publishDic objectForKey:publicStr];
    if ([dataDic isEqual:@""]) {
        publishCell.showLabel.text = @"";
    }else{
        publishCell.showLabel.text = (NSString *)dataDic[@"tittle"];
    }
    return publishCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.nameTextField resignFirstResponder];
    CHRPublishChooseTypeViewController * chooseVC = [[CHRPublishChooseTypeViewController alloc]initWithChoosedType:(int)indexPath.row withTittleName:self.publishArray[indexPath.row]];
    chooseVC.delegate = self;
    [self.navigationController pushViewController:chooseVC animated:YES];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * showView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, CHSCREENWIDTH, 35.f)];
    if (!self.nameTextField) {
        self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(10.f, 0.f, CHSCREENWIDTH - 20.f, 30.f)];
        self.nameTextField.placeholder = @"请输入菜谱名称";
        self.nameTextField.delegate = self;
        self.nameTextField.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
    }
    [showView addSubview:self.nameTextField];
    return showView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - CHRPublicChooseTypeProtocol
- (void)choosedFoodDic:(NSDictionary *)dic withName:(NSString *)tittleName{
    [self.publishDic setObject:dic forKey:tittleName];
    [self.publicTableView reloadData];
}

@end
