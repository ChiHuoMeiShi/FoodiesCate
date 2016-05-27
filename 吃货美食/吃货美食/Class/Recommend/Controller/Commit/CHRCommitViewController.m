//
//  CHRCommitViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/26.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRCommitViewController.h"
#import "CHRCommitCollectionViewCell.h"

@interface CHRCommitViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *commitCollection;
@property (weak, nonatomic) IBOutlet UITextField *detailCommitTextField;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (nonatomic,strong)NSArray * commitArray;

@end

@implementation CHRCommitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"建议";
    
    [self.commitButton.layer setBorderWidth:0.8f];
    [self.commitButton.layer setCornerRadius:5.f];
    [self.commitButton.layer setBorderColor:[UIColor orangeColor].CGColor];
    
    self.detailCommitTextField.returnKeyType = UIReturnKeySend;
    self.detailCommitTextField.delegate = self;
    
    self.commitArray = @[@"菜单不准",@"难度过大",@"不感兴趣",@"口味单一",@"图片错误",@"名称错误"];
    
    [self.commitCollection registerNib:[UINib nibWithNibName:@"CHRCommitCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CHRCommitCollectionViewCell"];
    
    [self.commitButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)sendButtonAction{
    [self showHUDWithText:@"建议发送成功" withTextFont:[UIFont systemFontOfSize:16.f] withTextColor:[UIColor whiteColor] withTextSize:CGSizeMake(2333.f, 0.f) withAction:@selector(testHud) withIsAnimated:YES];
    dispatch_after(0.5, dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy"]];
        [self navBackAction];
    });
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

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.commitArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CHRCommitCollectionViewCell * commitCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHRCommitCollectionViewCell" forIndexPath:indexPath];
    [commitCell.selectButton setTitle:self.commitArray[indexPath.row] forState:UIControlStateNormal];
    
    return commitCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellWidth = (CHSCREENWIDTH - 10.f * 4)/3;
    return CGSizeMake(cellWidth, 30.f);
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
