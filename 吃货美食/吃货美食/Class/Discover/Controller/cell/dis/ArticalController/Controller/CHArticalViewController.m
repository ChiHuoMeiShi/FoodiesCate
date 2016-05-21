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

@end

@implementation CHArticalViewController
-(void)RefreshNormalHeader
{
    [self.tabelView.mj_header beginRefreshing];
      [self getArTicalData];
}
- (void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];

    [self getArTicalData];
    
    MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(RefreshNormalHeader)];
    self.tabelView.mj_header=header;
    [self.tabelView addSubview:header];
}

-(void)addSegment
{
    UIScrollView *headscroll = [[UIScrollView alloc] init];

    headscroll.frame = CGRectMake(0, 64, self.view.width, 30);
    headscroll.showsHorizontalScrollIndicator = NO;
    
    self.segment = [[CHCSegment alloc] initWithFrame:CGRectMake(0,0, self.view.width, 30) withItems:self.classesArr];
    _segment.segmentBgColor = [UIColor whiteColor];
    
    _segment.defaultPerColor = [UIColor blackColor];
    _segment.perColor = [UIColor redColor];
    
    _segment.index = 0;
    _segment.frame = CGRectMake(0, 0, _segment.perWidth * _segment.items.count, 30);
    headscroll.contentSize = CGSizeMake(_segment.perWidth * _segment.items.count  , 0);
    [headscroll addSubview:_segment];
    
    [self.view addSubview:headscroll];
    

}
-(void)addScrollerWithTableView
{

    _scrollerView=[[UIScrollView alloc]init];
   _scrollerView.backgroundColor=[UIColor greenColor];
   _scrollerView.frame=CGRectMake(0,94, self.view.width, self.view.height-94);
    _scrollerView.contentSize=CGSizeMake(self.segment.items.count*self.view.width, self.view.height-94);
        _scrollerView.delegate=self;
    _scrollerView.pagingEnabled=YES;
    _scrollerView.showsHorizontalScrollIndicator = YES;
    _scrollerView.showsVerticalScrollIndicator = YES;
    
  [self.view addSubview:_scrollerView];
    
    for (int i=0;i<_segment.items.count; i++) {
        CHCArticalTableView *tabelView=[[CHCArticalTableView alloc]initWithFrame:CGRectMake(self.view.width*i,0, self.view.width, _scrollerView.frame.size.height) style:UITableViewStyleGrouped];
        self.tabelView=tabelView;
  
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
        _tableViewTopScrollview=[[UIScrollView alloc]init];
        _tableViewTopScrollview.frame=CGRectMake(0, 0, self.view.width, 200);
        _tableViewTopScrollview.contentSize=CGSizeMake(self.view.width*4, 0);
         _tableViewTopScrollview.showsHorizontalScrollIndicator = YES;
           _tableViewTopScrollview.pagingEnabled=YES;
        _tableViewTopScrollview.delegate=self;
        
//        [self addPagecontrol];
      
        for (int i=0;i< self.imagesArr.count; i++)
        {
            
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*self.view.width, 0, self.view.width, 200)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imagesArr[i]]];
            [_tableViewTopScrollview  addSubview:imageView];
        }

       
       
        [view addSubview:_tableViewTopScrollview];
        tabelView.tableHeaderView=view;
        
        [_scrollerView addSubview:tabelView];
        
        [self.tabelViewlistArr addObject:tabelView];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageNum = _scrollerView.contentOffset.x / _scrollerView.frame.size.width;
    _segment.index = self.pageNum;
    
//    _pageControl.currentPage=_tableViewTopScrollview.contentOffset.x/(self.view.width);
    

}

-(void)getArTicalData
{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/health_main.php?format=json";
    NSDictionary *parameters = @{@"lat" : @"34.60519775425116",@"lon" : @"112.4231392332194",@"source" : @"iphone",@"format" : @"json", @"cid" : @"",@"page":@"1"};
   
    [manger POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tabelView.mj_header endRefreshing];
        CHLog(@"1111%@",responseObject);
        //        NSDictionary *dict = (NSDictionary *)responseObject;
        //
        //        self.data = [CHCArticalData mj_objectWithKeyValues:dict];

        CHCArticalData *data=[CHCArticalData mj_objectWithKeyValues:responseObject];
           self.data=data;
        
        self.tabelView.data=data;
   
     
        _classesArr=[[NSMutableArray alloc]init];
        for (CHCZhunTi_classes_list *model in self.data.classes) {
            [self.classesArr addObject:model.title];
//            if ([model.is_select integerValue ]==1) {
//                
//            }
        }
        
        _imagesArr=[[NSMutableArray alloc]init];
        for (CHCTop_Images_list *imagesmodel in self.data.top_imgs ) {
            [_imagesArr addObject:imagesmodel.photo];
//            CHLog(@"%@",_imagesArr);
        }
        
       [self addSegment];
        [self addScrollerWithTableView];

        
        typeof(self) myself = self;
   
        _segment.mycountBlock = ^(NSInteger a){
            CGPoint point = {self.view.width * a ,0};
            
            [UIView animateWithDuration:2 animations:^{
                myself.scrollerView.contentOffset = point;
            }];
          
            
          
        };
        
        
        
       
      
       
   
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

@end
