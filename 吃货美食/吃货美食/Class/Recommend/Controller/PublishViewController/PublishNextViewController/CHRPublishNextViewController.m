//
//  CHRPublishNextViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/21.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRPublishNextViewController.h"

@interface CHRPublishNextViewController ()
@property (weak, nonatomic) IBOutlet UITableView *publicTableView;

@end

@implementation CHRPublishNextViewController

//- (void)takephoto{
//    [self imageTakePhoto];
//}

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
    
    [self.publicTableView registerNib:[UINib nibWithNibName:@"CHRPublicNextBaseFoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHRPublicNextBaseFoodTableViewCell"];
    [self.publicTableView registerNib:[UINib nibWithNibName:@"CHRPublicNextStepTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHRPublicNextStepTableViewCell"];
//    [self requestData];
    
}

//- (void)requestData{
//    NSString * url = @"http://api.meishi.cc/v5/shicaizucai_img.php?format=json";
//    NSDictionary * dic = @{@"lat":@(myLat),@"lon":@(myLon),@"source":@"iphone",@"format":@"json",@"sname":self.foodTextField.text};
//    __weak typeof(self)mySelf = self;
//    [self.afnManger.messageRequest POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary * dic = (NSDictionary *)responseObject;
//        //        CHLog(@"%@",dic[@"obj"]);
//        mySelf.dataArray = [CHAISearchFoodTableModel mj_objectArrayWithKeyValuesArray:dic[@"obj"]];
//        
//        [mySelf.baseFoodTableView reloadData];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        CHLog(@"%@",error);
//    }];
//}

//- (void)requestData{
//    NSString * url = @"http://api.meishi.cc/v5/upload_recipe_pic.php";
//    NSDictionary * dic = @{@"source":@"iphone",@"format":@"json",@"act":@"step_result",@"photos":@"photos",@"Size":@"51.74 KB (52984 bytes)",@"Content-Type":@"image/jpeg"};
//    __weak typeof(self)mySelf = self;
//    [self.afnManger.messageRequest POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary * dic = (NSDictionary *)responseObject;
//        CHLog(@"%@",dic);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        CHLog(@"%@",error);
//    }];
//}

- (void)publishFood{
    
    [self showHUDWithText:@"抱歉,请完善数据" withTextFont:[UIFont systemFontOfSize:16.f] withTextColor:[UIColor whiteColor] withTextSize:CGSizeMake(MAXFLOAT, 0.f) withAction:@selector(testHud) withIsAnimated:YES];
    
}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource


@end
