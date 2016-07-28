//
//  LittleGiftstoryVC.m
//  GiftPretty
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 徐东. All rights reserved.
//

#import "LittleGiftstoryVC.h"
#import "NavTitleHelper.h"
@interface LittleGiftstoryVC ()<UIWebViewDelegate>
{
   UIWebView *detailsWeb;
}
@end

@implementation LittleGiftstoryVC

- (void)viewDidLoad {
   [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   UIImage *image1 = [UIImage imageNamed:@"back"];
   image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(touchToScan)];
   [self createTitleView];
   
   detailsWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
   detailsWeb.backgroundColor = [UIColor lightGrayColor];
   [self.view addSubview:detailsWeb];
   [self loadDetailsWeb];
}
- (void)loadDetailsWeb
{
   NSURL *url = [NSURL URLWithString:@"http://www.kadang.com/"];
   NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
   [detailsWeb loadRequest:request];
   detailsWeb.delegate = self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
   [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('container')[0].style.display = 'none'"];
}

// 设置导航栏的标题方法
- (void)createTitleView
{
   UILabel *label = [[NavTitleHelper SharedNavTitleHelper] createNavTitleView:@"发现礼物"];
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
