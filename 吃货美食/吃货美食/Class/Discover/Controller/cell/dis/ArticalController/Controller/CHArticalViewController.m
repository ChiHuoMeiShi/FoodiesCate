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
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "ReusableView.h"
#import "CHLocation.h"
@interface CHArticalViewController ()<UIScrollViewDelegate>
{
     UIPageControl *_pageControl;
     UIScrollView *_tableViewTopScrollview;
}

@property (nonatomic,strong)UIScrollView *scrollerView;
@property(nonatomic,strong)CHCSegment *segment;
@property(nonatomic,strong)NSMutableArray *classesArr;

@property(nonatomic,strong)NSMutableArray *imagesArr;
@property(nonatomic,strong) NSMutableArray *tabelViewlistis_selectArr;
@property(nonatomic,strong) NSMutableArray *tabelViewlistArr;
@property(nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign) BOOL isDragging;
@property (nonatomic,assign)NSInteger pageNum;
@property(nonatomic,strong)CHCArticalTableView *tabelView;
@property(nonatomic,strong)UIScrollView *headscroll;
@property (nonatomic,strong)CHLocation * location;
@end

@implementation CHArticalViewController
- (void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tableviewTopUpDate
{
    
    
    for (int i=0; i<_tabelViewlistArr.count; i++) {
        ((CHCArticalTableView*)_tabelViewlistArr[i]).mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (self.segment.index == 0)
            {
                //饮食健康
                [self getArTicalDatawithcid:@""];
            }
            else if (self.segment.index == 1)
            {
                //          功能性调理
                [self getArTicalDatawithcid:@"10197"];
                //
            }
            else if (self.segment.index == 2)
            {
                //        人群膳食
                [self getArTicalDatawithcid:@"10252"];
                
            }
            else if (self.segment.index == 3)
            {
                //        疾病调理
                [self getArTicalDatawithcid:@"10159"];
            }
            else if (self.segment.index == 4)
            {
                //        脏腑调理
                [self getArTicalDatawithcid:@"10225"];
            }
            else
            {
                //        烹饪技巧
                [self getArTicalDatawithcid:@"10153"];
            }
            
            
        }];
        
    }
}
-(void)tableViewButtomUpDate
{
    
    for (int i=0; i<_tabelViewlistArr.count; i++) {
        ((CHCArticalTableView*)_tabelViewlistArr[i]).mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if (self.segment.index == 0)
            {
                //饮食健康
                [self getArTicalDatawithcid:@""];
            }
            else if (self.segment.index == 1)
            {
                //          功能性调理
                [self getArTicalDatawithcid:@"10197"];
                //
            }
            else if (self.segment.index == 2)
            {
                //        人群膳食
                [self getArTicalDatawithcid:@"10252"];
                
            }
            else if (self.segment.index == 3)
            {
                //        疾病调理
                [self getArTicalDatawithcid:@"10159"];
            }
            else if (self.segment.index == 4)
            {
                //        脏腑调理
                [self getArTicalDatawithcid:@"10225"];
            }
            else
            {
                //        烹饪技巧
                [self getArTicalDatawithcid:@"10153"];
            }
            
            
        }];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"饮食新闻";
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self getArTicalDatawithcid:@""];
    [self addSegment];
    [self addScrollerWithTableView];
    _segment.index=0;
   
    [self tableviewTopUpDate];
    [self tableViewButtomUpDate];
    
   
    

    
}


