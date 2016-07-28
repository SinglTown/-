//
//  KindStrategyDetailsVC.m
//  GiftPretty
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "KindStrategyDetailsVC.h"
#import "UMSocial.h"
@interface KindStrategyDetailsVC ()<UMSocialUIDelegate>
{
   UIWebView *detailsWeb;
   NSURL *url;
   NSTimer *timer;
}
@end

@implementation KindStrategyDetailsVC

- (void)viewDidLoad {
   [super viewDidLoad];
   UIImage *image1 = [UIImage imageNamed:@"back"];
   image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(touchToScan)];
   detailsWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
   detailsWeb.backgroundColor = [UIColor lightGrayColor];
   [self.view addSubview:detailsWeb];
   CGRect frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 2.0f);
   progressView = [[GradientProgressView alloc] initWithFrame:frame];
   [detailsWeb addSubview:progressView];
   [progressView startAnimating];
   [self simulateProgress];
   [self loadDetailsWeb];
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

- (void)loadDetailsWeb
{
   url = [NSURL URLWithString:self.webURL];
   NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
   [detailsWeb loadRequest:request];
}

// 点击导航栏左侧按钮的方法
- (void)touchToScan
{
   [self.navigationController popViewControllerAnimated:YES];
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
