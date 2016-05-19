//
//  CHArticalViewController.m
//  吃货美食
//
//  Created by eric on 16/5/12.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHArticalViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "UIView+JWFrame.h"
#import "CHCSegment.h"
#import "CHCArticalTableView.h"
#import "CHCArtScrollerView.h"
@interface CHArticalViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *headscroll;
@property(nonatomic,strong)CHCSegment *segment;
@property(nonatomic,strong)NSMutableArray *classesArr;
@property(nonatomic,strong)CHCArtScrollerView *scrollerView;
@end

@implementation CHArticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _classesArr=[[NSMutableArray alloc]init];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(8, 8, 46, 30);
    button.backgroundColor=[UIColor redColor];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTintColor:[UIColor greenColor]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self getArTicalData];
    

}
-(void)addSegment
{
    _headscroll = [[UIScrollView alloc] init];
    _headscroll.delegate = self;
    _headscroll.frame = CGRectMake(0, 50, self.view.width, 30);
    _headscroll.showsHorizontalScrollIndicator = NO;
    
    self.segment = [[CHCSegment alloc] initWithFrame:CGRectMake(0,0, self.view.width, 30) withItems:self.classesArr];
    _segment.segmentBgColor = [UIColor whiteColor];
    
    _segment.defaultPerColor = [UIColor blackColor];
    _segment.perColor = [UIColor redColor];
    
    _segment.index = 0;
    _segment.frame = CGRectMake(0, 0, _segment.perWidth * _segment.items.count, 30);
    _headscroll.contentSize = CGSizeMake(_segment.perWidth * _segment.items.count  , 0);
    [_headscroll addSubview:_segment];
    
    [self.view addSubview:_headscroll];
    

}
-(void)addScrollerWithTableView
{
    
}
-(void)getArTicalData
{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/health_main.php?format=json";
    NSDictionary *parameters = @{@"lat" : @"34.60519775425116",@"lon" : @"112.4231392332194",@"source" : @"iphone",@"format" : @"json", @"cid" : @"",@"page":@"1"};
   
    [manger POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CHLog(@"1111%@",responseObject);
        //        NSDictionary *dict = (NSDictionary *)responseObject;
        //
        //        self.data = [CHCArticalData mj_objectWithKeyValues:dict];

        CHCArticalData *data=[CHCArticalData mj_objectWithKeyValues:responseObject];
           self.data=data;
        
        for (CHCZhunTi_classes_list *model in self.data.classes) {
            [self.classesArr addObject:model.title];
        }
        
        [self addSegment];
  //   [_zhuanTiTableView reloadData];
   
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}


-(void)buttonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
