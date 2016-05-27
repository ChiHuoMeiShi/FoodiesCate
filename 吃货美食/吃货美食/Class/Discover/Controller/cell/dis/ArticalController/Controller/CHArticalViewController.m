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
-(void)RefreshNormalHeader
{
    [self.tabelView.mj_header beginRefreshing];
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
        }
        
        else if ([((CHCZhunTi_classes_list*)self.data.classes[1]).title isEqualToString:@"功能性调理"]&&[((CHCZhunTi_classes_list*)self.data.classes[1]).is_select isEqualToString:@"1"]) {
            [((CHCArticalTableView*) _tabelViewlistArr[1]).mj_header endRefreshing];
            ((CHCArticalTableView*) _tabelViewlistArr[1]).aData=data;
            [((CHCArticalTableView*) _tabelViewlistArr[1]) reloadData];
        }
        else if ([((CHCZhunTi_classes_list*)self.data.classes[2]).title isEqualToString:@"人群膳食"]&&[((CHCZhunTi_classes_list*)self.data.classes[2]).is_select isEqualToString:@"1"]) {
            [((CHCArticalTableView*) _tabelViewlistArr[2]).mj_header endRefreshing];
            ((CHCArticalTableView*) _tabelViewlistArr[2]).aData=data;
            [((CHCArticalTableView*) _tabelViewlistArr[2]) reloadData];
        }
        
        else if ([((CHCZhunTi_classes_list*)self.data.classes[3]).title isEqualToString:@"疾病调理"]&&[((CHCZhunTi_classes_list*)self.data.classes[3]).is_select isEqualToString:@"1"]) {
            [((CHCArticalTableView*) _tabelViewlistArr[3]).mj_header endRefreshing];
            ((CHCArticalTableView*) _tabelViewlistArr[3]).aData=data;
            [((CHCArticalTableView*) _tabelViewlistArr[3]) reloadData];
        }
        
        else if ([((CHCZhunTi_classes_list*)self.data.classes[4]).title isEqualToString:@"脏腑调理"]&&[((CHCZhunTi_classes_list*)self.data.classes[4]).is_select isEqualToString:@"1"]) {
            [((CHCArticalTableView*) _tabelViewlistArr[4]).mj_header endRefreshing];
            ((CHCArticalTableView*) _tabelViewlistArr[4]).aData=data;
            [((CHCArticalTableView*) _tabelViewlistArr[4]) reloadData];
        }
        
        else if ([((CHCZhunTi_classes_list*)self.data.classes[5]).title isEqualToString:@"烹饪技巧"]&&[((CHCZhunTi_classes_list*)self.data.classes[5]).is_select isEqualToString:@"1"]) {
            [((CHCArticalTableView*) _tabelViewlistArr[5]).mj_header endRefreshing];
            ((CHCArticalTableView*) _tabelViewlistArr[5]).aData=data;
            [((CHCArticalTableView*) _tabelViewlistArr[5]) reloadData];
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
//    滑动需要判断
//    if (self.segment.index == 0)
//    {
//        //饮食健康
//        [self getArTicalDatawithcid:@""];
//    }
//    else if (self.segment.index == 1)
//    {
//        //          功能性调理
//        [self getArTicalDatawithcid:@"10197"];
//        //
//    }
//    else if (self.segment.index == 2)
//    {
//        //        人群膳食
//        [self getArTicalDatawithcid:@"10252"];
//
//    }
//    else if (self.segment.index == 3)
//    {
//        //        疾病调理
//        [self getArTicalDatawithcid:@"10159"];
//    }
//    else if (self.segment.index == 4)
//    {
//        //        脏腑调理
//        [self getArTicalDatawithcid:@"10225"];
//    }
//    else
//    {
//        //        烹饪技巧
//        [self getArTicalDatawithcid:@"10153"];
//    }


//- (void)loadHeadImageView{
//    
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
//    _tableViewTopScrollview=[[UIScrollView alloc]init];
//    _tableViewTopScrollview.frame=CGRectMake(0, 0, self.view.width, 200);
//    _tableViewTopScrollview.contentSize=CGSizeMake(self.view.width*4, 0);
//    _tableViewTopScrollview.showsHorizontalScrollIndicator = YES;
//    _tableViewTopScrollview.pagingEnabled=YES;
//    _tableViewTopScrollview.delegate=self;
//    for (int i=0;i< self.imagesArr.count; i++)
//    {
//        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*self.view.width, 0, self.view.width, 200)];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:self.imagesArr[i]]];
//        [_tableViewTopScrollview  addSubview:imageView];
//    }
//    
//    _tabelView.backgroundColor=[UIColor redColor];
//    [view addSubview:_tableViewTopScrollview];
//    
//    _tabelView.tableHeaderView=view;
//    
//}








////根据self.segment.selectIdx来确定请求的数据
////调用场合：1，默认调用一次 2，当点击segment调用一次 3，当滑动tableView的时候调用一次
//- (void)showTableViewData:(NSMutableArray*)tabelViewlistArr{
//    if (self.segment.index == 0)
//    {
//        //饮食健康
//        [self getArTicalDatawithcid:@""];
//    }
//    else if (self.segment.index == 1)
//    {
////          功能性调理
//        [self getArTicalDatawithcid:@"10197"];
//    }
//    else if (self.segment.index == 2)
//    {
////        人群膳食
//        [self getArTicalDatawithcid:@"10252"];
//
//    }
//    else if (self.segment.index == 3)
//    {
////        疾病调理
//    [self getArTicalDatawithcid:@"10159"];
//    }
//    else if (self.segment.index == 4)
//    {
////        脏腑调理
//        [self getArTicalDatawithcid:@"10225"];
//    }
//    else
//    {
////        烹饪技巧
//     [self getArTicalDatawithcid:@"10153"];
//    }
//}








//    if ((_segment.index=0)) {
//        //饮食健康
//        [self getArTicalDatawithcid:@""];
//    }
////
//    if ((_segment.index=1)) {
//          [self getArTicalDatawithcid:@"10197"];
//    }
//    //饮食健康
//    [self getArTicalDatawithcid:@""];

////  功能性调理
//        [self getArTicalDatawithcid:@"10197"];
//////    人群膳食
//    [self getArTicalDatawithcid:@"10252"];
//////    疾病调理
//   [self getArTicalDatawithcid:@"10159"];
//////    脏腑调理
//     [self getArTicalDatawithcid:@"10225"];
//////    烹饪技巧
//    [self getArTicalDatawithcid:@"10153"];


//- (void)segmentSetWithIndex:(NSInteger)integer
//{
//    if (integer==1) {
//        ////  功能性调理
//                [self getArTicalDatawithcid:@"10197"];
//        //////    人群膳食
//        //    [self getArTicalDatawithcid:@"10252"];
//        //////    疾病调理
//        //   [self getArTicalDatawithcid:@"10159"];
//        //////    脏腑调理
//        //     [self getArTicalDatawithcid:@"10225"];
//        //////    烹饪技巧
//        //    [self getArTicalDatawithcid:@"10153"];
//
//    }
//   else if (integer==2) {
//        [self getArTicalDatawithcid:@"10252"];
//    }
//    else if (integer==3) {
//        [self getArTicalDatawithcid:@"10159"];
//    }
//   else  if (integer==4) {
//        [self getArTicalDatawithcid:@"10225"];
//    }
//    else if (integer==5)
//    {
//         [self getArTicalDatawithcid:@"10153"];
//    }
//}






















//-(void)RefreshNormalHeader
//{
//    [self.tabelView.mj_header beginRefreshing];
//      [self getArTicalDatawithcid:@""];
//}

//    MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshNormalHeader)];
//    self.tabelView.mj_header=header;
//    [self.tabelView addSubview:header];

//-(void)addPagecontrol
//{
//    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(170, 160, 100, 40)];
//    _pageControl.numberOfPages=self.imagesArr.count;
//    _pageControl.pageIndicatorTintColor=[UIColor  redColor];
//    _pageControl.currentPageIndicatorTintColor=[UIColor blueColor];
//    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
//    //获取当前的消息循环对象
//    NSRunLoop *runloop=[NSRunLoop currentRunLoop];
//    //改变self.timer的优先级
//    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
//    [self.view addSubview:_pageControl];
//
//}
//- (void)update:(NSTimer *)timer
//{
//
//    if (_isDragging == YES)
//    {
//        return ;
//    }
//
//    //每次执行这个方法的时候，都要让图片滚动到下一页
//    //获取当前的UIPageControl的页码
//    NSInteger page = _pageControl.currentPage;
//    //判断是否到达最后
//    if (page == _pageControl.numberOfPages - 1)
//    {
//        page = 0; //回到第一页
//    }
//    else
//    {
//        page++;
//    }
//
//    //用每页的宽度 * （页码 + 1）== 计算除了下一页的contentOffset.x
//    CGFloat offsetX = page * _tableViewTopScrollview.width;
//
//    //设置scrollView的偏移量等于新的偏移值
//    [_tableViewTopScrollview setContentOffset:CGPointMake(offsetX, 0) animated:YES];
//
//
//}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    //停止计时器
//    //调用invalidate来停止计时器，一旦计时器停止后，那么这个计时器就不可在重用了，下次必须重新创建一个新的计时器对象。
//    [self.timer invalidate];
//
//    //因为调用完毕
//    self.timer = nil;
//}
////实现拖拽完毕方法invalidate方法以后，这个计时器对象就已经废了，无法重用了。所以可以直接将self.timer设置为nil
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    //重新启动计时器
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(update:) userInfo:nil repeats:YES];
//
//    //再次修改self.timer的优先级
//    //修改self.timer的优先级与控件一样
//    //获取当前的消息循环对象
//    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//    //改变self.timer的优先级
//    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//- (void)segmentItenAction:(UISegmentedControl *)segment
//{
//    NSInteger index = segment.selectedSegmentIndex;
//    //最新
//    if (0 == index)
//    {
//         [self getArTicalDatawithcid:@""];
////        __weak typeof(self) mSelf = self;
////        //下拉刷新
////        mSelf.eChatTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
////            [mSelf getEchatDataWithSort:@"time"];
////        }];
////        //上拉刷新
////        mSelf.eChatTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
////            [mSelf upRequestDataWithSort:@"time"];
////        }];
//    }
//    //最热
//    else if (1 == index){
//       [self getArTicalDatawithcid:@"10197"];
////        __weak typeof(self) mSelf = self;
////        //下拉刷新
////        mSelf.eChatTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
////            [self getEchatDataWithSort:@"hot"];
////        }];
////        //上拉刷新
////        mSelf.eChatTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
////            [mSelf upRequestDataWithSort:@"hot"];
////        }];
//    }
//
//}

