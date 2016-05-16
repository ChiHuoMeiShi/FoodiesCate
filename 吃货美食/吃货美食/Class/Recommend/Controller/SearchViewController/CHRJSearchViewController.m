//
//  CHRJSearchViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJSearchViewController.h"
#import "CHRJSearchView.h"
#import "CHRJSearchDetailViewController.h"
#import "CHRJSearchColViewCell.h"
@interface CHRJSearchViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)CHRJSearchView * searchView;
@property (nonatomic,strong)NSArray * searchArray;
@property (weak, nonatomic) IBOutlet UICollectionView *searchCollecyionView;

@end

@implementation CHRJSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTittle:@"取消" withTittleColor:[UIColor redColor] withTarget:self action:@selector(cancelSearchAction) forControlEvents:UIControlEventTouchUpInside];
    self.searchArray = @[@"猪肉",@"土豆",@"黄瓜",@"西红柿",@"吃什么",@"感冒",@"牛肉",@"川菜",@"补脑"];
    
    [self.searchCollecyionView registerNib:[UINib nibWithNibName:@"CHRJSearchColViewCell" bundle:nil] forCellWithReuseIdentifier:@"CHRJSearchColViewCell"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self recommdSearchBarSetWithRect:CGRectMake(10.f, 26.f, CHSCREENWIDTH - 10.f - 60.f, 30.f)];
    [self.searchView.showTextField becomeFirstResponder];
}


- (void)navBackAction{
    [self.searchView removeFromSuperview];
    self.searchView = nil;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchView.showTextField resignFirstResponder];
}

#pragma mark - SearchBar
- (void)searchButtonAction{
    CHRJSearchViewController * searchVC = [[CHRJSearchViewController alloc]init];
    [self.searchView removeFromSuperview];
    self.searchView = nil;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)recommdSearchBarSetWithRect:(CGRect)rect{
    self.searchView = [[[NSBundle mainBundle]loadNibNamed:@"CHRJSearchView" owner:nil options:nil]lastObject];
    self.searchView.frame = rect;
    [self.searchView.searchButton removeFromSuperview];
    self.searchView.searchButton = nil;
    self.searchView.showTextField.returnKeyType = UIReturnKeySearch;
    self.searchView.showTextField.delegate = self;
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.searchView];
    
}

- (void)cancelSearchAction{
    self.searchView.showTextField.text = @"";
    [self.searchView resignFirstResponder];
    [self.searchView removeFromSuperview];
    self.searchView = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendMessage{
    if ([self.searchView.showTextField.text isEqualToString:@""]) {
        return;
    }
    CHRJSearchDetailViewController * searchDetailVC = [[CHRJSearchDetailViewController alloc]initWithSearchName:self.searchView.showTextField.text];
    self.searchView.showTextField.text = @"";
    [self.searchView removeFromSuperview];
    self.searchView = nil;
    [self.navigationController pushViewController:searchDetailVC animated:YES];

}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        [self sendMessage];
    }
    
    return YES;
}
#pragma mark - UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.searchView.showTextField.text = self.searchArray[indexPath.row];
    [self sendMessage];
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * attributes = [NSDictionary dicOfTextAttributeWithFont:[UIFont systemFontOfSize:15.f] withTextColor:[UIColor lightGrayColor]];
    CGRect myRect = [self.searchArray[indexPath.row] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.f) options:NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    
    return CGSizeMake(myRect.size.width, 30.f);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.searchArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CHRJSearchColViewCell * searchCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHRJSearchColViewCell" forIndexPath:indexPath];
    searchCollectionCell.showLabel.text = self.searchArray[indexPath.row];
    
    return searchCollectionCell;
}

@end
