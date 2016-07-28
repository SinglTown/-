//
//  IndexDetailsViewController.m
//  GiftPretty
//
//  Created by lanou3g on 15/9/29.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "IndexDetailsViewController.h"
#import "NavTitleHelper.h"
#import "downLoadData.h"
#import "IndexDetails.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"
@interface IndexDetailsViewController ()<UMSocialUIDelegate>
{
   UIImageView *imageV;
   UIWebView *detailsWeb;
   NSString *str;
   NSURL *url;
   NSTimer *timer;
}
@property (nonatomic, strong)NSMutableArray *detailsArray;
@end

@implementation IndexDetailsViewController




- (void)viewDidLoad {
   [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   [self createTitleView];
   UIImage *image1 = [UIImage imageNamed:@"back"];
   image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(touchToScan)];
   
   
   [self downLoadThisPage];
   
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Destination_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(share)];
   timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(dismissTheProgressView) userInfo:nil repeats:NO];
}
- (void)dismissTheProgressView
{
   [progressView stopAnimating];
   [progressView removeFromSuperview];
}


- (void)simulateProgress {
   
   double delayInSeconds = 0.5;
   dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
   dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      
      CGFloat increment = (arc4random() % 5) / 10.0f + 0.1;
      CGFloat progress  = [progressView progress] + increment;
      [progressView setProgress:progress];
      if (progress < 1.0) {
         
         [self simulateProgress];
      }
      
   });
   
}

#pragma mark - 友盟分享
- (void)share
{
   [UMSocialSnsService presentSnsIconSheetView:self
                                        appKey:@"561f893a67e58efd920006da"
                                     shareText:[NSString stringWithFormat:@"%@",url]
                                    shareImage:[UIImage imageNamed:@"icon.png"]
                               shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren, UMShareToDouban, nil]
                                      delegate:self];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
   [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
}

// 设置导航栏的标题方法
- (void)createTitleView
{
   UILabel *label = [[NavTitleHelper SharedNavTitleHelper] createNavTitleView:@"攻略详情"];
   [self.view addSubview: label];
   self.navigationItem.titleView = label;
}
// 点击导航栏左侧按钮的方法
- (void)touchToScan
{
   [self.navigationController popViewControllerAnimated:YES];
}

// 视图将要出现时隐藏tabBar
- (void)viewWillAppear:(BOOL)animated

{
   [super viewWillAppear:animated];
   self.tabBarController.tabBar.hidden=YES;
}

// 视图将要消失时显示tabBar
- (void)viewWillDisappear:(BOOL)animated
{
   [super viewWillDisappear:animated];
   self.tabBarController.tabBar.hidden=NO;
}

// 解析
- (void)downLoadThisPage
{
   // 创建downLoad对象
   downLoadData *downLoad = [[downLoadData alloc] init];
   // 设置代理
   str = [NSString stringWithFormat:@"%@%@",kGiftClickCellDetails,self.ID];
   [downLoad downLoadDataWithUrlString:str];
   downLoad.result = ^(NSData *data, BOOL isNetworking) {
      if (isNetworking) {
         NSError *error = nil;
         NSDictionary *allDataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         NSDictionary *resultDic = [allDataDic objectForKey:@"data"];
         
         IndexDetails *details = [[IndexDetails alloc] init];
         //movie.movieName = [dic objectForKey:@"movieName"];
         //movie.movieId = [dic objectForKey:@"movieId"];
         //movie.pic_url = [dic objectForKey:@"pic_url"];
         details.cover_image_url = [resultDic objectForKey:@"cover_image_url"];
         details.content_html = [resultDic objectForKey:@"content_html"];
         details.content_url = [resultDic objectForKey:@"content_url"];
         [self.detailsArray addObject:details];
         [self createImageView];
      } else {
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请检查网络！" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
         }];
         [alert addAction:action];
         [self presentViewController:alert animated:YES completion:nil];
      }
   };
   
}

// 创建一个视图展示攻略图片&&创建webView视图
- (void)createImageView
{
   imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,100)];
   IndexDetails *details = [_detailsArray lastObject];
   [imageV sd_setImageWithURL:[NSURL URLWithString:details.cover_image_url]];
   [self.view addSubview:imageV];
   
   detailsWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 100)];
   detailsWeb.backgroundColor = [UIColor lightGrayColor];
   [self.view addSubview:detailsWeb];
   
   CGRect frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 2.0f);
   progressView = [[GradientProgressView alloc] initWithFrame:frame];
   [detailsWeb addSubview:progressView];
   [progressView startAnimating];
   [self simulateProgress];
   
   url = [NSURL URLWithString:details.content_url];
   NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
   [detailsWeb loadRequest:request];
   
   // 设置点击手势
   UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchMe)];
   // 添加手势到视图
   [self.view addGestureRecognizer:tap];
   // 设置点击次数
   tap.numberOfTapsRequired = 1;
}

// 点击手势的方法
- (void)touchMe
{
   
   
}




// 懒加载
- (NSMutableArray *)detailsArray
{
   if (!_detailsArray) {
      self.detailsArray = [NSMutableArray array];
   }
   return _detailsArray;
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
