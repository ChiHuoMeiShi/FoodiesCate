//
//  CHRPublishNextViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublishNextViewController.h"
@interface CHRPublishNextViewController ()

@end

@implementation CHRPublishNextViewController

- (instancetype)initWithFoodDic:(NSDictionary *)foodDic withFoodName:(NSString *)foodName
{
    self = [super init];
    if (self) {
        self.foodName = foodName;
        self.foodDataDic = foodDic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑菜谱";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentRight withTittle:@"发布" withTittleColor:[UIColor redColor] withTarget:self action:@selector(publishFood) forControlEvents:UIControlEventTouchUpInside];
    
    self.detailFoodModel = [[CHRPublishFoodDetailModel alloc]init];
    
    [self.publicTableView registerNib:[UINib nibWithNibName:@"CHRPublicNextBaseFoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHRPublicNextBaseFoodTableViewCell"];
    [self.publicTableView registerNib:[UINib nibWithNibName:@"CHRPublicNextStepTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHRPublicNextStepTableViewCell"];
    
}

#pragma mark - ButtonAction
- (void)publishFood{
    [self showHUDWithText:@"抱歉,请完善数据" withTextFont:[UIFont systemFontOfSize:16.f] withTextColor:[UIColor whiteColor] withTextSize:CGSizeMake(MAXFLOAT, 0.f) withAction:@selector(testHud) withIsAnimated:YES];
    
}
- (void)takephoto:(CHRImageButton *)sender{
    self.choosedImagedButton = sender;
    [self imageTakePhoto];
}
- (void)addBaseFood{
    CHRPublicAddCellViewController * mainVC = [[CHRPublicAddCellViewController alloc]init];
    mainVC.delegate = self;
    [self.navigationController pushViewController:mainVC animated:YES];
}
- (void)addSupFood{
    CHRPublishSupCellViewController * supVC = [[CHRPublishSupCellViewController alloc]init];
    supVC.delegate = self;
    [self.navigationController pushViewController:supVC animated:YES];
}
- (void)addStepFood{
    
}
- (void)editStepFood{
    self.stepIsEdit = !self.stepIsEdit;
    if (self.stepIsEdit) {
        [self.stepFooterView.editButton setTitle:@"完成编辑" forState:UIControlStateNormal];
        return;
    }
    [self.stepFooterView.editButton setTitle:@"编辑步骤" forState:UIControlStateNormal];
}
- (void)foodDetailSave{
//    self.detailFoodModel
}
- (void)saveToFile{
    [self foodDetailSave];
    self.userDefault = [CHUserDefaults shareUserDefault];
    CHRPublishSave * saveModel = [[CHRPublishSave alloc]init];
    saveModel.foodName = self.foodName;
    saveModel.foodDic = self.foodDataDic;
    NSDate * date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'  'HH':'mm':'ss' 'Z'";
    saveModel.saveTime = [dateFormatter stringFromDate:date];
    saveModel.foodDetail = self.detailFoodModel;
    [self.userDefault.foodSaveArray addObject:saveModel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 280.f;
    }
    return 44.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 365.f;
    }else if (section == 4){
        return 355.f;
    }
    return 44.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 110.f;
    }else if (section == 3){
        return 90.f;
    }
    return 54.f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (!self.headerViewTop) {
            self.headerViewTop = [[[NSBundle mainBundle]loadNibNamed:@"CHRPublicNextHeaderTopView" owner:nil options:nil]lastObject];
            self.headerViewTop.nameLabel.text = self.foodName;
            [self.headerViewTop.photoButton addTarget:self action:@selector(takephoto:) forControlEvents:UIControlEventTouchUpInside];
        }
        return self.headerViewTop;
    }else if (section == 1){
        if (!self.headerViewSecond) {
            self.headerViewSecond= [[[NSBundle mainBundle]loadNibNamed:@"CHRPublicNextHeaderTittleView" owner:nil options:nil]lastObject];
        }
        return self.headerViewSecond;
    }else if (section == 2){
        if (!self.headerViewTopThird) {
            self.headerViewTopThird = [[[NSBundle mainBundle]loadNibNamed:@"CHRPublicNextHeaderTittleView" owner:nil options:nil]lastObject];
            self.headerViewTopThird.showLabel.text = @"辅料";
        }
        return self.headerViewTopThird;
    }else if (section == 3){
        if (!self.headerViewTopForth) {
            self.headerViewTopForth = [[[NSBundle mainBundle]loadNibNamed:@"CHRPublicNextHeaderAddStepView" owner:nil options:nil]lastObject];
        }
        return self.headerViewTopForth;
    }else{
        if (!self.headerViewTopLast) {
            self.headerViewTopLast = [[[NSBundle mainBundle]loadNibNamed:@"CHRPublicNextHeaderDetailView" owner:nil options:nil]lastObject];
            self.shareTextView = self.headerViewTopLast.shareTextView;
            self.shareTextView.delegate = self;
            self.shareTextView.returnKeyType = UIReturnKeyDone;
            [self.headerViewTopLast.takePhotoButton addTarget:self action:@selector(takephoto:) forControlEvents:UIControlEventTouchUpInside];
        }
        return self.headerViewTopLast;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        CHRPublicNextFooterStoryView * footerView = [[[NSBundle mainBundle]loadNibNamed:@"CHRPublicNextFooterStoryView" owner:nil options:nil]lastObject];
        self.storyTextView = footerView.showTextView;
        self.storyTextView.delegate = self;
        self.storyTextView.returnKeyType = UIReturnKeyDone;
        return footerView;
    }else if (section == 1){
        CHRPublicNextFooterAddBaseFoodView * footerView = [[[NSBundle mainBundle]loadNibNamed:@"CHRPublicNextFooterAddBaseFoodView" owner:nil options:nil]lastObject];
        [footerView.editButton addTarget:self action:@selector(addBaseFood) forControlEvents:UIControlEventTouchUpInside];
        return footerView;
    }else if (section == 2){
        CHRPublicNextFooterAddBaseFoodView * footerView = [[[NSBundle mainBundle]loadNibNamed:@"CHRPublicNextFooterAddBaseFoodView" owner:nil options:nil]lastObject];
        footerView.showLabel.text = @"添加辅料";
        [footerView.editButton addTarget:self action:@selector(addSupFood) forControlEvents:UIControlEventTouchUpInside];
        return footerView;
    }else if (section == 3){
        if (!self.stepFooterView) {
            self.stepFooterView = [[[NSBundle mainBundle]loadNibNamed:@"CHRPublicNextFooterAddStepView" owner:nil options:nil]lastObject];
            [self.stepFooterView.addButton addTarget:self action:@selector(addStepFood) forControlEvents:UIControlEventTouchUpInside];
            [self.stepFooterView.editButton addTarget:self action:@selector(editStepFood) forControlEvents:UIControlEventTouchUpInside];
        }
        return self.stepFooterView;
    }else{
        CHRPublicNextFooterSaveView * footerView = [[[NSBundle mainBundle]loadNibNamed:@"CHRPublicNextFooterSaveView" owner:nil options:nil]lastObject];
        [footerView.saveButton addTarget:self action:@selector(saveToFile) forControlEvents:UIControlEventTouchUpInside];
        return footerView;
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.detailFoodModel.mainFoodArray.count + 1;
    }else if (section == 2){
        return self.detailFoodModel.supFoodArray.count + 1;
    }else if (section == 3){
        return self.detailFoodModel.stepFoodArray.count + 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    edit step cell
    if (indexPath.section == 3) {
        CHRPublicNextBaseFoodTableViewCell * nextStepCell = [tableView dequeueReusableCellWithIdentifier:@"CHRPublicNextBaseFoodTableViewCell"];
        nextStepCell.namedTextField.delegate = self;
        nextStepCell.namedTextField.returnKeyType = UIReturnKeyDone;
        nextStepCell.stepTextField.delegate = self;
        nextStepCell.stepTextField.returnKeyType = UIReturnKeyDone;
        nextStepCell.orderButton.titleLabel.text = [NSString stringWithFormat:@"%zi",indexPath.row + 1];
        [nextStepCell.takephotoButton addTarget:self action:@selector(takephoto:) forControlEvents:UIControlEventTouchUpInside];
        if (indexPath.row < self.detailFoodModel.stepFoodArray.count) {
            
            
            
            
        }
        return nextStepCell;
    }
//    add mainFood Cell
    CHRPublicNextStepTableViewCell * nextFoodCell = [tableView dequeueReusableCellWithIdentifier:@"CHRPublicNextStepTableViewCell"];
    if (indexPath.section == 1) {
        if (indexPath.row < self.detailFoodModel.mainFoodArray.count) {
            nextFoodCell.foodModel = self.detailFoodModel.mainFoodArray[indexPath.row];
            nextFoodCell.showFoodLabel.textColor = [UIColor blackColor];
            nextFoodCell.showCountLabel.textColor = [UIColor blackColor];
            return nextFoodCell;
        }
        nextFoodCell.showFoodLabel.textColor = [UIColor lightGrayColor];
        nextFoodCell.showCountLabel.textColor = [UIColor lightGrayColor];
        return nextFoodCell;
    }else{//    add supFood cell
        if (indexPath.row < self.detailFoodModel.supFoodArray.count) {
            nextFoodCell.foodModel = self.detailFoodModel.supFoodArray[indexPath.row];
            nextFoodCell.showFoodLabel.textColor = [UIColor blackColor];
            nextFoodCell.showCountLabel.textColor = [UIColor blackColor];
            return nextFoodCell;
        }
        nextFoodCell.showFoodLabel.textColor = [UIColor lightGrayColor];
        nextFoodCell.showCountLabel.textColor = [UIColor lightGrayColor];
        return nextFoodCell;
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
    }
    return YES;
}
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}
#pragma mark - CHRPubAddSupFood
- (void)getSupCellName:(NSString *)name withCount:(NSString *)count{
    CHRPublishFoodMainFoodModel * supModel = [[CHRPublishFoodMainFoodModel alloc]init];
    supModel.name = name;
    supModel.count = count;
    [self.detailFoodModel.supFoodArray addObject:supModel];
    [self.publicTableView reloadData];
}
#pragma mark - CHRPubAddMainFood
- (void)getMainCellName:(NSString *)name withCount:(NSString *)count{
    CHRPublishFoodMainFoodModel * mainModel = [[CHRPublishFoodMainFoodModel alloc]init];
    mainModel.name = name;
    mainModel.count = count;
    [self.detailFoodModel.mainFoodArray addObject:mainModel];
    [self.publicTableView reloadData];
}



@end
