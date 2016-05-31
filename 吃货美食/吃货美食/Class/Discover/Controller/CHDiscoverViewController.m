//
//  CHDiscoverViewController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//
#define W  (CHSCREENWIDTH-11*5)/4
#import <AFNetworking.h>
#import "CHDiscoverViewController.h"
#import "UIView+JWFrame.h"

#import <MJExtension.h>
#import "CHCFindData.h"
#import "CHCDiscoverTableViewcell.h"
#import "CHClickTableViewCell.h"
#import "CHCCommentTableViewCell.h"
#import "CHCActivityTableViewCell.h"
#import "CHCArticalCell.h"
#import "CHCaiDanCell.h"
#import "CHRecipesCell.h"
#import "CHTopInfoCell.h"
#import "CHZTCell.h"
#import "CHVGoods_infoTableViewCell.h"

#import "CHCShiCaiViewController.h"
#import "CHCCaiDanViewController.h"
#import "CHZhuanTiViewController.h"
#import "CHArticalViewController.h"
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>

#import "Topic_List.h"

#import "CHCaiViewController.h"
#import "CHCFaXianDetailViewController.h"
#import "CHzt_infoWebViewController.h"
#import "CHCWenZhanViewController.h"
#import "CHLocation.h"
@interface CHDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *_mytableView;
}
@property(nonatomic,strong)CHCFindData *data;
@property(nonatomic,strong) CHCfaxian_list * faxianCelllist;
@property (nonatomic,strong)CHLocation * location;
@property (nonatomic,assign) int page;
@end
@implementation CHDiscoverViewController
- (void)headerRefreshAction
{
    //    刷新
    [_mytableView.mj_header beginRefreshing];
    [self getTableViewData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.title=@"发现";
    [self getTableViewData];
    [self CreatTableView];
     MJRefreshStateHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction)];
     _mytableView.mj_header=header;
       [_mytableView addSubview:header];
    

    
    _mytableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       [self getTableViewDataWithButtom];
    }];


}
-(void)getTableViewDataWithButtom
{
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    NSString *nsurl=@"http://api.meishi.cc/v5/faxian_new.php?format=json";
    NSDictionary * dic =
    @{@"lat":@(self.location.lat),@"lon":@(self.location.lon),@"source":@"iphone",@"format":@"json",@"page":@"",@"timestamp":@"",@"rid":@""};
    __weak typeof(self) mySelf=self;
    [manger POST:nsurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [_mytableView.mj_footer endRefreshing];
        CHCFindData *data=[CHCFindData mj_objectWithKeyValues:responseObject];
        [mySelf.data.faxian_list addObjectsFromArray:data.faxian_list];
        [_mytableView reloadData];
        
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         [_mytableView.mj_footer endRefreshing];
    }];
}
//上拉刷新
-(void)getTableViewData
{
    self.page = 1;
    self.page = self.page + 1;
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    NSString *nsurl=@"http://api.meishi.cc/v5/faxian_new.php?format=json";
    NSDictionary * dic =
  @{@"lat":@(self.location.lat),@"lon":@(self.location.lon),@"source":@"iphone",@"format":@"json",@"page":@(self.page),@"timestamp":@"",@"rid":@""};
     __weak typeof(self) mySelf=self;
    [manger POST:nsurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [_mytableView.mj_header endRefreshing];
        CHCFindData *data=[CHCFindData mj_objectWithKeyValues:responseObject];
        mySelf.data=data;
        _mytableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_mytableView reloadData];
        
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
        [_mytableView.mj_header endRefreshing];
    }];
    
}
-(void)CreatTableView
{
    _mytableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CHSCREENWIDTH, CHSCREENHEIGH) style:UITableViewStylePlain];
    
    _mytableView.delegate=self;
    _mytableView.dataSource=self;
    _mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registReuseCell];
    [self.view addSubview:_mytableView];

}
#pragma mark -- 注册Cell
- (void)registReuseCell
{
    [_mytableView registerNib:[UINib nibWithNibName:@"CHCDiscoverTableViewcell" bundle:nil] forCellReuseIdentifier:@"CDCdiscell"];
    [_mytableView registerNib:[UINib nibWithNibName:@"CHClickTableViewCell" bundle:nil] forCellReuseIdentifier:@"CDClickcell"];
    [_mytableView registerNib:[UINib nibWithNibName:@"CHCCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CDCCommentcell"];
    
    [_mytableView registerNib:[UINib nibWithNibName:@"CHCActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"CDCActivitycell"];
    [_mytableView registerNib:[UINib nibWithNibName:@"CHVGoods_infoTableViewCell" bundle:nil] forCellReuseIdentifier:@"goodscell"];
    [_mytableView registerNib:[UINib nibWithNibName:@"CHCArticalCell" bundle:nil] forCellReuseIdentifier:@"CHCArticalCell"];
    
    [_mytableView registerNib:[UINib nibWithNibName:@"CHRecipesCell" bundle:nil] forCellReuseIdentifier:@"CDCrecipescell"];
    [_mytableView registerNib:[UINib nibWithNibName:@"CHZTCell" bundle:nil] forCellReuseIdentifier:@"CDCZtcell"];
    [_mytableView registerNib:[UINib nibWithNibName:@"CHTopInfoCell" bundle:nil] forCellReuseIdentifier:@"CDCtopcell"];
    [_mytableView registerNib:[UINib nibWithNibName:@"CHCaiDanCell" bundle:nil] forCellReuseIdentifier:@"CDCCadancell"];
}

#pragma mark-UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.faxian_list.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    数据
    CHCfaxian_list * faxianCelllist  = (CHCfaxian_list *)self.data.faxian_list[indexPath.section];
    self.faxianCelllist=faxianCelllist;
      if (indexPath.section==0)
    {
     
        CHCDiscoverTableViewcell *discell=[tableView  dequeueReusableCellWithIdentifier:@"CDCdiscell" forIndexPath:indexPath ];
        
        UIImage *image=[UIImage imageNamed:@"ms_home_find_shicai"];

        UIButton  *shicaiButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        把高固定死 14
        shicaiButton.frame=CGRectMake
        (11, 14,W, image.size.height);
        [shicaiButton setImage:[UIImage imageNamed:@"ms_home_find_shicai"] forState:UIControlStateNormal];
        [shicaiButton setImage:[UIImage imageNamed:@"ms_home_find_shicai"] forState:UIControlStateHighlighted];
        [shicaiButton addTarget:self action:@selector(shiCaiButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton  *caidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        caidanButton.frame=CGRectMake(11+W+11, 14, W, image.size.height);
        [caidanButton setImage:[UIImage imageNamed:@"ms_home_find_caidan"] forState:UIControlStateNormal];
        [caidanButton setImage:[UIImage imageNamed:@"ms_home_find_caidan"] forState:UIControlStateHighlighted];
        [caidanButton addTarget:self action:@selector(caidanButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton  *zhaunTiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        zhaunTiButton.frame=CGRectMake(11+W+11+W+11, 14, W, image.size.height);
        [zhaunTiButton setImage:[UIImage imageNamed:@"ms_home_find_zhuanti"] forState:UIControlStateNormal];
        [zhaunTiButton setImage:[UIImage imageNamed:@"ms_home_find_zhuanti"] forState:UIControlStateHighlighted];
        [zhaunTiButton addTarget:self action:@selector(zhuantiButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton  *articleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        articleButton.frame=CGRectMake(11+W+11+W+11+W+11, 14, W, image.size.height);
        [articleButton setImage:[UIImage imageNamed:@"ms_home_find_wenzhang"] forState:UIControlStateNormal];
        [articleButton setImage:[UIImage imageNamed:@"ms_home_find_wenzhang"] forState:UIControlStateHighlighted];
        [articleButton addTarget:self action:@selector(articleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [discell addSubview:shicaiButton];
        [discell addSubview:caidanButton];
        [discell addSubview:zhaunTiButton];
        [discell addSubview:articleButton];
                return discell;
    }
    
  else if ([faxianCelllist.type isEqualToString:@"1"])

    {
        CHClickTableViewCell *clickcell=[tableView dequeueReusableCellWithIdentifier:@"CDClickcell" forIndexPath:indexPath];

        clickcell.faxian_list= faxianCelllist;
        
        return clickcell;
    }

        else if ([faxianCelllist.type isEqualToString:@"2"])
    {
       CHCCommentTableViewCell *commentcell=[tableView dequeueReusableCellWithIdentifier:@"CDCCommentcell" forIndexPath:indexPath];
        
        commentcell.faxian_list=faxianCelllist;
      
        return commentcell;
    }
        else if ([faxianCelllist.type isEqualToString:@"3"])
    {
       CHCActivityTableViewCell *activitycell=[tableView dequeueReusableCellWithIdentifier:@"CDCActivitycell" forIndexPath:indexPath];
        activitycell.faxian_list=faxianCelllist;
       
       return activitycell;
    }
    
    else if ([faxianCelllist.type isEqualToString:@"4"])
    {
        CHVGoods_infoTableViewCell *goodscell=[tableView dequeueReusableCellWithIdentifier:@"goodscell" forIndexPath:indexPath];
    
        goodscell.faxian_list=faxianCelllist;
        
        return goodscell;
    }

      else if ([faxianCelllist.type isEqualToString:@"5"])
    {
        CHCArticalCell *articalcell=[tableView  dequeueReusableCellWithIdentifier:@"CHCArticalCell" forIndexPath:indexPath ];
        articalcell.faxian_list=faxianCelllist;
                return articalcell;
    }
      else if ([faxianCelllist.type isEqualToString:@"6"])
      {
          CHRecipesCell *recipescell=[tableView dequeueReusableCellWithIdentifier:@"CDCrecipescell" forIndexPath:indexPath];
          recipescell.faxian_list=faxianCelllist;
         
          return recipescell;
      }


    else if ([faxianCelllist.type isEqualToString:@"7"])
    {
        
        CHCaiDanCell *caidancell=[tableView dequeueReusableCellWithIdentifier:@"CDCCadancell" forIndexPath:indexPath];
        caidancell.faxian_list=faxianCelllist;
        
        return caidancell;
    }

    else if([faxianCelllist.type isEqualToString:@"9"])
    {
        CHZTCell *ztcell3=[tableView dequeueReusableCellWithIdentifier:@"CDCZtcell" forIndexPath:indexPath];
        ztcell3.faxian_list=faxianCelllist;
        
        return ztcell3;
    }
    else if([faxianCelllist.type isEqualToString:@"11"])
   
    {
    CHTopInfoCell *topcell=[tableView dequeueReusableCellWithIdentifier: @"CDCtopcell" forIndexPath:indexPath];
        topcell.faxian_list=faxianCelllist;
        
        
        return topcell;
        
    }
    
   
    
    return nil;
}

#pragma mark-buttonClick
-(void)shiCaiButtonClicked:(id)sender
{

    CHCShiCaiViewController *shiCaiController=[[CHCShiCaiViewController alloc]init];
   [self.navigationController pushViewController:shiCaiController animated:YES];

  }

-(void)caidanButtonClicked:(id)sender
{
    CHCCaiDanViewController *shiCaiController=[[CHCCaiDanViewController alloc]init];
    [self.navigationController pushViewController:shiCaiController animated:YES];

}
-(void)zhuantiButtonClicked:(id)sender
{
    CHZhuanTiViewController *shiCaiController=[[CHZhuanTiViewController alloc]init];
   [self.navigationController pushViewController:shiCaiController animated:YES];
}
-(void)articleButtonClicked:(id)sender
{
    CHArticalViewController *shiCaiController=[[CHArticalViewController alloc]init];
   [self.navigationController pushViewController:shiCaiController animated:YES];

}
#pragma mark-UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1000;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 140;
    }
    if ([self.faxianCelllist.type isEqualToString:@"1"])
    {
        return 221;
    }
    else if ([self.faxianCelllist.type isEqualToString:@"2"])
    {
        return 221;
    }
    else if ([self.faxianCelllist.type isEqualToString:@"3"])
    {
        return 264;
    }
    else if ([self.faxianCelllist.type isEqualToString:@"5"])
    {
        return 330;
    }
    else if ([self.faxianCelllist.type isEqualToString:@"6"])
    {
        return  205;
    }

    else if ([self.faxianCelllist.type isEqualToString:@"7"])
    {
        return 210;
    }
    else if ([self.faxianCelllist.type isEqualToString:@"9"])
    {
        return 260;
    }
    else if ([self.faxianCelllist.type isEqualToString:@"11"])
    {
        return 260;
    }


    return  0;
}
//每个分组上边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return 5;
}
//每个分组下边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
  CHCfaxian_list * faxianCelllist  = (CHCfaxian_list *)self.data.faxian_list[indexPath.section];
   CHCFaXianDetailViewController *targetVC =[[CHCFaXianDetailViewController alloc] init];

    CHCWenZhanViewController *wenView=[[CHCWenZhanViewController alloc]init];
    CHCaiViewController *caiiew=[[ CHCaiViewController alloc]init];
       if ((targetVC.tid = faxianCelllist.topic_info.tid)&&(targetVC.gid=faxianCelllist.topic_info.gid))
    {
         [self presentViewController:targetVC animated:YES completion:nil];
    }
     else if ((wenView.wenId=faxianCelllist.article_info.myid))
    {
        [self.navigationController pushViewController:wenView animated:YES ];

    }
    else if ((caiiew.rid=faxianCelllist.caidan_info.myid))
    {
        [self.navigationController pushViewController:caiiew animated:YES ];
    }
    
    
    

}
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    if(navigationType==UIWebViewNavigationTypeLinkClicked)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    数据
//    CHCfaxian_list * faxianCelllist  = (CHCfaxian_list *)self.data.faxian_list[indexPath.section];
//    self.faxianCelllist=faxianCelllist;
//    
//    CHCDiscoverTableViewcell *discell=[tableView  dequeueReusableCellWithIdentifier:@"CDCdiscell" ];
//    CHClickTableViewCell *clickcell=[tableView dequeueReusableCellWithIdentifier:@"CDClickcell"];
//    CHCCommentTableViewCell *commentcell=[tableView dequeueReusableCellWithIdentifier:@"CDCCommentcell"];
//    CHCActivityTableViewCell *activitycell=[tableView dequeueReusableCellWithIdentifier:@"CDCActivitycell"];
//    
//    
//    CHVGoods_infoTableViewCell *goodscell=[tableView dequeueReusableCellWithIdentifier:@"goodscell"];
//    
//    CHCArticalCell *articalcell=[tableView  dequeueReusableCellWithIdentifier:@"CHCArticalCell" ];
//    CHRecipesCell *recipescell=[tableView dequeueReusableCellWithIdentifier:@"CDCrecipescell"];
//    CHCaiDanCell *caidancell=[tableView dequeueReusableCellWithIdentifier:@"CDCCadancell"];
//    
//    CHZTCell *ztcell3=[tableView dequeueReusableCellWithIdentifier:@"CDCZtcell"];
//    NSString *CellTableIdentifier = @"CDCtopcell";
//    CHTopInfoCell *topcell=[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
//    
//    if (!discell&&indexPath.section==0)
//    {
//        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCDiscoverTableViewcell" owner:nil options:nil];
//        discell=arr[0];
//        discell.selectionStyle = UITableViewCellSelectionStyleNone;
//        UIImage *image=[UIImage imageNamed:@"ms_home_find_shicai"];
//        
//        UIButton  *shicaiButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        //        把高固定死 14
//        shicaiButton.frame=CGRectMake
//        (11, 14,W, image.size.height);
//        [shicaiButton setImage:[UIImage imageNamed:@"ms_home_find_shicai"] forState:UIControlStateNormal];
//        [shicaiButton setImage:[UIImage imageNamed:@"ms_home_find_shicai"] forState:UIControlStateHighlighted];
//        [shicaiButton addTarget:self action:@selector(shiCaiButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UIButton  *caidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        caidanButton.frame=CGRectMake(11+W+11, 14, W, image.size.height);
//        [caidanButton setImage:[UIImage imageNamed:@"ms_home_find_caidan"] forState:UIControlStateNormal];
//        [caidanButton setImage:[UIImage imageNamed:@"ms_home_find_caidan"] forState:UIControlStateHighlighted];
//        [caidanButton addTarget:self action:@selector(caidanButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UIButton  *zhaunTiButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        zhaunTiButton.frame=CGRectMake(11+W+11+W+11, 14, W, image.size.height);
//        [zhaunTiButton setImage:[UIImage imageNamed:@"ms_home_find_zhuanti"] forState:UIControlStateNormal];
//        [zhaunTiButton setImage:[UIImage imageNamed:@"ms_home_find_zhuanti"] forState:UIControlStateHighlighted];
//        [zhaunTiButton addTarget:self action:@selector(zhuantiButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UIButton  *articleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        articleButton.frame=CGRectMake(11+W+11+W+11+W+11, 14, W, image.size.height);
//        [articleButton setImage:[UIImage imageNamed:@"ms_home_find_wenzhang"] forState:UIControlStateNormal];
//        [articleButton setImage:[UIImage imageNamed:@"ms_home_find_wenzhang"] forState:UIControlStateHighlighted];
//        [articleButton addTarget:self action:@selector(articleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [discell addSubview:shicaiButton];
//        [discell addSubview:caidanButton];
//        [discell addSubview:zhaunTiButton];
//        [discell addSubview:articleButton];
//        
//        return discell;
//    }
//    
//    else if (!clickcell&&[faxianCelllist.type isEqualToString:@"1"])
//        
//    {
//        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHClickTableViewCell" owner:nil options:nil];
//        clickcell=arr[0];
//        
//        clickcell.faxian_list= faxianCelllist;
//        return clickcell;
//    }
//    
//    else if (!commentcell&&([faxianCelllist.type isEqualToString:@"2"]))
//    {
//        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCCommentTableViewCell" owner:nil options:nil];
//        commentcell=arr[0];
//        //        设置选择时的显示风格
//        commentcell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        commentcell.faxian_list=faxianCelllist;
//        return commentcell;
//    }
//    
//    
//    else if (!activitycell&&([faxianCelllist.type isEqualToString:@"3"]))
//    {
//        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCActivityTableViewCell" owner:nil options:nil];
//        activitycell=arr[0];
//        activitycell.faxian_list=faxianCelllist;
//        return activitycell;
//    }
//    
//    else if (!goodscell&&([faxianCelllist.type isEqualToString:@"4"]))
//    {
//        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHVGoods_infoTableViewCell" owner:nil options:nil];
//        goodscell=arr[0];
//        
//        goodscell.faxian_list=faxianCelllist;
//        return goodscell;
//    }
//    
//    else if (!articalcell&&([faxianCelllist.type isEqualToString:@"5"]))
//    {
//        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCArticalCell" owner:nil options:nil];
//        articalcell=arr[0];
//        
//        articalcell.faxian_list=faxianCelllist;
//        return articalcell;
//    }
//    else if (!recipescell&&([faxianCelllist.type isEqualToString:@"6"]))
//    {
//        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHRecipesCell" owner:nil options:nil];
//        recipescell=arr[0];
//        recipescell.faxian_list=faxianCelllist;
//        return recipescell;
//    }
//    
//    
//    else if (!caidancell&&([faxianCelllist.type isEqualToString:@"7"]))
//    {
//        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCaiDanCell" owner:nil options:nil];
//        caidancell=arr[0];
//        
//        caidancell.faxian_list=faxianCelllist;
//        return caidancell;
//    }
//    
//    else if(!ztcell3&&([faxianCelllist.type isEqualToString:@"9"]))
//    {
//        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHZTCell" owner:nil options:nil];
//        ztcell3=arr[0];
//        ztcell3.faxian_list=faxianCelllist;
//        return ztcell3;
//    }
//    else
//        
//    {
//        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHTopInfoCell" owner:nil options:nil];
//        topcell=arr[0];
//        topcell.faxian_list=faxianCelllist;
//        return topcell;
//    }
//    
//    
//    return nil;
//}