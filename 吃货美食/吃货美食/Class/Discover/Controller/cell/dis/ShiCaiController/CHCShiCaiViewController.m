//
//  CHCShiCaiViewController.m
//  吃货美食
//
//  Created by eric on 16/5/14.
//  Copyright © 2016年 赵天. All rights reserved.
//
#define W (CHSCREENWIDTH-10*3-60*2)/4
#import "CHCShiCaiViewController.h"
#import "CHCVegetableTableView.h"
#import "CHFruitViewTableVIew.h"
#import "CHMeatTableView.h"
#import "CHFiveCrealsViewTableView.h"
#import "UIView+JWFrame.h"
#import "CHLocation.h"
@interface CHCShiCaiViewController ()
{
    CHCVegetableTableView *_shuCaiTableView;
    
    CHFruitViewTableVIew *_ftuitTableView;
    CHMeatTableView *_meatTableView;
    CHFiveCrealsViewTableView *_fiveCrealsTableView;

}

@property (nonatomic,strong)CHLocation * location;
@end

@implementation CHCShiCaiViewController
- (void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
      [super viewDidLoad];
    self.title=@"当季食材";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton *vegetablebutton=[[UIButton alloc]initWithFrame:CGRectMake(60, CHSCREENHEIGH-45, W , 30)];
    [vegetablebutton setTitle:@"蔬菜" forState:UIControlStateNormal];
    [vegetablebutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
     [vegetablebutton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [vegetablebutton addTarget:self action:@selector(shuCai:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:vegetablebutton];
    UIButton *fruitbutton=[[UIButton alloc]initWithFrame:CGRectMake(60+W+10, CHSCREENHEIGH-45, W, 30)];
    [fruitbutton setTitle:@"水果" forState:UIControlStateNormal];
    [fruitbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fruitbutton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [fruitbutton addTarget:self action:@selector(fruit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fruitbutton];

    UIButton *meatablebutton=[[UIButton alloc]initWithFrame:CGRectMake(60+(W+10)*2, CHSCREENHEIGH-45, W, 30)];
    [meatablebutton setTitle:@"肉类" forState:UIControlStateNormal];
    [meatablebutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [meatablebutton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];

    [meatablebutton addTarget:self action:@selector(fruit:) forControlEvents:UIControlEventTouchUpInside];
    [meatablebutton addTarget:self action:@selector(meat:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:meatablebutton];

    UIButton *fiveCrealsbutton=[[UIButton alloc]initWithFrame:CGRectMake(60+(W+10)*3, CHSCREENHEIGH-15-30, W, 30)];
    [fiveCrealsbutton setTitle:@"五谷" forState:UIControlStateNormal];
   [fiveCrealsbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fiveCrealsbutton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];

    [fiveCrealsbutton addTarget:self action:@selector(fruit:) forControlEvents:UIControlEventTouchUpInside];
    [fiveCrealsbutton addTarget:self action:@selector(fiveCreals:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fiveCrealsbutton];

    
    
    
    _shuCaiTableView=[[CHCVegetableTableView alloc]initWithFrame:CGRectMake(0, 64, CHSCREENWIDTH,CHSCREENHEIGH-124) style:UITableViewStylePlain];
    
   _ftuitTableView=[[CHFruitViewTableVIew alloc]initWithFrame:CGRectMake(0, 64, CHSCREENWIDTH,CHSCREENHEIGH-124) style:UITableViewStylePlain];
   _meatTableView=[[CHMeatTableView alloc]initWithFrame:CGRectMake(0, 64, CHSCREENWIDTH,CHSCREENHEIGH-124) style:UITableViewStylePlain];
  _fiveCrealsTableView=[[CHFiveCrealsViewTableView alloc]initWithFrame:CGRectMake(0, 64, CHSCREENWIDTH,CHSCREENHEIGH-124) style:UITableViewStylePlain];
    
    
     [self.view addSubview:_shuCaiTableView];
    
    [self getDataWithSct:@"2"];
    
   
}
-(void)getDataWithSct:(NSString *)sct
{
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    NSString *nsurl=@"http://api.meishi.cc/v5/season_list.php?format=json";
    NSDictionary * dic =
    @{@"lat":@(self.location.lat),@"lon":@(self.location.lon),@"source":@"iphone",@"format":@"json",@"sct":sct,@"page":@"1"};
    
    [manger POST:nsurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CHLog(@"1111%@",responseObject);
        
             CHCShiCaiData *data=[CHCShiCaiData mj_objectWithKeyValues:responseObject];
        if ([((CHCSHiCaiObjData*)data.obj[0]).title isEqualToString:@"西红柿"]) {
            _shuCaiTableView.data2=data;
            [_shuCaiTableView reloadData];
        }
        if ([((CHCSHiCaiObjData*)data.obj[0]).title isEqualToString:@"芒果"]) {
            _ftuitTableView.data2=data;
            [_ftuitTableView reloadData];
        }
        if ([((CHCSHiCaiObjData*)data.obj[0]).title isEqualToString:@"牡蛎"]) {
            _meatTableView.data2=data;
            [_meatTableView reloadData];
        }
        if ([((CHCSHiCaiObjData*)data.obj[1]).title isEqualToString:@"花生"]) {
            _fiveCrealsTableView.data2=data;
            [_fiveCrealsTableView reloadData];
        }


        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
    }];
}
- (void)shuCai:(id)sender
{
      [self.view addSubview:_shuCaiTableView];
    [self getDataWithSct:@"2"];
}
- (void)fruit:(id)sender
{
    [self.view addSubview:_ftuitTableView];
    [self getDataWithSct:@"1"];
}
- (void)meat:(id)sender {
   [self.view addSubview:_meatTableView];
    [self getDataWithSct:@"3"];
}
- (void)fiveCreals:(id)sender {

     [self.view addSubview:_fiveCrealsTableView];
       [self getDataWithSct:@"4"];
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
//UIViewController *VC=_arrVC[3];
//if (![VC isEqual:_selectVC]) {
//    _selectVC.view.hidden=YES;
//    VC.view.hidden=NO;
//    _selectVC=VC;
//    _myView.hidden=NO;
//}
//UIViewController *vegetable =[[UIViewController alloc] init];
//UIViewController *fruit =[[UIViewController alloc] init];
//UIViewController *meat =[[UIViewController alloc] init];
//UIViewController *fiveCreals =[[UIViewController alloc] init];
////    vegetable.view.backgroundColor=[UIColor blueColor];
////    fruit.view.backgroundColor=[UIColor purpleColor];
////    meat.view.backgroundColor=[UIColor greenColor];
////    fiveCreals.view.backgroundColor=[UIColor grayColor];
//CHCVegetableController *vegetableController=[[CHCVegetableController alloc]init];
//CHFruitViewController *fruitViewController=[[CHFruitViewController alloc]init];
//CHCMeatViewController *meatViewController=[[CHCMeatViewController alloc]init];
//CHFiveCrealsViewController *fiveCrealsViewController=[[CHFiveCrealsViewController alloc]init];
//
////    vegetableController.tabBarController.view=self.myView;
//vegetable =vegetableController;
//vegetable.view.frame=CGRectMake(0, 64, CHSCREENWIDTH, CHSCREENHEIGH-187);
//[self.view addSubview:vegetable.view];
//[self addChildViewController:vegetable];
//
//
//
//fruit=fruitViewController;
//fruit.view.frame=CGRectMake(0,  64, CHSCREENWIDTH, CHSCREENHEIGH-187);
//[self.view addSubview:fruit.view];
//[self addChildViewController:fruit];
//
//meat=meatViewController;
//meat.view.frame=CGRectMake(0,  64, CHSCREENWIDTH, CHSCREENHEIGH-187);
//[self.view addSubview:meat.view];
//[self addChildViewController:meat];
//
//fiveCreals=fiveCrealsViewController;
//fiveCreals.view.frame=CGRectMake(0,  64, CHSCREENWIDTH, CHSCREENHEIGH-187);
//[self.view addSubview:fiveCreals.view];
//[self addChildViewController:fiveCreals];
//self.arrVC=@[vegetable,fruit,meat,fiveCreals];
//_selectVC=vegetable;
//fruit.view.hidden=YES;
//meat.view.hidden=YES;
//fiveCreals.view.hidden=YES;
//_myView.hidden=NO;

