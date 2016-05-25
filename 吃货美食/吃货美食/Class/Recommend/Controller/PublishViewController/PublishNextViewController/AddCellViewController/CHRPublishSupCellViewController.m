//
//  CHRPublishSupCellViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/24.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublishSupCellViewController.h"

@interface CHRPublishSupCellViewController ()<UITextFieldDelegate>

@end

@implementation CHRPublishSupCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"辅料编辑";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTittle:@"完成" withTittleColor:[UIColor redColor] withTarget:self action:@selector(addFinish) forControlEvents:UIControlEventTouchUpInside];
    self.addNameTextField.delegate = self;
    self.addNameTextField.returnKeyType = UIReturnKeyDone;
    self.addCountTextField.delegate = self;
    self.addCountTextField.returnKeyType = UIReturnKeyDone;
}

- (void)addFinish{
    if ([self.addNameTextField.text isEqualToString:@""]|[self.addCountTextField.text isEqualToString:@""]) {
        [self showHUDWithText:@"请完善信息~" withTextFont:[UIFont systemFontOfSize:15.f] withTextColor:[UIColor redColor] withTextSize:CGSizeMake(320.f, 0.f) withAction:@selector(testHud) withIsAnimated:YES];
        return;
    }
    __weak typeof(self)mySelf = self;
    if (self.delegate && [self.delegate respondsToSelector:@selector(getSupCellName:withCount:)]) {
        [mySelf.delegate getSupCellName:mySelf.addNameTextField.text withCount:mySelf.addCountTextField.text];
    };
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
    }
    
    return YES;
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
