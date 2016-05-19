//
//  CHMyPublishController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/18.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHMyPublishController.h"
#import "CHUserDefaults.h"
#import "ZTCookBookModel.h"
#import <MJExtension.h>
#import <MJRefresh.h>
@interface CHMyPublishController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _selectIndex;
}

@property(nonatomic,strong)ZTCookBookModel *cookBookModel;

@property(nonatomic,strong)UITableView *mTableView;



@end

@implementation CHMyPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];

    
    [self addHeader];
    [self getPublishData];
    
}
- (UITableView *)mTableView
{
    if (!_mTableView) {
        _mTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
    }
    return _mTableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == _selectIndex) {
        //用菜单模型的data.count
        return 10;
    }else
        //食话模型的count
        return 20;
    

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (0 == _selectIndex) {
        //加载菜单的cell
        static NSString *ID = @"ZTCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"测试数据------%ld",(long)indexPath.row];
        return cell;
    }
        //加载食话的cell
    static NSString *ID = @"ZTCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据------%ld",(long)indexPath.row];
    return cell;
    
}
#pragma mark -- GetPublishData
- (void)getPublishData{
    CHUserDefaults *userDefault = [CHUserDefaults shareUserDefault];
    CHHTTPRequestManager *myManager = [CHHTTPRequestManager manager];
    myManager.userRequest.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [myManager.userRequest.requestSerializer setAuthorizationHeaderFieldWithUsername:userDefault.email password:userDefault.password];
    NSString *url = @"http://api.meishi.cc/v5/my_recipe_new.php?format=json";
    NSDictionary *parameter = @{@"lat" : @"34.6049907522264",@"lon" : @"112.4229875834745",@"source" : @"iphone" ,@"format" : @"json",@"uid" : userDefault.user_id ,@"page":@"1"};
    __weak typeof(self) mySelf = self;
    [myManager.userRequest POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = (NSDictionary *)responseObject;
        CHLog(@"%@",dic);
        mySelf.cookBookModel = [ZTCookBookModel mj_objectWithKeyValues:dic];
        [mySelf.mTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
#pragma mark -- AddHeaderView
- (void)addHeader{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 46.f)];
    //tableView的headerview是  V
    _mTableView.tableHeaderView = v;
    //segment
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"菜谱",@"食话",nil];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    CGFloat segmentW = 300.f;//segment的宽度
    CGFloat segmentH = 30.f;//高度
    segmentControl.frame = CGRectMake(CHSCREENWIDTH / 2 - segmentW/2, 8, segmentW, segmentH);
    //设置默认索引序列
    segmentControl.selectedSegmentIndex = 0;
    segmentControl.tintColor = [UIColor redColor];
    
    [segmentControl addTarget:self action:@selector(segmentItenAction:) forControlEvents:UIControlEventValueChanged];
    [v addSubview:segmentControl];
    [self.view addSubview:self.mTableView];
}
- (void)segmentItenAction:(UISegmentedControl *)segment{
    
    _selectIndex = segment.selectedSegmentIndex;
    if (0 == _selectIndex) {
        //加载我发布的菜单
        
    }else if (1 == _selectIndex){
        //加载我发布的食话
        
    }
}
- (void)navBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
