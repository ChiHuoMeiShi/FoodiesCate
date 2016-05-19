//
//  CHDiscoverViewController.m
//  吃货美食
//
//  Created by 赵天 on 16/5/6.
//  Copyright © 2016年 赵天. All rights reserved.
//
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
@interface CHDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *_mytableView;
}
@property(nonatomic,strong)CHCFindData *data;
@property(nonatomic,strong) CHCfaxian_list * faxianCelllist;

@end
@implementation CHDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self getTableViewData];
    [self CreatTableView];
}
-(void)getTableViewData
{
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html", nil];
    NSString *nsurl=@"http://api.meishi.cc/v5/faxian_new.php?format=json";
    NSDictionary * dic =
  @{@"lat":@"",@"lon":@"",@"source":@"iphone",@"format":@"json",@"page":@"",@"timestamp":@"",@"rid":@""};
     __weak typeof(self) mySelf=self;
    [manger POST:nsurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         CHLog(@"1111%@",responseObject);
        dispatch_async(dispatch_get_main_queue(), ^
         {

        CHCFindData *data=[CHCFindData mj_objectWithKeyValues:responseObject];
        mySelf.data=data;
        [_mytableView reloadData];
         });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CHLog(@"%@",error);
    }];
    
}
-(void)CreatTableView
{
    _mytableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height+200) style:UITableViewStyleGrouped];
    _mytableView.delegate=self;
    _mytableView.dataSource=self;
    [self.view addSubview:_mytableView];

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
    CHCDiscoverTableViewcell *discell=[tableView  dequeueReusableCellWithIdentifier:@"CDCdiscell" ];
    CHClickTableViewCell *clickcell=[tableView dequeueReusableCellWithIdentifier:@"CDClickcell"];
    CHCCommentTableViewCell *commentcell=[tableView dequeueReusableCellWithIdentifier:@"CDCCommentcell"];
    CHCActivityTableViewCell *activitycell=[tableView dequeueReusableCellWithIdentifier:@"CDCActivitycell"];
    
   
     CHVGoods_infoTableViewCell *goodscell=[tableView dequeueReusableCellWithIdentifier:@"goodscell"];
    
    CHCArticalCell *articalcell=[tableView  dequeueReusableCellWithIdentifier:@"CHCArticalCell" ];
    CHRecipesCell *recipescell=[tableView dequeueReusableCellWithIdentifier:@"CDCrecipescell"];
    CHCaiDanCell *caidancell=[tableView dequeueReusableCellWithIdentifier:@"CDCCadancell"];
    
     CHZTCell *ztcell3=[tableView dequeueReusableCellWithIdentifier:@"CDCZtcell"];
    NSString *CellTableIdentifier = @"CDCtopcell";
    CHTopInfoCell *topcell=[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
   
    if (!discell&&indexPath.section==0)
    {
     NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCDiscoverTableViewcell" owner:nil options:nil];
            discell=arr[0];
            discell.selectionStyle = UITableViewCellSelectionStyleNone;
      UIButton  *shicaiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shicaiButton.frame=CGRectMake(24, 14, 81, 108);
        [shicaiButton setImage:[UIImage imageNamed:@"ms_home_find_shicai"] forState:UIControlStateNormal];
        [shicaiButton setImage:[UIImage imageNamed:@"ms_home_find_shicai"] forState:UIControlStateHighlighted];
        [shicaiButton addTarget:self action:@selector(shiCaiButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton  *caidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        caidanButton.frame=CGRectMake(119, 14, 81, 108);
        [caidanButton setImage:[UIImage imageNamed:@"ms_home_find_caidan"] forState:UIControlStateNormal];
        [caidanButton setImage:[UIImage imageNamed:@"ms_home_find_caidan"] forState:UIControlStateHighlighted];
        [caidanButton addTarget:self action:@selector(caidanButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

        UIButton  *zhaunTiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        zhaunTiButton.frame=CGRectMake(216, 14, 81, 108);
        [zhaunTiButton setImage:[UIImage imageNamed:@"ms_home_find_zhuanti"] forState:UIControlStateNormal];
        [zhaunTiButton setImage:[UIImage imageNamed:@"ms_home_find_zhuanti"] forState:UIControlStateHighlighted];
        [zhaunTiButton addTarget:self action:@selector(zhuantiButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton  *articleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        articleButton.frame=CGRectMake(312, 14, 81, 108);
        [articleButton setImage:[UIImage imageNamed:@"ms_home_find_wenzhang"] forState:UIControlStateNormal];
        [articleButton setImage:[UIImage imageNamed:@"ms_home_find_wenzhang"] forState:UIControlStateHighlighted];
        [articleButton addTarget:self action:@selector(articleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
         [discell.contentView addSubview:shicaiButton];
         [discell.contentView addSubview:caidanButton];
         [discell.contentView addSubview:zhaunTiButton];
         [discell.contentView addSubview:articleButton];
        return discell;
    }
    
    else if (!clickcell&&[faxianCelllist.type isEqualToString:@"1"])

    {
        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHClickTableViewCell" owner:nil options:nil];
        clickcell=arr[0];
        //                           设置选择时的显示风格
        clickcell.selectionStyle = UITableViewCellSelectionStyleNone;
        clickcell.faxian_list= faxianCelllist;
        return clickcell;
    }

        else if (!commentcell&&([faxianCelllist.type isEqualToString:@"2"]))
    {
        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCCommentTableViewCell" owner:nil options:nil];
        commentcell=arr[0];
        //        设置选择时的显示风格
        commentcell.selectionStyle = UITableViewCellSelectionStyleNone;

        commentcell.faxian_list=faxianCelllist;
              return commentcell;
    }
    

    else if (!activitycell&&([faxianCelllist.type isEqualToString:@"3"]))
    {
        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCActivityTableViewCell" owner:nil options:nil];
        activitycell=arr[0];
        //        设置选择时的显示风格
        activitycell.selectionStyle = UITableViewCellSelectionStyleNone;
        activitycell.faxian_list=faxianCelllist;
       return activitycell;
    }
    
    else if (!goodscell&&([faxianCelllist.type isEqualToString:@"4"]))
    {
        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHVGoods_infoTableViewCell" owner:nil options:nil];
        goodscell=arr[0];
        //        设置选择时的显示风格
        goodscell.selectionStyle = UITableViewCellSelectionStyleNone;
        goodscell.faxian_list=faxianCelllist;
        return goodscell;
    }

      else if (!articalcell&&([faxianCelllist.type isEqualToString:@"5"]))
    {
        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCArticalCell" owner:nil options:nil];
        articalcell=arr[0];
        //        设置选择时的显示风格
        articalcell.selectionStyle = UITableViewCellSelectionStyleNone;
        articalcell.faxian_list=faxianCelllist;
        return articalcell;
    }
      else if (!recipescell&&([faxianCelllist.type isEqualToString:@"6"]))
      {
          NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHRecipesCell" owner:nil options:nil];
          recipescell=arr[0];
          //        设置选择时的显示风格
          recipescell.selectionStyle = UITableViewCellSelectionStyleNone;
          return recipescell;
      }


    else if (!caidancell&&([faxianCelllist.type isEqualToString:@"7"]))
    {
        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCaiDanCell" owner:nil options:nil];
        caidancell=arr[0];
        //        设置选择时的显示风格
        caidancell.selectionStyle = UITableViewCellSelectionStyleNone;
        caidancell.faxian_list=faxianCelllist;
        return caidancell;
    }

    else if(!ztcell3&&([faxianCelllist.type isEqualToString:@"9"]))
    {
        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHZTCell" owner:nil options:nil];
        ztcell3=arr[0];
        //        设置选择时的显示风格
        ztcell3.selectionStyle = UITableViewCellSelectionStyleNone;
        ztcell3.faxian_list=faxianCelllist;
        return ztcell3;
    }
    else
   
    {
        NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHTopInfoCell" owner:nil options:nil];
        topcell=arr[0];
        //        设置选择时的显示风格
        topcell.selectionStyle = UITableViewCellSelectionStyleNone;
        topcell.faxian_list=faxianCelllist;
        return topcell;
    }
    
    
    return nil;
}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    }

#pragma mark-buttonClick
-(void)shiCaiButtonClicked:(id)sender
{

    CHCShiCaiViewController *shiCaiController=[[CHCShiCaiViewController alloc]init];
  [self presentViewController:shiCaiController animated:YES completion:nil];
}

-(void)caidanButtonClicked:(id)sender
{
    CHCCaiDanViewController *shiCaiController=[[CHCCaiDanViewController alloc]init];
    [self presentViewController:shiCaiController animated:YES completion:nil];
}
-(void)zhuantiButtonClicked:(id)sender
{
    CHZhuanTiViewController *shiCaiController=[[CHZhuanTiViewController alloc]init];
    [self presentViewController:shiCaiController animated:YES completion:nil];
    
}
-(void)articleButtonClicked:(id)sender
{
    CHArticalViewController *shiCaiController=[[CHArticalViewController alloc]init];
    [self presentViewController:shiCaiController animated:YES completion:nil];

}
#pragma mark-UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 140;
    }
    else if ([self.faxianCelllist.type isEqualToString:@"1"])
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


    return  200;
}
//每个分组上边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 return 8;
}
//每个分组下边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
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
