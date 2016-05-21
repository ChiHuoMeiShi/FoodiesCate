//
//  CHRJAICreateCollectionViewCell.m
//  吃货美食
//
//  Created by scjy on 16/5/20.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJAICreateCollectionViewCell.h"

@implementation CHRJAICreateCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setAiCreateFoodModel:(CHRJAICreateFoodModel *)aiCreateFoodModel{
    if (!aiCreateFoodModel)return;
    _aiCreateFoodModel = aiCreateFoodModel;
    [self cellSetData];
}

- (void)cellSetData{
    self.showLabel.text = self.aiCreateFoodModel.title;
//    get tittle width
    NSDictionary * attributes = [NSDictionary dicOfTextAttributeWithFont:[UIFont systemFontOfSize:16.f] withTextColor:[UIColor redColor]];
    NSString * foodCountStr = [NSString stringWithFormat:@"%@",self.aiCreateFoodModel.total];
    CGRect myRect = [foodCountStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.f) options:NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    self.showCountLabelWidth.constant = myRect.size.width;
    
    CGFloat showImageWidth = (CHSCREENWIDTH - 20.f - 20.f)/3;
    self.firstImageViewWidth.constant = showImageWidth;
    self.secondImageViewWidth.constant = showImageWidth;
    self.thirdImageViewWidth.constant = showImageWidth;
    
    [self setNeedsLayout];
    
    self.showCountLabel.text = foodCountStr;
    __weak typeof(self)mySelf = self;
    [self.aiCreateFoodModel.newses enumerateObjectsUsingBlock:^(CHRJAICreateFoodNewsesModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [mySelf imageView:mySelf.firstImageView GetWebImageURL:[NSURL URLWithString:obj.titlepic]];
        }else if (idx == 1){
            [mySelf imageView:mySelf.secondImageView GetWebImageURL:[NSURL URLWithString:obj.titlepic]];
        }else{
            [mySelf imageView:mySelf.thirdImageView GetWebImageURL:[NSURL URLWithString:obj.titlepic]];
        }
    }];
    
}

- (void)imageView:(UIImageView *)showImageView GetWebImageURL:(NSURL *)webURL{
    [[SDWebImageManager sharedManager]downloadImageWithURL:webURL    options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        showImageView.image = image;
    }];
}

@end
