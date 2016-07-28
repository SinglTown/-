//
//  BeautifulDetailsViewController.m
//  GiftPretty
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "BeautifulDetailsViewController.h"
#import "NavTitleHelper.h"

@interface BeautifulDetailsViewController ()
{
   UIWebView *detailsWeb;
   NSTimer *timer;
}
@end

@implementation BeautifulDetailsViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   [self createTitleView];
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

- (void)loadDetailsWeb
{
   NSURL *url = [NSURL URLWithString:self.webURL];
   NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
   [detailsWeb loadRequest:request];
}
// 设置导航栏的标题方法
- (void)createTitleView
{
   UILabel *label = [[NavTitleHelper SharedNavTitleHelper] createNavTitleView:@"每日十件美好小物"];
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
