//
//  CHCShiCaiViewController.m
//  吃货美食
//
//  Created by eric on 16/5/14.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHCShiCaiViewController.h"
#import "CHCVegetableController.h"
#import "CHFruitViewController.h"
#import "CHCMeatViewController.h"
#import "CHFiveCrealsViewController.h"
#import "UIView+JWFrame.h"
@interface CHCShiCaiViewController (){
    NSMutableArray *_dataArr;
    NSMutableDictionary *_dataDic;
    UIViewController *_selectVC;
}
@property(nonatomic,strong)NSArray *arrVC;
@end

@implementation CHCShiCaiViewController
- (void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];

    [super viewDidLoad];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(8, 8, 46, 30);
    button.backgroundColor=[UIColor redColor];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTintColor:[UIColor greenColor]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
  
    UIViewController *vegetable =[[UIViewController alloc] init];
    UIViewController *fruit =[[UIViewController alloc] init];
    UIViewController *meat =[[UIViewController alloc] init];
    UIViewController *fiveCreals =[[UIViewController alloc] init];
//    vegetable.view.backgroundColor=[UIColor blueColor];
//    fruit.view.backgroundColor=[UIColor purpleColor];
//    meat.view.backgroundColor=[UIColor greenColor];
//    fiveCreals.view.backgroundColor=[UIColor grayColor];
    CHCVegetableController *vegetableController=[[CHCVegetableController alloc]init];
    CHFruitViewController *fruitViewController=[[CHFruitViewController alloc]init];
    CHCMeatViewController *meatViewController=[[CHCMeatViewController alloc]init];
    CHFiveCrealsViewController *fiveCrealsViewController=[[CHFiveCrealsViewController alloc]init];

    vegetable =vegetableController;
    vegetable.view.frame=CGRectMake(0, 64, self.view.width, self.view.height-187);
    [self.view addSubview:vegetable.view];
    [self addChildViewController:vegetable];
    
    
    
    fruit=fruitViewController;
    fruit.view.frame=CGRectMake(0,  64, self.view.width, self.view.height-187);
    [self.view addSubview:fruit.view];
    [self addChildViewController:fruit];
    
        meat=meatViewController;
    meat.view.frame=CGRectMake(0,  64, self.view.width, self.view.height-187);
    [self.view addSubview:meat.view];
    [self addChildViewController:meat];

    fiveCreals=fiveCrealsViewController;
    fiveCreals.view.frame=CGRectMake(0,  64, self.view.width, self.view.height-187);
    [self.view addSubview:fiveCreals.view];
    [self addChildViewController:fiveCreals];
    self.arrVC=@[vegetable,fruit,meat,fiveCreals];
    _selectVC=vegetable;
    fruit.view.hidden=YES;
    meat.view.hidden=YES;
    fiveCreals.view.hidden=YES;

}

-(void)buttonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)shuCai:(id)sender {
    UIViewController *VC=_arrVC[0];
    if (![VC isEqual:_selectVC]) {
        _selectVC.view.hidden=YES;
        VC.view.hidden=NO;
        _selectVC=VC;
    }
}
- (IBAction)fruit:(id)sender {
    UIViewController *VC=_arrVC[1];
    if (![VC isEqual:_selectVC]) {
        _selectVC.view.hidden=YES;
        VC.view.hidden=NO;
        _selectVC=VC;
    }

}
- (IBAction)meat:(id)sender {
    UIViewController *VC=_arrVC[2];
    if (![VC isEqual:_selectVC]) {
        _selectVC.view.hidden=YES;
        VC.view.hidden=NO;
        _selectVC=VC;
    }

}
- (IBAction)fiveCreals:(id)sender {
    UIViewController *VC=_arrVC[3];
    if (![VC isEqual:_selectVC]) {
        _selectVC.view.hidden=YES;
        VC.view.hidden=NO;
        _selectVC=VC;
    }

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
