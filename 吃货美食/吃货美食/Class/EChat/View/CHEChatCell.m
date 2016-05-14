//
//  CHEChatCell.m
//  吃货美食
//
//  Created by 赵天 on 16/5/11.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHEChatCell.h"

@implementation CHEChatCell

- (void)setShowhottopic:(Hot_topocModel *)showhottopic
{
    if (showhottopic == nil) {
        return;
    }
    _showhottopic = showhottopic;
    NSMutableArray *imageArr = showhottopic.imgs;
    
    if (imageArr.count == 1) {
        ImgsModel *imgModel = imageArr[0];
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imgModel.small] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    //改变约束
                    self.imagesHeight.constant = 200.f;
                    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
                    imgView.frame = CGRectMake(0.f, 0.f, 150.f, 200.f);
                    [self.iamges addSubview:imgView];
                    imgView = nil;
                }];
        [self setNeedsLayout];
    }
//    else if (imageArr.count == 2){
//
//        for (int i = 1; i <= 2; i ++)
//        {
////            __block UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((imageW + interval) * (i - 1), 0, imageW, imageH)];
//            
//            ImgsModel *imgModel = imageArr[i - 1];
//            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imgModel.small] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((imageW + interval) * (i - 1), 0, imageW, imageH)];
//                //改变约束
//                self.imagesHeight.constant = imageH;
//                [imgView setImage:image];
//                [self.iamges addSubview:imgView];
//                imgView = nil;
////                [self setNeedsLayout];
//            }];
//            [self setNeedsLayout];
//        }
//        
//    }
// 
//    else if (imageArr.count == 3){
//        for (int i = 0; i < 3; i ++)
//        {
////            __block UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((imageW + interval) * (i), 0, imageW, imageH)];
//            ImgsModel *imgModel = imageArr[i];
//            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imgModel.small] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((imageW + interval) * (i), 0, imageW, imageH)];
//                //改变约束
//                self.imagesHeight.constant = imageH;
//                [imgView setImage:image];
//                [self.iamges addSubview:imgView];
//                imgView = nil;
////                [self setNeedsLayout];
//            }];
//            [self setNeedsLayout];
//        }
//    }
//    else if (imageArr.count == 4){
//        for (int i = 0; i < 4; i++)
//        {
//            int col = i % 3;//列
//            int row = i / 3;//行
//            
////            __block UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(col *(imageW + interval), row * (imageW + interval), imageW, imageH)];
//            ImgsModel *imgModel = imageArr[i];
//            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imgModel.small] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                //改变约束
//                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(col *(imageW + interval), row * (imageW + interval), imageW, imageH)];
//                self.imagesHeight.constant = imageH *2 + interval;
//                [imgView setImage:image];
//                [self.iamges addSubview:imgView];
//                imgView = nil;
////                [self setNeedsLayout];
//            }];
//            [self setNeedsLayout];
//        }
//    }
//    else if (imageArr.count == 5){
//        for (int i = 0; i < 5; i++)
//        {
//            int col = i % 3;//列
//            int row = i / 3;//行
//            
////            __block UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(col *(imageW + interval), row * (imageW + interval), imageW, imageH)];
//            ImgsModel *imgModel = imageArr[i];
//            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imgModel.small] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(col *(imageW + interval), row * (imageW + interval), imageW, imageH)];
//                //改变约束
//                self.imagesHeight.constant = imageH *2 + interval;
//                [imgView setImage:image];
//                [self.iamges addSubview:imgView];
//                imgView = nil;
////                [self setNeedsLayout];
//            }];
//            [self setNeedsLayout];
//        }
//    }
//    else if (imageArr.count == 6){
//        for (int i = 0; i < 6; i++)
//        {
//            int col = i % 3;//列
//            int row = i / 3;//行
//            
////            __block UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(col *(imageW + interval), row * (imageW + interval), imageW, imageH)];
//            ImgsModel *imgModel = imageArr[i];
//            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imgModel.small] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(col *(imageW + interval), row * (imageW + interval), imageW, imageH)];
//                //改变约束
//                self.imagesHeight.constant = imageH *2 + interval;
//                [imgView setImage:image];
//                [self.iamges addSubview:imgView];
//                imgView = nil;
////                [self setNeedsLayout];
//            }];
//            [self setNeedsLayout];
//        }
//    }
//    else if (imageArr.count == 7){
//        for (int i = 0; i < 7; i++)
//        {
//            int col = i % 3;//列
//            int row = i / 3;//行
//            
////            __block UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(col *(imageW + interval), row * (imageW + interval), imageW, imageH)];
//            ImgsModel *imgModel = imageArr[i];
//            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imgModel.small] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(col *(imageW + interval), row * (imageW + interval), imageW, imageH)];
//                //改变约束
//                self.imagesHeight.constant = imageH *3 + interval * 2;
//                [imgView setImage:image];
//                [self.iamges addSubview:imgView];
//                imgView = nil;
////                [self setNeedsLayout];
//            }];
//            [self setNeedsLayout];
//        }
//    }
//    else if (imageArr.count == 8){
//        for (int i = 0; i < 8; i++)
//        {
//            int col = i % 3;//列
//            int row = i / 3;//行
//            
////            __block UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(col *(imageW + interval), row * (imageW + interval), imageW, imageH)];
//            ImgsModel *imgModel = imageArr[i];
//            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imgModel.small] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(col *(imageW + interval), row * (imageW + interval), imageW, imageH)];
//                //改变约束
//                self.imagesHeight.constant = imageH *3 + interval * 2;
//                [imgView setImage:image];
//                [self.iamges addSubview:imgView];
//                imgView = nil;
////                [self setNeedsLayout];
//            }];
//            [self setNeedsLayout];
//        }
//    }
//    else if (imageArr.count == 9){
//        for (int i = 0; i < 9; i++)
//        {
//            int col = i % 3;//列
//            int row = i / 3;//行
//            
////            __block UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(col *(imageW + interval), row * (imageW + interval), imageW, imageH)];
//            ImgsModel *imgModel = imageArr[i];
//            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imgModel.small] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(col *(imageW + interval), row * (imageW + interval), imageW, imageH)];
//                //改变约束
//                self.imagesHeight.constant = imageH *3 + interval * 2;
//                [imgView setImage:image];
//                [self.iamges addSubview:imgView];
//                imgView = nil;
//                
////                [self setNeedsLayout];
//            }];
//            [self setNeedsLayout];
//        }
//    }
//    
//    
////    for (NSDictionary *dict in imageArr)
////    {
////        NSLog(@"url%@",dict);
////    }
////    NSDictionary *dict = imgModel[0];
//    
////    NSLog(@"图片数组第一个小地址%@",imgModel[0]);
    
    [self.iconIamgeView sd_setImageWithURL:[NSURL URLWithString:showhottopic.user_info.avatar]];
    
    self.num = showhottopic.img_num;
    
//    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:showhottopic.imgs[0][@"small"]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                //改变约束
//                self.imagesHeight.constant = image.size.height;
//                UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
//                [self.iamges addSubview:imgView];
//    
//                [self setNeedsLayout];
//            }];
    
    self.nameLabel.text = showhottopic.user_info.user_name;
    
    self.contentLabel.text = showhottopic.summary;
    
    self.timeLabel.text = showhottopic.time;
    
    self.fromLabel.text = showhottopic.recipe_info.title;
    
    [self.dingBtn setTitle:showhottopic.ding_num forState:UIControlStateNormal];
    
    [self.commentBtn setTitle:showhottopic.comment_num forState:UIControlStateNormal];

}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
