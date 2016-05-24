//
//  CHRJBasicViewController.h
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHRWebViewController.h"
#import "CHRJSearchView.h"
#import "CHRJSearchViewController.h"
#import "CHRImageButton.h"

extern const CGFloat myLat;
extern const CGFloat myLon;

@interface CHRJBasicViewController : UIViewController<MBProgressHUDDelegate,UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong)MBProgressHUD * myHUD;
@property (nonatomic,strong)CHRJSearchView * searchView;
@property (nonatomic,strong)CHHTTPRequestManager * afnManger;

@property (nonatomic,strong)CHRImageButton * choosedImagedButton;

@property (nonatomic,strong)UIImage * choosedImage;
@property (nonatomic,copy)NSString * imageChoosedPath;

- (void)navBackAction;
- (void)pushToWebViewWithID:(NSNumber *)myID withUrlString:(NSString *)urlString;

- (void)showHUDWithText:(NSString *)string withTextFont:(UIFont *)font withTextColor:(UIColor *)color withTextSize:(CGSize)textSize withAction:(SEL)method withIsAnimated:(BOOL)isAnimated;

- (void)searchButtonAction;
- (void)recommdSearchBarSetWithRect:(CGRect)rect;

- (void)testHud;

- (void)imageTakePhoto;


@end