-(void)getArTicalDatawithcid:(NSString *)cid
{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/health_main.php?format=json";
    NSDictionary *parameters = @{@"lat" : @(self.location.lat),@"lon" : @(self.location.lon),@"source" : @"iphone",@"format" : @"json", @"cid" : cid,@"page":@"2"};
    
    [manger POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        CHLog(@"1111%@",responseObject);
        CHCArticalData *data=[CHCArticalData mj_objectWithKeyValues:responseObject];
        self.data=data;
        
        _classesArr=[[NSMutableArray alloc]init];
        for (CHCZhunTi_classes_list *model in self.data.classes) {
            [self.classesArr addObject:model.title];
        }
//        
//        _imagesArr=[[NSMutableArray alloc]init];
//        for (CHCTop_Images_list *imagesmodel in self.data.top_imgs ) {
//            [_imagesArr addObject:imagesmodel.photo];
//        }
//        
//        [self loadHeadImageView];

        
        
        if ([((CHCZhunTi_classes_list*)self.data.classes[0]).title isEqualToString:@"饮食健康"]&&[((CHCZhunTi_classes_list*)self.data.classes[0]).is_select isEqualToString:@"1"]) {
             [((CHCArticalTableView*) _tabelViewlistArr[0]).mj_header endRefreshing];
            ((CHCArticalTableView*) _tabelViewlistArr[0]).aData=data;
            [((CHCArticalTableView*) _tabelViewlistArr[0]) reloadData];
            [((CHCArticalTableView*) _tabelViewlistArr[0]).mj_footer endRefreshing];

        }
        
        else if ([((CHCZhunTi_classes_list*)self.data.classes[1]).title isEqualToString:@"功能性调理"]&&[((CHCZhunTi_classes_list*)self.data.classes[1]).is_select isEqualToString:@"1"]) {
            [((CHCArticalTableView*) _tabelViewlistArr[1]).mj_header endRefreshing];
            ((CHCArticalTableView*) _tabelViewlistArr[1]).aData=data;
            [((CHCArticalTableView*) _tabelViewlistArr[1]) reloadData];
             [((CHCArticalTableView*) _tabelViewlistArr[1]).mj_footer endRefreshing];
        }
        else if ([((CHCZhunTi_classes_list*)self.data.classes[2]).title isEqualToString:@"人群膳食"]&&[((CHCZhunTi_classes_list*)self.data.classes[2]).is_select isEqualToString:@"1"]) {
            [((CHCArticalTableView*) _tabelViewlistArr[2]).mj_header endRefreshing];
            ((CHCArticalTableView*) _tabelViewlistArr[2]).aData=data;
            [((CHCArticalTableView*) _tabelViewlistArr[2]) reloadData];
            [((CHCArticalTableView*) _tabelViewlistArr[2]).mj_footer endRefreshing];

        }
        
        else if ([((CHCZhunTi_classes_list*)self.data.classes[3]).title isEqualToString:@"疾病调理"]&&[((CHCZhunTi_classes_list*)self.data.classes[3]).is_select isEqualToString:@"1"]) {
            [((CHCArticalTableView*) _tabelViewlistArr[3]).mj_header endRefreshing];
            ((CHCArticalTableView*) _tabelViewlistArr[3]).aData=data;
            [((CHCArticalTableView*) _tabelViewlistArr[3]) reloadData];
            [((CHCArticalTableView*) _tabelViewlistArr[3]).mj_footer endRefreshing];

        }
        
        else if ([((CHCZhunTi_classes_list*)self.data.classes[4]).title isEqualToString:@"脏腑调理"]&&[((CHCZhunTi_classes_list*)self.data.classes[4]).is_select isEqualToString:@"1"]) {
            [((CHCArticalTableView*) _tabelViewlistArr[4]).mj_header endRefreshing];
            ((CHCArticalTableView*) _tabelViewlistArr[4]).aData=data;
            [((CHCArticalTableView*) _tabelViewlistArr[4]) reloadData];
            [((CHCArticalTableView*) _tabelViewlistArr[4]).mj_footer endRefreshing];

        }
        
        else if ([((CHCZhunTi_classes_list*)self.data.classes[5]).title isEqualToString:@"烹饪技巧"]&&[((CHCZhunTi_classes_list*)self.data.classes[5]).is_select isEqualToString:@"1"]) {
            [((CHCArticalTableView*) _tabelViewlistArr[5]).mj_header endRefreshing];
            ((CHCArticalTableView*) _tabelViewlistArr[5]).aData=data;
            [((CHCArticalTableView*) _tabelViewlistArr[5]) reloadData];
            [((CHCArticalTableView*) _tabelViewlistArr[5]).mj_footer endRefreshing];

        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)addSegment
{
    UIScrollView *headscroll = [[UIScrollView alloc] init];
    self.headscroll=headscroll;
    headscroll.frame = CGRectMake(0, 64, CHSCREENWIDTH, 30);
    headscroll.showsHorizontalScrollIndicator = NO;
    self.segment = [[CHCSegment alloc] initWithFrame:CGRectMake(0,0, CHSCREENWIDTH, 30) withItems:@[@"饮食健康", @"功能性调理", @"人群膳食",@"疾病调理",@"脏腑调理",@"烹饪技巧"]];
    _segment.segmentBgColor = [UIColor whiteColor];
    
    _segment.defaultPerColor = [UIColor blackColor];
    _segment.perColor = [UIColor redColor];
    _segment.frame = CGRectMake(0, 0, _segment.perWidth * _segment.items.count, 30);
    headscroll.contentSize = CGSizeMake(_segment.perWidth * _segment.items.count  , 0);
    [headscroll addSubview:_segment];
    
    typeof(self) myself = self;
    
    _segment.mycountBlock = ^(NSInteger a)
    {
        CGPoint point = {CHSCREENWIDTH * a ,0};
        
            if (myself.segment.index == 0)
            {
                //饮食健康
                [myself getArTicalDatawithcid:@""];
            }
            else if (myself.segment.index == 1)
            {
        //          功能性调理
        [myself getArTicalDatawithcid:@"10197"];
//
            }
            else if (myself.segment.index == 2)
            {
        //        人群膳食
                [myself getArTicalDatawithcid:@"10252"];
        
            }
            else if (myself.segment.index == 3)
            {
        //        疾病调理
            [myself getArTicalDatawithcid:@"10159"];
            }
            else if (myself.segment.index == 4)
            {
        //        脏腑调理
                [myself getArTicalDatawithcid:@"10225"];
            }
            else
            {
        //        烹饪技巧
             [myself getArTicalDatawithcid:@"10153"];
            }
        
        [UIView animateWithDuration:2 animations:^{
            myself.scrollerView.contentOffset = point;
        }];

//
    };

    
    [self.view addSubview:headscroll];
    

}
-(void)addScrollerWithTableView
{

    _scrollerView=[[UIScrollView alloc]init];
   _scrollerView.backgroundColor=[UIColor greenColor];
   _scrollerView.frame=CGRectMake(0,94, CHSCREENWIDTH, CHSCREENHEIGH-94);
    _scrollerView.scrollEnabled = NO;
    _scrollerView.contentSize=CGSizeMake(self.segment.items.count*CHSCREENWIDTH, CHSCREENHEIGH-94);
        _scrollerView.delegate=self;
    _scrollerView.pagingEnabled=YES;
    _scrollerView.showsHorizontalScrollIndicator = YES;
    _scrollerView.showsVerticalScrollIndicator = YES;
    
    
  [self.view addSubview:_scrollerView];
    
    _tabelViewlistArr=[[NSMutableArray alloc]init];
    for (int i=0;i<_segment.items.count; i++) {
        CHCArticalTableView *tabelView=[[CHCArticalTableView alloc]initWithFrame:CGRectMake(CHSCREENWIDTH*i,0, CHSCREENWIDTH, _scrollerView.frame.size.height) style:UITableViewStylePlain];
      
        self.tabelView=tabelView;
        
        MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshNormalHeader)];
        self.tabelView.mj_header=header;
        [self.tabelView addSubview:header];
        
        ReusableView *view=[[ReusableView alloc]init];
        _tabelView.tableHeaderView=view;
        [_scrollerView addSubview:tabelView];
        [_tabelViewlistArr addObject:tabelView];
        CHLog(@"eeeeeeeeeeeeeeee%lu",(unsigned long)_tabelViewlistArr.count);
       
    }
    
   

}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    self.pageNum = _scrollerView.contentOffset.x / CHSCREENWIDTH;
    _segment.index = self.pageNum;
    
    

}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

