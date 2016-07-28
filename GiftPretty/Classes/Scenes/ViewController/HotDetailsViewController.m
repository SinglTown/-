//
//  HotDetailsViewController.m
//  GiftPretty
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "HotDetailsViewController.h"
#import "downLoadData.h"
#import "HotDetailModal.h"
#import "UMSocial.h"
@interface HotDetailsViewController ()<UIWebViewDelegate,UMSocialUIDelegate>
{
   UIWebView *detailsWeb;
   NSURL *url;
   NSTimer *timer;
}

@property (nonatomic, strong)NSMutableArray *hotDetailsArray;
@end

@implementation HotDetailsViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   UIImage *image1 = [UIImage imageNamed:@"back"];
   image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(touchToBack)];
   [self downLoadThePage];
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Destination_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(share)];
   timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(dismissTheProgressView) userInfo:nil repeats:NO];
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

// 点击导航栏左侧按钮的方法
- (void)touchToBack
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
- (void)downLoadThePage
{
   // 创建downLoad对象
   downLoadData *downLoad = [[downLoadData alloc] init];
   NSString *str = [NSString stringWithFormat:@"%@%ld",kGiftHotDetailURL,(long)self.ID];
   [downLoad downLoadDataWithUrlString:str];
   downLoad.result = ^(NSData *data, BOOL isNetworking) {
      if (isNetworking) {
         NSError *error = nil;
         NSDictionary *allDataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         NSDictionary *resultDic = [allDataDic objectForKey:@"data"];
         HotDetailModal *hotDetailModal = [[HotDetailModal alloc] init];
         hotDetailModal.purchase_url = [resultDic objectForKey:@"purchase_url"];
         hotDetailModal.url = [resultDic objectForKey:@"url"];
         // 把网址装进数组
         [self.hotDetailsArray addObject:hotDetailModal];
         //NSLog(@"%@",hotDetailModal.url);
         [self createHotDetailsWeb];
      } else {
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请检查网络！" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
         }];
         [alert addAction:action];
         [self presentViewController:alert animated:YES completion:nil];
      }
   };
   
}
// 请求网址
- (void)createHotDetailsWeb
{
   HotDetailModal *hotDetailModal = [_hotDetailsArray lastObject];
   detailsWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
   detailsWeb.backgroundColor = [UIColor lightGrayColor];
   [self.view addSubview:detailsWeb];
   detailsWeb.delegate = self;
   CGRect frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 2.0f);
   progressView = [[GradientProgressView alloc] initWithFrame:frame];
   [detailsWeb addSubview:progressView];
   [progressView startAnimating];
   [self simulateProgress];
   url = [NSURL URLWithString:hotDetailModal.purchase_url];
   NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
   [detailsWeb loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
   [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByID('top')[0].style.display = 'none'"];
}

// 懒加载
- (NSMutableArray *)hotDetailsArray
{
   if (!_hotDetailsArray) {
      self.hotDetailsArray = [NSMutableArray array];
   }
   return _hotDetailsArray;
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
