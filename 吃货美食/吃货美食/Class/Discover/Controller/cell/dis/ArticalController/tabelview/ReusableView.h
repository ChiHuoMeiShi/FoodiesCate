//
//  ReusableView.h
//  XUER
//
//  Created by scjy on 16/3/16.
//  Copyright © 2016年 陈栋武. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface ReusableView : UICollectionReusableView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
}
@property (nonatomic,assign) int imageTotal;
@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign) BOOL isDragging;

 @end
