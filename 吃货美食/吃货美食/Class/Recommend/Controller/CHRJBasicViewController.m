//
//  CHRJBasicViewController.m
//  吃货美食
//
//  Created by scjy on 16/5/13.
//  Copyright © 2016年 赵天. All rights reserved.
//

#import "CHRJBasicViewController.h"
const CGFloat myLat = 34.60522149650738;
const CGFloat myLon = 112.4234234428844;
@interface CHRJBasicViewController ()

@end

@implementation CHRJBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"ms_back_icon2" withSelectImage:@"ms_back_icon2" withHorizontalAlignment:UIControlContentHorizontalAlignmentLeft withTittle:@"返回" withTittleColor:[UIColor redColor] withTarget:self action:@selector(navBackAction) forControlEvents:UIControlEventTouchUpInside];
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
    self.afnManger = [CHHTTPRequestManager manager];
}

- (void)pushToWebViewWithID:(NSNumber *)myID withUrlString:(NSString *)urlString{
    CHRWebViewController * webVC;
    if (urlString) {
        webVC = [[CHRWebViewController alloc]initWithURLString:urlString];
    }else{
        webVC = [[CHRWebViewController alloc]init];
        webVC.webID = myID;
    }
    
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)navBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchButtonAction{
    CHRJSearchViewController * searchVC = [[CHRJSearchViewController alloc]init];
    [self.searchView removeFromSuperview];
    self.searchView = nil;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)recommdSearchBarSetWithRect:(CGRect)rect{
    self.searchView = [[[NSBundle mainBundle]loadNibNamed:@"CHRJSearchView" owner:nil options:nil]lastObject];
    self.searchView.frame = rect;
    [self.searchView.searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.searchView];
}

#pragma mark - MBProgressHUDDelegate
- (void)showHUDWithText:(NSString *)string withTextFont:(UIFont *)font withTextColor:(UIColor *)color withTextSize:(CGSize)textSize withAction:(SEL)method withIsAnimated:(BOOL)isAnimated{
    NSDictionary * attributes = [NSDictionary dicOfTextAttributeWithFont:font withTextColor:color];
    CGRect myRect = [string boundingRectWithSize:textSize options:NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    self.myHUD = [[MBProgressHUD alloc]initWithFrame:myRect];
    self.myHUD.mode= MBProgressHUDModeText;
    self.myHUD.delegate= self;
    self.myHUD.labelText= string;
    [self.view addSubview:self.myHUD];
    [self.myHUD showWhileExecuting:method onTarget:self withObject:nil animated:isAnimated];
}

- (void)hudWasHidden:(MBProgressHUD *)hud{
    [self.myHUD removeFromSuperview];
    self.myHUD = nil;
}

- (void)testHud{
    CHLog(@"Hud Success");
}

#pragma mark -- ImageViewTouch
- (void)imageTakePhoto
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(self)mySelf = self;
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //take photo
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [mySelf myImagePickerWithType:UIImagePickerControllerSourceTypeCamera];
        } else {
            NSLog(@"照片源不可用");
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //to localPhotos
        [mySelf myImagePickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)myImagePickerWithType:(UIImagePickerControllerSourceType)sourceType{
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        [picker setSourceType:sourceType];
        [picker setAllowsEditing:YES];
        [picker setDelegate:self];
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        CHLog(@"照片源不可用");
    }
}
- (void)setChoosedImage:(UIImage *)choosedImage{
    if (!choosedImage)return;
    _choosedImage = choosedImage;
    [self.choosedImagedButton setBackgroundImage:self.choosedImage forState:UIControlStateNormal];
}
- (void)setImageChoosedPath:(NSString *)imageChoosedPath{
    if (!imageChoosedPath)return;
    _imageChoosedPath = imageChoosedPath;
    self.choosedImagedButton.myImagePath = imageChoosedPath;
}
#pragma mark - ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.choosedImage = info[@"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSDate * date = [NSDate date];
        dateFormatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *dateStr = [dateFormatter stringFromDate:date];
        self.imageChoosedPath = [docs[0]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.png",dateStr,self.tagStr]];
        NSData *imageData = UIImagePNGRepresentation(self.choosedImage);
        [imageData writeToFile:self.imageChoosedPath atomically:YES];
    });
}
@end
