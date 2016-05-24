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
    
    self.mainFoodArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.supFoodArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.stepFoodArray = [[NSMutableArray alloc]initWithCapacity:0];
    
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
    
}
- (void)addSupFood{
    
}
- (void)addStepFood{
    
}
- (void)editStepFood{
    self.stepIsEdit = !self.stepIsEdit;
    if (self.stepIsEdit) {
        self.editButton.titleLabel.text = @"完成编辑";
        return;
    }
    self.editButton.titleLabel.text = @"编辑步骤";
}
- (void)saveToFile{
    self.userDefault = [CHUserDefaults shareUserDefault];
    CHRPublishSave * dicTemp = [[CHRPublishSave alloc]init];
    dicTemp.foodName = self.foodName;
    dicTemp.foodDic = self.foodDataDic;
    NSDate * date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'  'HH':'mm':'ss' 'Z'";
    dicTemp.saveTime = [dateFormatter stringFromDate:date];
    [self.userDefault.foodSaveArray addObject:dicTemp];
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
        CHRPublicNextFooterAddStepView * footerView = [[[NSBundle mainBundle]loadNibNamed:@"CHRPublicNextFooterAddStepView" owner:nil options:nil]lastObject];
        [footerView.addButton addTarget:self action:@selector(addStepFood) forControlEvents:UIControlEventTouchUpInside];
        [footerView.editButton addTarget:self action:@selector(editStepFood) forControlEvents:UIControlEventTouchUpInside];
        self.editButton = footerView.editButton;
        return footerView;
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
        if (self.mainFoodArray.count <= 0) {
            return 1;
        }
        return self.mainFoodArray.count;
    }else if (section == 2){
        if (self.supFoodArray.count <= 0) {
            return 1;
        }
        return self.supFoodArray.count;
    }else if (section == 3){
        if (self.stepFoodArray.count <= 0) {
            return 1;
        }
        return self.stepFoodArray.count;
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
        if (self.stepFoodArray.count > 0) {
//            cell has edited
            return nextStepCell;
        }
        [nextStepCell.takephotoButton addTarget:self action:@selector(takephoto:) forControlEvents:UIControlEventTouchUpInside];
        return nextStepCell;
    }
//    add mainFood Cell
    CHRPublicNextStepTableViewCell * nextFoodCell = [tableView dequeueReusableCellWithIdentifier:@"CHRPublicNextStepTableViewCell"];
    if (indexPath.section == 1) {
        if (self.mainFoodArray.count > 0) {
            
            return nextFoodCell;
        }
        nextFoodCell.showFoodLabel.textColor = [UIColor lightGrayColor];
        nextFoodCell.showCountLabel.textColor = [UIColor lightGrayColor];
        return nextFoodCell;
    }
    //    add supFood cell
    if (self.mainFoodArray.count > 0) {
        
        return nextFoodCell;
    }
    nextFoodCell.showFoodLabel.textColor = [UIColor lightGrayColor];
    nextFoodCell.showCountLabel.textColor = [UIColor lightGrayColor];
    return nextFoodCell;
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

@end
