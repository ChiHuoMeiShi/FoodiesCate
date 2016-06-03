//
//  ReusableView.m
//  XUER
//
//  Created by scjy on 16/3/16.
//  Copyright © 2016年 陈栋武. All rights reserved.
//

#define  screenWidth [UIScreen mainScreen].bounds.size.width
#import "ReusableView.h"
@implementation ReusableView

- (void)awakeFromNib
{

}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
     
        
      

        _scrollView=[[UIScrollView alloc]init];
        _scrollView.frame=CGRectMake(0, 0, CHSCREENWIDTH, 200);
        _scrollView.contentSize=CGSizeMake(CHSCREENWIDTH*_imagesArr.count, 0);
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.pagingEnabled=YES;
        _scrollView.delegate=self;
        [self addSubview:_scrollView];
        [self getArTicalData];
        
        
        self.timer=[NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
        //获取当前的消息循环对象
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        //改变self.timer的优先级
        [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void)getArTicalData
{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSString *kUrl = @"http://api.meishi.cc/v5/health_main.php?format=json";
    NSDictionary *parameters = @{@"lat" : @(self.location.lat),@"lon" : @(self.location.lon),@"source" : @"iphone",@"format" : @"json", @"cid" : @"",@"page":@"2"};

    [manger POST:kUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        CHLog(@"1111%@",responseObject);

        CHCArticalData *data=[CHCArticalData mj_objectWithKeyValues:responseObject];
        self.data=data;
        _imagesArr=[[NSMutableArray alloc]init];
        for (CHCTop_Images_list *imagesmodel in self.data.top_imgs ) {
            [_imagesArr addObject:imagesmodel.photo];
           
        }

        [self addImageview];
        
        
        
        
        
        [self addSubview:_pageControl];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
    }];

}
-(void)addImageview
{
   
    for (int i=0;i< self.imagesArr.count; i++)
    {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*CHSCREENWIDTH, 0, CHSCREENWIDTH, 200)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.imagesArr[i]]];
        [_scrollView  addSubview:imageView];
    }
    _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(CHSCREENWIDTH/2-50, 150, 100, 40)];
    _pageControl.numberOfPages=_imagesArr.count;
    _pageControl.pageIndicatorTintColor=[UIColor  grayColor];
    _pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
    
}
/**
 *  此方法必须遵循代理
 *
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  
    _pageControl.currentPage=scrollView.contentOffset.x/screenWidth;
}


- (void)update:(NSTimer *)timer
{
    
    if (_isDragging == YES)
    {
      return ;
    }

    //每次执行这个方法的时候，都要让图片滚动到下一页
    //获取当前的UIPageControl的页码
    NSInteger page = _pageControl.currentPage;
    //判断是否到达最后
    if (page == _pageControl.numberOfPages - 1)
    {
        page = 0; //回到第一页
    }
    else
    {
        page++;
    }
    
    //用每页的宽度 * （页码 + 1）== 计算除了下一页的contentOffset.x
    CGFloat offsetX = page * _scrollView.frame.size.width;
    
    //设置scrollView的偏移量等于新的偏移值
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
  
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //停止计时器
    //调用invalidate来停止计时器，一旦计时器停止后，那么这个计时器就不可在重用了，下次必须重新创建一个新的计时器对象。
    [self.timer invalidate];
    
    //因为调用完毕
    self.timer = nil;
}

//实现拖拽完毕方法invalidate方法以后，这个计时器对象就已经废了，无法重用了。所以可以直接将self.timer设置为nil
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //重新启动计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(update:) userInfo:nil repeats:YES];
    
    //再次修改self.timer的优先级
    //修改self.timer的优先级与控件一样
    //获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //改变self.timer的优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}




@end
