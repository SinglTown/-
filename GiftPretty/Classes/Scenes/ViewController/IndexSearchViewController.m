//
//  IndexSearchViewController.m
//  GiftPretty
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "IndexSearchViewController.h"
#import "NavTitleHelper.h"
#import "UMSocial.h"
@interface IndexSearchViewController ()<UIWebViewDelegate,UMSocialUIDelegate>
{
   UIWebView *detailsWeb;
   NSURL *url;
}
@end

@implementation IndexSearchViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   [self createTitleView];
   UIImage *image1 = [UIImage imageNamed:@"back"];
   image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(touchToScan)];
   detailsWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
   detailsWeb.backgroundColor = [UIColor lightGrayColor];
   [self.view addSubview:detailsWeb];
   detailsWeb.delegate = self;
   [self loadDetailsWeb];
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Destination_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(share)];
   
//   UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
//   imageV.frame = CGRectMake(self.view.frame.size.width - 50, 0, 50, 45);
//   imageV.backgroundColor = [UIColor orangeColor];
//   [detailsWeb addSubview:imageV];
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
- (void)loadDetailsWeb
{
   url = [NSURL URLWithString:kGiftSearchURL];
   NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
   [detailsWeb loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
   [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('nav_links')[0].style.display = 'none'"];
}

// 设置导航栏的标题方法
- (void)createTitleView
{
   UILabel *label = [[NavTitleHelper SharedNavTitleHelper] createNavTitleView:@"礼物搜"];
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
