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
#import <MJRefresh.h>

#import "Topic_List.h"

#import "CHCaiViewController.h"
#import "CHCFaXianDetailViewController.h"
#import "CHCOneWebViewController.h"
#import "CHzt_infoWebViewController.h"
#import "CHCWenZhanViewController.h"
@interface CHDiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *_mytableView;
}
@property(nonatomic,strong)CHCFindData *data;
@property(nonatomic,strong) CHCfaxian_list * faxianCelllist;

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
  
    
    [self getTableViewData];
    [self CreatTableView];
     MJRefreshStateHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction)];
     _mytableView.mj_header=header;
       [_mytableView addSubview:header];
    
    
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
             [_mytableView.mj_header endRefreshing];


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
    _mytableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CHSCREENWIDTH, CHSCREENHEIGH) style:UITableViewStylePlain];
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
//
    
    
    if (!discell&&indexPath.section==0)
    {
     NSArray *arr=[[NSBundle mainBundle]loadNibNamed:@"CHCDiscoverTableViewcell" owner:nil options:nil];
            discell=arr[0];
            discell.selectionStyle = UITableViewCellSelectionStyleNone;
      UIButton  *shicaiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shicaiButton.frame=CGRectMake
        (CHSCREENWIDTH*24/414, 14,CHSCREENWIDTH*81/414, 108);
        
        [shicaiButton setImage:[UIImage imageNamed:@"ms_home_find_shicai"] forState:UIControlStateNormal];
        [shicaiButton setImage:[UIImage imageNamed:@"ms_home_find_shicai"] forState:UIControlStateHighlighted];
        [shicaiButton addTarget:self action:@selector(shiCaiButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton  *caidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        caidanButton.frame=CGRectMake(CHSCREENWIDTH*119/414, 14, CHSCREENWIDTH*81/414, 108);
        [caidanButton setImage:[UIImage imageNamed:@"ms_home_find_caidan"] forState:UIControlStateNormal];
        [caidanButton setImage:[UIImage imageNamed:@"ms_home_find_caidan"] forState:UIControlStateHighlighted];
        [caidanButton addTarget:self action:@selector(caidanButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

        UIButton  *zhaunTiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        zhaunTiButton.frame=CGRectMake(CHSCREENWIDTH*216/414, 14, CHSCREENWIDTH*81/414, 108);
        [zhaunTiButton setImage:[UIImage imageNamed:@"ms_home_find_zhuanti"] forState:UIControlStateNormal];
        [zhaunTiButton setImage:[UIImage imageNamed:@"ms_home_find_zhuanti"] forState:UIControlStateHighlighted];
        [zhaunTiButton addTarget:self action:@selector(zhuantiButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton  *articleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        articleButton.frame=CGRectMake(CHSCREENWIDTH*312/414, 14, CHSCREENWIDTH*81/414, 108);
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
          recipescell.faxian_list=faxianCelllist;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
CHCfaxian_list * faxianCelllist  = (CHCfaxian_list *)self.data.faxian_list[indexPath.section];
    
    
CHCFaXianDetailViewController *targetVC =[[CHCFaXianDetailViewController alloc] init];
       CHCOneWebViewController *oneView=[[CHCOneWebViewController alloc]init];
    CHzt_infoWebViewController *zt_infoView=[[CHzt_infoWebViewController alloc]init];
    CHCWenZhanViewController *wenView=[[CHCWenZhanViewController alloc]init];
    CHCaiViewController *caiiew=[[ CHCaiViewController alloc]init];
//    
//    NSString* nyid =((CHCrecipes_list *)_faxianCelllist.gongyi_info.recipes[0]).myid;
//    if ((view.rid=nyid))
//    {
//        [self.navigationController pushViewController:view animated:YES ];
//        
//    }
    

    if ((targetVC.tid = faxianCelllist.topic_info.tid)&&(targetVC.gid=faxianCelllist.topic_info.gid))
    {
         [self presentViewController:targetVC animated:YES completion:nil];
    }
     else if ((oneView.oneId=faxianCelllist.recipe_info.myid))
    {
        [self.navigationController pushViewController:oneView animated:YES ];

    }
    else if ((wenView.wenId=faxianCelllist.article_info.myid) )
    {
        [self.navigationController pushViewController:wenView animated:YES ];

    }
    else if ((caiiew.rid=faxianCelllist.caidan_info.myid))
    {
        [self.navigationController pushViewController:caiiew animated:YES ];
    }
    
//    else if((zt_infoView.ztId=faxianCelllist.zt_info.myid))
//    {
//      [self presentViewController:zt_infoView animated:YES completion:nil];
//    }
//    else if((view.rid=_faxianCelllist.caidan_info.myid))
//    {
//         [self.navigationController pushViewController:view animated:YES ];
//    }
    
    
    

    
// [_bagImagView sd_setImageWithURL:[NSURL URLWithString:((CHCimages_list *)faxian_list.topic_info.imgs[1]).big]];
   
    
    
    
//        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
//        if ((propertyName ='topic_info'))
//        {
//                          CHEChatDetailController *targetVC = [[CHEChatDetailController alloc] init];
//                    CHCfaxian_list * faxianCelllist  = (CHCfaxian_list *)self.data.faxian_list[indexPath.section];
//                    targetVC.tid = faxianCelllist.topic_info.tid;
//                    targetVC.gid=faxianCelllist.topic_info.gid;
//                    [self.navigationController pushViewController:targetVC animated:YES];
//
//        }
//        else if((propertyName ='caidan_info'))
//        {
//            CHCaiViewController *view=[[ CHCaiViewController alloc]init];
//                    CHCfaxian_list * faxianCelllist  = (CHCfaxian_list *)self.data.faxian_list[indexPath.section];
//            
//                    view.rid=faxianCelllist.caidan_info.myid;
//                    [self presentViewController:view animated:YES completion:nil];
//
//        }
 
//    CHCfaxian_list *model = self.data.faxian_list[indexPath.section];
//    NSLog(@"+++++++%@",model.title);
//    NSLog(@"-----%@",self.faxianCelllist.type);
//    if ()
//    {
//      //    }
//
//    
////    11
//       else if ([self.faxianCelllist.type isEqualToString:@"7"])
//    {
//        CHCaiViewController *view=[[ CHCaiViewController alloc]init];
//        CHCfaxian_list * faxianCelllist  = (CHCfaxian_list *)self.data.faxian_list[indexPath.section];
//
//        view.rid=faxianCelllist.caidan_info.myid;
//        [self presentViewController:view animated:YES completion:nil];
//
//    }
    

//    7
    
    
    
    
    

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//    CHCFaXianDetailViewController *detaileView=[[CHCFaXianDetailViewController alloc]init];
//
//    YLSquareList *squareList = self.meModel.squareList[indexPath.row];
//
//    detailVC.loadUrl = squareList.url;
//
//    [self.navigationController pushViewController:detailVC animated:YES];
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//NSString *str=self.faxianCelllist.type ;
//int a=[str intValue];
//switch (a) {
//    case 0:
//        
//        break;
//        //
//        //        case 1:
//        //            <#statements#>
//        //            break;
//        //        case 2:
//        //            <#statements#>
//        //            break;
//        //        case 3:
//        //            <#statements#>
//        //            break;
//        //        case 4:
//        //            <#statements#>
//        //            break;
//        //            case 5:
//        //            <#statements#>
//        //            break;
//        //        case 6:
//        //            <#statements#>
//        //            break;
//    case 7:
//    {
//        CHEChatDetailController *targetVC = [[CHEChatDetailController alloc] init];
//        CHCfaxian_list * faxianCelllist  = (CHCfaxian_list *)self.data.faxian_list[indexPath.section];
//        targetVC.tid = faxianCelllist.caidan_info.myid;
//        [self.navigationController pushViewController:targetVC animated:YES];
//    }
//        break;
//        //        case 9:
//        //            <#statements#>
//        //            break;
//        //        case 11:
//        //            <#statements#>
//        //            break;
//        
//        
//    default:
//        break;
//}
//u_int count;
//objc_property_t *properties  =class_copyPropertyList([CHCfaxian_list class], &count);
//
//NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
//for (int i = 0; i<count; i++)
//
//{
//    const char* propertyName =property_getName(properties[i]);
//    
//    [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
//    NSLog(@"Person has a property: '%@'", propertiesArray);
//    
//    if ([propertiesArray[i] isEqual:@"topic_info"])
//    {
//        NSLog(@"rrrrrrrrr%@",propertiesArray[i]);
//        CHCFaXianDetailViewController *targetVC = [[CHCFaXianDetailViewController alloc] init];
//        CHCfaxian_list * faxianCelllist  = (CHCfaxian_list *)self.data.faxian_list[indexPath.section];
//        targetVC.tid = faxianCelllist.topic_info.tid;
//        targetVC.gid=faxianCelllist.topic_info.gid;
//        [self presentViewController:targetVC animated:YES completion:nil];
//    }
//    else if([propertiesArray[i] isEqual:@"caidan_info"])
//    {
//        NSLog(@"wwwwwwwww%@",propertiesArray[i]);
//        CHCaiViewController *view=[[ CHCaiViewController alloc]init];
//        CHCfaxian_list * faxianCelllist  = (CHCfaxian_list *)self.data.faxian_list[indexPath.section];
//        
//        view.rid=faxianCelllist.caidan_info.myid;
//        [self presentViewController:view animated:YES completion:nil];
//        
//    }
//    
//    
//    
//}
//free(properties);
////    for (int i=0; i<propertiesArray.count; i++)
////    {
////
////        }
//
//
//NSString *CellIdentifierdiscell = [NSString stringWithFormat:@"CDCdiscell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
//
//NSString *CellIdentifierclickcell= [NSString stringWithFormat:@"clickcell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
//NSString *CellIdentifiercommentcell = [NSString stringWithFormat:@"commentcell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
//NSString *CellIdentifieractivitycell = [NSString stringWithFormat:@"activitycell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
//NSString *CellIdentifiergoodscell = [NSString stringWithFormat:@"goodscell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
//NSString *CellIdentifierarticalcell = [NSString stringWithFormat:@"articalcell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
//NSString *CellIdentifierrecipescell = [NSString stringWithFormat:@"recipescell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
//NSString *CellIdentifiercaidancell = [NSString stringWithFormat:@"caidancell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
//NSString *CellIdentifierztcell3 = [NSString stringWithFormat:@"ztcell3%ld%ld", (long)[indexPath section], (long)[indexPath row]];
//NSString *CellIdentifiertopcell = [NSString stringWithFormat:@"topcell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
//
//
//
//CHCDiscoverTableViewcell *discell=[tableView  dequeueReusableCellWithIdentifier:CellIdentifierdiscell];
//CHClickTableViewCell *clickcell=[tableView dequeueReusableCellWithIdentifier:CellIdentifierclickcell];
//CHCCommentTableViewCell *commentcell=[tableView dequeueReusableCellWithIdentifier:CellIdentifiercommentcell];
//CHCActivityTableViewCell *activitycell=[tableView dequeueReusableCellWithIdentifier:CellIdentifieractivitycell];
//
//
//CHVGoods_infoTableViewCell *goodscell=[tableView dequeueReusableCellWithIdentifier:CellIdentifiergoodscell];
//
//CHCArticalCell *articalcell=[tableView  dequeueReusableCellWithIdentifier:CellIdentifierarticalcell ];
//CHRecipesCell *recipescell=[tableView dequeueReusableCellWithIdentifier:CellIdentifierrecipescell];
//CHCaiDanCell *caidancell=[tableView dequeueReusableCellWithIdentifier:CellIdentifiercaidancell];
//
//CHZTCell *ztcell3=[tableView dequeueReusableCellWithIdentifier:CellIdentifierztcell3];
//
//CHTopInfoCell *topcell=[tableView dequeueReusableCellWithIdentifier:CellIdentifiertopcell];
//u_int count;
//objc_property_t *properties  =class_copyPropertyList([CHCfaxian_list class], &count);
//
//NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
//for (int i = 0; i<count; i++)
//
//{
//    const char* propertyName =property_getName(properties[i]);
//
//    [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
//    NSLog(@"Person has a property: '%@'", propertiesArray);
//
//    if ([propertiesArray[i] isEqual:@"topic_info"])
//    {
//        NSLog(@"rrrrrrrrr%@",propertiesArray[i]);
//        CHCFaXianDetailViewController *targetVC = [[CHCFaXianDetailViewController alloc] init];
//        CHCfaxian_list * faxianCelllist  = (CHCfaxian_list *)self.data.faxian_list[indexPath.section];
//        targetVC.tid = faxianCelllist.topic_info.tid;
//        targetVC.gid=faxianCelllist.topic_info.gid;
//        [self presentViewController:targetVC animated:YES completion:nil];
//    }
//    else if([propertiesArray[i] isEqual:@"caidan_info"])
//    {
//        NSLog(@"wwwwwwwww%@",propertiesArray[i]);
//        CHCaiViewController *view=[[ CHCaiViewController alloc]init];
//        CHCfaxian_list * faxianCelllist  = (CHCfaxian_list *)self.data.faxian_list[indexPath.section];
//
//        view.rid=faxianCelllist.caidan_info.myid;
//        [self presentViewController:view animated:YES completion:nil];
//
//    }



@end
