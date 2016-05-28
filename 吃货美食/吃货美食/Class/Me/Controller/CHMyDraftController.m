//
//  CHMyDraftController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHMyDraftController.h"
#import "CHDraftCell.h"
#import "CHUserDefaults.h"
#import "CHRPublishSave.h"

@interface CHMyDraftController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *mTableView;

@property (nonatomic,strong)NSMutableArray *dataArr;

@end


@implementation CHMyDraftController

- (UITableView *)mTableView{
    if (!_mTableView) {
        self.mTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        self.mTableView.delegate = self;
        self.mTableView.dataSource = self;
    }
    return _mTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.mTableView];
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"CHDraftCell" bundle:nil] forCellReuseIdentifier:@"CHDraftCell"];
    
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    self.dataArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.dataArr = [userDefault.foodSaveArray mutableCopy];
    
}
- (void)navBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CHDraftCell *draftCell = [tableView dequeueReusableCellWithIdentifier:@"CHDraftCell"];
    CHRPublishSave *publishSave = self.dataArr[indexPath.row];
    
    draftCell.contentLabel.text = publishSave.foodName;
    draftCell.timeLabel.text = publishSave.saveTime;
    draftCell.foodDic = publishSave.foodDic;
    if (publishSave.foodDetail) {
        NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        //    UIImage * photoIMG = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",docs[0],myImagePath]];
        
        NSString *imgPath = publishSave.foodDetail.storyIMGPath;
        draftCell.draftImage.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",docs[0],imgPath]];
    }
    
    return draftCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 101.f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
