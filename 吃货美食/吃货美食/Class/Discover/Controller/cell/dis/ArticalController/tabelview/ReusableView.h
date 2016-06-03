//
//  ReusableView.h
//  XUER
//
//  Created by scjy on 16/3/16.
//  Copyright © 2016年 陈栋武. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "CHCArticalData.h"
#import "CHLocation.h"
@interface ReusableView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
}
@property (nonatomic,assign) int imageTotal;
@property(nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign) BOOL isDragging;
@property(nonatomic,strong) CHCArticalData *data;
@property(nonatomic,strong)NSMutableArray *imagesArr;
@property (nonatomic,strong)CHLocation * location;
 @end
